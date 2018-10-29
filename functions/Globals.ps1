<#
.SYNOPSIS
Globals

.DESCRIPTION
Globals

.INPUTS
Globals - The name of Globals

.OUTPUTS
None

.EXAMPLE
Globals

.EXAMPLE
Globals


#>
function GlobalsDummy()
{
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'Globals: Starting'

    Write-Verbose 'Globals: Done'

}

[hashtable] $globals = @{
    resourceGroup = "fabrickubernetes4"
    realtimePackageUrl = "https://raw.githubusercontent.com/HealthCatalyst/helm.realtime/master/fabricrealtime-1.1.0.tgz"
    helmInstallUrl = "https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-windows-amd64.zip"
    externalLoadBalancerLabel = "k8s-app-external"
    externalLoadBalancerLabelValue = "nginx"
    internalLoadBalancerLabel = "k8s-app-internal"
    internalLoadBalancerLabelValue = "nginx"
    internalLoadBalancerLabelSelector = "k8s-app-internal=nginx"
    externalLoadBalancerLabelSelector = "k8s-app-external=nginx"
}

Export-ModuleMember -Variable globals
