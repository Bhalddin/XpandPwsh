function Get-AzTestRuns {
    [CmdletBinding()]
    [CmdLetTag(("#Azure","AzureDevOps"))]
    param (
        [switch]$FailedOnly,
        [string]$runTitle,
        [int[]]$buildIds,
        [parameter(ValueFromPipeline)]
        [ArgumentCompleter( {
                param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
                (Get-AzDefinition | Where-Object { $_.name -like "$wordToComplete*" }).Name
            })]
        [string[]]$Definition,
        [int]$Top,
        [int]$Skip,
        [datetime]$minLastUpdatedDate=[datetime]::Now.AddDays(-6),
        [datetime]$maxLastUpdatedDate=[datetime]::Now,
        [ValidateSet("aborted","completed","inProgress","needsInvestigation","notStarted","unspecified","waiting")]
        [string]$State,
        [string]$branchName,
        [string]$Project = $env:AzProject,
        [string]$Organization = $env:AzOrganization,
        [string]$Token = $env:AzDevopsToken
    )
    
    begin {
        if ($buildIds.Count -gt 10){
            throw "buildsIds count should not be more than 10"
        }
        $cred = @{
            Project      = $Project
            Organization = $Organization
            Token        = $Token
        }
    }
    
    process {
        $query = ConvertTo-HttpQueryString @{
            minLastUpdatedDate=$minLastUpdatedDate
            maxLastUpdatedDate=$maxLastUpdatedDate
            '$top' = $top
            '$skip' = $Skip
            runTitle=$runTitle
            buildIds=($buildIds -join ",")
            buildDefIds=(($Definition|Where-Object{$_}|Get-AzDefinition).id -join ",")
            State=$State
            branchName=$branchName
        }
        (Invoke-AzureRestMethod "test/runs$query" @cred)|where-object{
            !$FailedOnly -or ($_.runStatistics|Where-Object{$_.outcome -eq "failed"})
        }
    }
    
    end {
        
    }
}