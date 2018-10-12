$PSVersionTable

Import-Module PackageManagement
# Find-Package Pester

# Install-Module Pester -Force

Remove-Module "DosInstallUtilities.Azure"
Import-Module "$PSScriptRoot\DosInstallUtilities.Azure.psd1"

Write-Host "Loaded module"

# Install-Module -Name AzureRM -AllowClobber