$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Set-StrictMode -Version Latest

# Set-Location $naPath

$ErrorActionPreference = "Stop"

Import-Module Pester

$VerbosePreference = "continue"

$module = "DosInstallUtilities.Kube"
Get-Module "$module" | Remove-Module -Force

Import-Module "$here\..\$module\$module.psm1" -Force

Invoke-Pester "$here\..\$module\Module.Tests.ps1"

$module = "DosInstallUtilities.Azure"
Get-Module "$module" | Remove-Module -Force

Import-Module "$here\$module.psm1" -Force

Invoke-Pester "$here\Module.Tests.ps1"
