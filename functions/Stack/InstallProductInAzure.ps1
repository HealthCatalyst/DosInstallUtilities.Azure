<#
.SYNOPSIS
InstallProductInAzure

.DESCRIPTION
InstallProductInAzure

.INPUTS
InstallProductInAzure - The name of InstallProductInAzure

.OUTPUTS
None

.EXAMPLE
InstallProductInAzure

.EXAMPLE
InstallProductInAzure


#>
function InstallProductInAzure() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $namespace
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $packageUrl
        ,
        [Parameter(Mandatory = $true)]
        [bool]
        $local
    )

    Write-Verbose 'InstallProductInAzure: Starting'

    Write-Host "Installing product from $packageUrl into $namespace"

    InstallStackInAzure `
        -namespace $namespace `
        -package $namespace `
        -packageUrl $packageUrl `
        -local $local `
        -isAzure $true `
        -Verbose

    Write-Verbose 'InstallProductInAzure: Done'
}

Export-ModuleMember -Function 'InstallProductInAzure'