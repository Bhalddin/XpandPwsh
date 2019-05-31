#
# Module manifest for module 'XpandPosh'
#
# Generated by: eXpamdFramework
#
# Generated on: 1/23/2019
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'XpandPosh'

    # Version number of this module.
    ModuleVersion     = '2.8.0'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID              = 'e007792d-aaa4-4dd4-93e6-96772313932c'

    # Author of this module
    Author            = 'eXpamdFramework'

    # Company or vendor of this module
    CompanyName       = 'eXpamdFramework'

    # Copyright statement for this module
    Copyright         = '(c) 2019 eXpamdFramework. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Various functions working with DevExpress XAF, eXpandFramework and not only'

    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = ''

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    DotNetFrameworkVersion = '4.7.1'

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @("XpandPosh\Public\NugetSearch.dll")

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules = @("Cmdlets\bin\XpandPosh.Cmdlets.dll")

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        "New-AssemblyResolver",
        "Use-MonoCecil",
        "Get-XpandReleaseChange",
        "Update-OutputPath",
        "Update-ProjectAutoGenerateBindingRedirects",
        "Update-ProjectProperty",
        "Remove-ProjectLicenseFile",
        "Update-ProjectSign",
        "Update-ProjectDebugSymbols",
        "Update-ProjectLanguageVersion",
        "Invoke-AzureRestMethod",
        "Install-DebugOptimizationHook",
        "Publish-AssemblyToGac",
        "Compress-Project",
        "Test-Symbol",
        "Get-SymbolSources",
        "Find-XpandPackage",
        "Clear-NugetCache",
        "Get-XmlContent",
        "Update-ProjectTargetFramework",
        "Get-MsBuildPath",
        "Get-NugetPath",
        "Get-GitLastSha", 
        "Clear-ASPNETTemp", 
        "Clear-ProjectDirectories", 
        "Install-Chocolatey", 
        "Remove-ProjectNuget", 
        "Compress-Files", 
        "Compress-ProjectFolder"
        "Uninstall-ProjectAllPackages", 
        "Uninstall-ProjectXAFPackages", 
        "Update-ProjectPackage", 
        "ConvertTo-Object", 
        "Restore-ProjectPackages", 
        "New-Command", 
        "Get-AssemblyInfoVersion", 
        "Disable-ExecutionPolicy", 
        "Get-MsBuildLocation", 
        "Get-AllParameters", 
        "Get-ScriptVariables", 
        "Write-HostHashtable", 
        "Get-DXPath", 
        "Get-DevExpressVersion", 
        "Get-RelativePath", 
        "Get-XpandVersion", 
        "Update-AssemblyInfoVersion", 
        "Update-AssemblyInfo", 
        "Invoke-Retry", 
        "Install-Devexpress",
        "Get-PackageSourceLocations",
        "Set-VsoVariable",
        "Update-NugetPackage",
        "UnPublish-NugetPackage",
        "Update-Symbols",
        "Get-PackageFeed",
        "Get-CallerPreference",
        "Update-HintPath",
        "Get-DxNugets",
        "Install-Xpand",
        "UnInstall-Xpand",
        "Get-XpandPath",
        "Use-NugetAssembly",
        "Install-SubModule",
        "Get-NugetPackageVersion",
        "Get-DotnetCoreVersion",
        "Get-NUgetPackageMetadataVersion",
        "ConvertTo-PackageObject",
        "Publish-NugetPackage",
        "Get-ChocoPackage",
        "Invoke-Parallel"
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    # CmdletsToExport   = @("bin\NugetSearch.dll")

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @("eXpandFramework", "DevExpress", "nuget","XAF","srcsrv")

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/eXpandFramework/XpandPosh/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/eXpandFramework/XpandPosh'

            # A URL to an icon representing this module.
            IconUri    = 'http://expandframework.com/images/site/eXpand-Sign.png'

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}






































































































































