<#
.SYNOPSIS
KeyVaultSecrets

.DESCRIPTION
KeyVaultSecrets

.INPUTS
KeyVaultSecrets - The name of KeyVaultSecrets

.OUTPUTS
None

.EXAMPLE
KeyVaultSecrets

.EXAMPLE
KeyVaultSecrets


#>
function KeyVaultSecretsDummy()
{
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'Globals: Starting'

    Write-Verbose 'Globals: Done'

}

[hashtable] $KeyVaultSecrets = @{
    internalLoadbalancerSubnet = "internalLoadbalancerSubnet"
    internalLoadbalancerIP = "internalLoadbalancerIP"
    SslCertificate = "SslCertificate"
    SslIntermediateCertificate = "SslIntermediateCertificate"
    externalLoadbalancerSubnet = "externalLoadbalancerSubnet"
    externalLoadbalancerIP = "externalLoadbalancerIP"
    dnsNamePrefix = "dnsNamePrefix"
    customerid = "customerid"
    dnshostname = "dnshostname"
    storageName = "storageName"
    storageKey = "storageKey"
    servicePrincipalClientId = "servicePrincipalClientId"
    servicePrincipalClientSecret = "servicePrincipalClientSecret"
    tenantId = "tenantId"
    smtpRelayKey = "smtpRelayKey"
    notificationSlackUrl = "notificationSlackUrl"
}

Export-ModuleMember -Variable KeyVaultSecrets