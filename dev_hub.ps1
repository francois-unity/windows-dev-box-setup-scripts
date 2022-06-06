# Description: Boxstarter Script
# Author: Microsoft
# Common settings for hub development

# Open this url from edge to start the installation:
# https://boxstarter.org/launch/Boxstarter.WebLaunch.application?noreboot=1&package=https://raw.githubusercontent.com/francois-unity/windows-dev-box-setup-scripts/master/dev_hub.ps1

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";

#--- Tools ---
$Packages = 'microsoft-windows-terminal', 'nvm', 'nodejs-lts', 'python2'
ForEach ($PackageName in $Packages)
{
    choco install $PackageName -y
}

Enable-UAC
Enable-MicrosoftUpdate

Read-Host -Prompt "Installation done, launch windows terminal as administrator and run the second install script (dev_hub-env.ps1). Press Enter to exit"