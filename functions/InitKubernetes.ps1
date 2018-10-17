<#
.SYNOPSIS
InitKubernetes

.DESCRIPTION
InitKubernetes

.INPUTS
InitKubernetes - The name of InitKubernetes

.OUTPUTS
None

.EXAMPLE
InitKubernetes

.EXAMPLE
InitKubernetes


#>
function InitKubernetes() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $subscriptionName
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
    )

    Write-Verbose 'InitKubernetes: Starting'

    LoginToAzure

    SetCurrentAzureSubscription -subscriptionName $subscriptionName

    # SetStorageAccountNameIntoSecret -resourceGroup $resourceGroup -customerid $customerid

    # kubectl get "deployments,pods,services,ingress,secrets" --namespace="default" -o wide
    # kubectl get "deployments,pods,services,ingress,secrets" --namespace=kube-system -o wide

    InitHelm

    $keyVaultName = $(Get-KeyVaultName -resourceGroup $resourceGroup).Name
    AssertStringIsNotNullOrEmpty $keyVaultName

    $customerid = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.internalLoadbalancerSubnet)
    $ExternalIp = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.externalLoadbalancerIP)
    $ExternalSubnet = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.externalLoadbalancerSubnet)
    $InternalIP = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.internalLoadbalancerIP)
    $InternalSubnet = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.internalLoadbalancerSubnet)

    if ($ExternalIP) {
        $clusterName = "Kluster-$resourceGroup"
        $resourceGroupOfAks = $(az aks show --resource-group $resourceGroup --name "$clusterName" --query nodeResourceGroup -o tsv)

        $ExternalIP = $(az network public-ip list --resource-group "$resourceGroupOfAks" --query [0].ipAddress --output tsv)
    }

    SetupLoadBalancer `
        -ExternalIP $ExternalIP `
        -ExternalSubnet $ExternalSubnet `
        -InternalIP $InternalIP `
        -InternalSubnet $InternalSubnet `
        -customerid $customerid

    Write-Verbose 'InitKubernetes: Done'
}

Export-ModuleMember -Function 'InitKubernetes'