
function Get-MsBuildLocation{
    if (!(Get-Module -ListAvailable -Name VSSetup)) {
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
        Install-Module VSSetup
    }
    $msbuildPath=Get-VSSetupInstance  | Select-VSSetupInstance -Product Microsoft.VisualStudio.Product.BuildTools -Latest |Select-Object -ExpandProperty InstallationPath
    if (!$msbuildPath){
        throw "VS 2017 build tools not found. Please download from https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017"
    }
    
    if (!(Get-VSSetupInstance  | Select-VSSetupInstance -Product Microsoft.VisualStudio.Product.BuildTools -Require Microsoft.VisualStudio.Component.NuGet.BuildTools -Latest|Select-Object -ExcludeProperty InstallationPath)){
        throw "MsBuild Nuget targets missing. https://stackoverflow.com/questions/47797510/the-getreferencenearesttargetframeworktask-task-was-not-found"
    }
    if (!(Get-VSSetupInstance  | Select-VSSetupInstance -Product Microsoft.VisualStudio.Product.BuildTools -Require Microsoft.VisualStudio.Workload.WebBuildTools -Latest|Select-Object -ExcludeProperty InstallationPath)){
        throw "MsBuild WebBuildTools missing. https://stackoverflow.com/questions/44061932/ms-build-2017-microsoft-webapplication-targets-is-missing"
    }
    join-Path $msbuildPath MSBuild\15.0\Bin\MSBuild.exe
}