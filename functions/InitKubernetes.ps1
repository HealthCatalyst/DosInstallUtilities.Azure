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

    Set-StrictMode -Version latest
    # stop whenever there is an error
    $ErrorActionPreference = "Stop"

    # LoginToAzure

    # SetCurrentAzureSubscription -subscriptionName $subscriptionName

    [string] $clusterName = $(GetClusterName -resourceGroup $resourceGroup).ClusterName

    # GetClusterCredentials -resourceGroup $resourceGroup -clusterName $clusterName

    AskForPasswordAnyCharacters -secretname "smtprelaypassword" -prompt "Please enter SMTP relay password" -namespace "default"

    # kubectl get "deployments,pods,services,ingress,secrets" --namespace="default" -o wide
    # kubectl get "deployments,pods,services,ingress,secrets" --namespace=kube-system -o wide

    InitHelm

    $keyVaultName = $(Get-KeyVaultName -resourceGroup $resourceGroup).Name
    AssertStringIsNotNullOrEmpty $keyVaultName

    $customerid = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.internalLoadbalancerSubnet)
    SetStorageAccountNameIntoSecret -resourceGroup $resourceGroup -customerid $customerid

    $dnshostName = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.dnshostname)

    $ExternalIp = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.externalLoadbalancerIP)
    $ExternalSubnet = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.externalLoadbalancerSubnet)
    if ($ExternalIp -eq "auto") {
        $ExternalIp = ""
    }

    $InternalIP = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.internalLoadbalancerIP)
    $InternalSubnet = $(GetKeyVaultSecretValue -keyVaultName $keyVaultName -keyVaultSecretName $KeyVaultSecrets.internalLoadbalancerSubnet)
    if ($InternalIp -eq "auto") {
        $InternalIp = ""
    }

    if ([string]::IsNullOrWhiteSpace($ExternalIP) -and ([string]::IsNullOrWhiteSpace($ExternalSubnet))) {
        $resourceGroupOfAks = $(az aks show --resource-group $resourceGroup --name "$clusterName" --query nodeResourceGroup -o tsv)
        Write-Verbose "ExternalIP not found in secrets so looking for public IP in resource group: $resourceGroupOfAks "

        $ExternalIP = $(az network public-ip list --resource-group "$resourceGroupOfAks" --query [0].ipAddress --output tsv)
        AssertStringIsNotNullOrEmpty $ExternalIP
    }

    SetupLoadBalancer `
        -ExternalIP $ExternalIP `
        -ExternalSubnet $ExternalSubnet `
        -InternalIP $InternalIP `
        -InternalSubnet $InternalSubnet `
        -customerid $customerid `
        -dnshostName $dnshostName `
        -Verbose

    Write-Verbose 'InitKubernetes: Done'
}

Export-ModuleMember -Function 'InitKubernetes'