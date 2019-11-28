function Get-AzDefinition {
    [CmdletBinding()]
    param (
        $FilterName="*",
        [string]$Project=$env:AzProject,
        [string]$Organization=$env:AzOrganization
    )
    
    begin {
        
    }
    
    process {
        Invoke-AzureRestMethod "Build/definitions" -Organization $Organization -Project $Project
    }
    
    end {
        
    }
}