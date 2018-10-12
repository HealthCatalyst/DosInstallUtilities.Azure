$module = Get-Module -Name "DosInstallUtilities.Azure"
$module | Select-Object *

$params = @{
    'Author' = 'Health Catalyst'
    'CompanyName' = 'Health Catalyst'
    'Description' = 'Functions to configure Azure'
    'NestedModules' = 'DosInstallUtilities.Azure'
    'Path' = ".\DosInstallUtilities.Azure.psd1"
}

New-ModuleManifest @params
