
function Update-NugetPackage {
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline)]
        [string]$SourcePath = ".",
        [string]$RepositoryPath,
        [parameter()]
        [string]$Filter = "*",
        [string]$sources = ((Get-PackageSourceLocations Nuget) -join ";")
    )
    # Update-NugetPackagesConfig $SourcePath $RepositoryPath $Filter $sources
    
    $projects=Get-ChildItem $SourcePath *.csproj -Recurse 
    $packages=$projects|ForEach-Object{
        [xml]$csproj=Get-Content $_.FullName
        $csproj.Project.ItemGroup.PackageReference.Include|Where-Object{$_ -and $_ -like $Filter}
    }|Sort-object -Unique
    $metadata=$packages|ForEach-Object{
        Get-NugetPackageSearchMetadata $_ $sources
    }
    $projects|ForEach-Object{
        $csprojPath=$_.FullName
        Write-host "Checking $csprojPath" -f blue
        [xml]$csproj=Get-Content $csprojPath
        $csproj.Project.ItemGroup.PackageReference|Where-Object{$_.Include -and $_.Include -like $Filter}|ForEach-Object{
            $p=$_.Include
            $m=$metadata|Where-Object{$_.Identity.Id -eq $p}
            $latestVersion = (Get-NugetPackageMetadataVersion $m).version
            $installedVersion=$_.Version
            if ($latestVersion -ne $installedVersion){
                Write-host "Updating $p $installedVersion to $latestVersion" -f Green
                dotnet add $csprojPath package $p -v $latestVersion -s $sources|Write-Verbose
            }
        }
    }
}

function Update-NugetPackagesConfig {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline)]
        [string]$SourcePath = ".",
        [string]$RepositoryPath,
        [parameter()]
        [string]$Filter = "*",
        [string]$sources = ((Get-PackageSourceLocations Nuget) -join ";")
    )
    
    begin {
    }
    
    process {
        $configs = Get-ChildItem $sourcePath packages.config -Recurse | ForEach-Object {
            [PSCustomObject]@{
                Content = [xml]$(Get-Content $_.FullName)
                Config  = $_
            }
        }
    
        $metadatas = $configs.Content.packages.package.id | Where-Object { $_ -like $Filter } | Select-Object -Unique | Get-NugetPackageSearchMetadata -Source $sources
        $metadatas | ForEach-Object {
            [PSCustomObject]@{
                Title   = $_.Title
                Version = $_.Identity.Version.Version
            }
        }
        $packages = $configs | ForEach-Object {
            $_.Config.FullName
            $config = $_.Config
            $_.Content.packages.package | Where-Object { $_.id -like $filter } | ForEach-Object {
                $packageId = $_.Id
                $metadata = $metadatas | Where-object { $_.Identity.Id -eq $packageId }
                if ($metadata) {
                    $csproj = Get-ChildItem $config.DirectoryName *.csproj | Select -first 1
                    $latestVersion = (Get-NugetPackageMetadataVersion $metadata).version
                    [PSCustomObject]@{
                        Id         = $packageId
                        NewVersion = $latestVersion
                        Config     = $config.FullName
                        csproj     = $csproj.FullName
                        Version    = $_.Version
                    }
                }
            }
        } | Where-Object { $_.NewVersion -and ($_.Version -ne $_.NewVersion) }
        $sortedPackages = $packages | Group-Object Config | ForEach-Object {
            $p = [PSCustomObject]@{
                Packages = ($_.Group | Sort-PackageByDependencies)
            }
            $p
        } 
    
    
        $sortedPackages | Invoke-Parallel -activityName "Update all packages" -VariablesToImport @("RepositoryPath", "sources") -Script {
            ($_.Packages | ForEach-Object {
                    if ($RepositoryPath) {
                        & (Get-NugetPath) Update $_.Config -Id $_.Id -Version $($_.NewVersion) -Source $sources -NonInteractive -RepositoryPath $RepositoryPath
                    }
                    else {
                        & (Get-NugetPath) Update $_.Config -Id $_.Id -Version $($_.NewVersion) -Source $sources -NonInteractive 
                    }
            
                })
        }
    }
    
    end {
    }
}

function Sort-PackageByDependencies {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline, Mandatory)]
        $psObj
    )
    begin {
        $all = New-Object System.Collections.ArrayList
    }
    
    process {
        $all.Add($psObj) | Out-Null
    }
    
    end {
        $list = New-Object System.Collections.ArrayList
        
        while ($all.Count) {
            $all | ForEach-Object {
                $obj = $_
                $deps = $obj.Metadata.Metadata.DependencySets.Packages | select -ExpandProperty Id
                $exist = $all | Select-Object -ExpandProperty Id | Where-Object { $deps -contains $_ }
                if (!$exist) {
                    $list.Add($obj) | out-null
                }
            }
            $list | ForEach-Object {
                $all.Remove($_) | out-null
            }
        }
        $list | ForEach-Object { $_ }
    }
}



