<#
.SYNOPSIS
GetResourceGroupFromSecret

.DESCRIPTION
GetResourceGroupFromSecret

.INPUTS
GetResourceGroupFromSecret - The name of GetResourceGroupFromSecret

.OUTPUTS
None

.EXAMPLE
GetResourceGroupFromSecret

.EXAMPLE
GetResourceGroupFromSecret


#>
function GetResourceGroupFromSecret()
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
    )

    Write-Verbose 'GetResourceGroupFromSecret: Starting'

    ReadSecretData -secretname "azure-secret" -valueName "resourcegroup" -namespace "default"

    Write-Verbose 'GetResourceGroupFromSecret: Done'
}

Export-ModuleMember -Function 'GetResourceGroupFromSecret'