# CD in the dir that contain the local repo and run this script in a terminal as administrator

$nodeVersion = $(Get-Content .nvmrc)
nvm install $nodeVersion
nvm use $nodeVersion

# TODO : check if the script is ran in a VM before start setup sync
$userDocumentDir = [Environment]::GetFolderPath("MyDocuments")
$destDirName = "unity-hub"
$excludes = "node_modules","dist","src"
$dirName = "$userDocumentDir\$destDirName"
$sharedDirPath = Read-Host -Prompt "What is the name of the shared mac folder mounted as a network drive (example \"Z\"):"

# TODO: sync host local repo, but only code source files, dependencies and platform specific config files should be excluded
Get-ChildItem $sharedDirPath -Directory | 
    Where-Object{$_.Name -notin $excludes} | 
    Copy-Item -Destination $dirName -Recurse -Force

# Next steps todo :
#   - install dependencies, following: https://github.com/Unity-Technologies/unity-hub/blob/dev/docs/dev-environment-setup.md#windows-2
#    - https://github.com/Unity-Technologies/unity-hub/blob/dev/docs/dev-environment-setup.md#install-node-modules