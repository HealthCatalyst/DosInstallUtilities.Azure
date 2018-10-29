<#
.SYNOPSIS
GetServicePrincipalFromKeyVault

.DESCRIPTION
GetServicePrincipalFromKeyVault

.INPUTS
GetServicePrincipalFromKeyVault - The name of GetServicePrincipalFromKeyVault

.OUTPUTS
None

.EXAMPLE
GetServicePrincipalFromKeyVault

.EXAMPLE
GetServicePrincipalFromKeyVault


#>
function GetServicePrincipalFromKeyVault()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
    )

    Write-Verbose 'GetServicePrincipalFromKeyVault: Starting'

    [hashtable] $result = @{}

    [string] $result.ServicePrincipalClientId = $(GetKeyInVault -resourceGroup $resourceGroup -key "$($KeyVaultSecrets.servicePrincipalClientId)").Value
    [string] $result.ServicePrincipalClientSecret = $(GetKeyInVault -resourceGroup $resourceGroup -key "$($KeyVaultSecrets.servicePrincipalClientSecret)").Value
    [string] $result.TenantId = $(GetKeyInVault -resourceGroup $resourceGroup -key "$($KeyVaultSecrets.tenantId)").Value

    Write-Verbose 'GetServicePrincipalFromKeyVault: Done'
    return $result
}

Export-ModuleMember -Function 'GetServicePrincipalFromKeyVault'