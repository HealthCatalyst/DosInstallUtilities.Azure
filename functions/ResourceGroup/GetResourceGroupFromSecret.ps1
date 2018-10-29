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

    Set-StrictMode -Version latest
    # stop whenever there is an error
    $ErrorActionPreference = "Stop"


    [hashtable] $result = @{}

    [string] $result.Value = ReadSecretData -secretname "azure-secret" -valueName "resourcegroup" -namespace "default"

    Write-Verbose "GetResourceGroupFromSecret: Done ($($result.Value)"

    return $result
}

Export-ModuleMember -Function 'GetResourceGroupFromSecret'