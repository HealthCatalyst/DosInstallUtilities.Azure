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
function InitKubernetes()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $subscriptionName
        ,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
    )

    Write-Verbose 'InitKubernetes: Starting'

    LoginToAzure

    SetCurrentAzureSubscription -subscriptionName $subscriptionName

    $keyVaultName = $( Get-KeyVaultName -resourceGroup $resourceGroup).Name
    $customerid = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName "dnsNamePrefix")

    SetStorageAccountNameIntoSecret -resourceGroup $resourceGroup -customerid $customerid

    kubectl get "deployments,pods,services,ingress,secrets" --namespace="default" -o wide
    kubectl get "deployments,pods,services,ingress,secrets" --namespace=kube-system -o wide

    $clusterName = "Kluster-$resourceGroup"
    $resourceGroupOfAks=$(az aks show --resource-group $resourceGroup --name "$clusterName" --query nodeResourceGroup -o tsv)

    $externalIP = $(az network public-ip list --resource-group "$resourceGroupOfAks" --query [0].ipAddress --output tsv)

    InitHelm

    SetupLoadBalancer -ExternalIp $externalIP -customerid $customerid

    Write-Verbose 'InitKubernetes: Done'
}

Export-ModuleMember -Function 'InitKubernetes'