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
function Globals()
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
    loadbalancerPackageUrl = "https://raw.githubusercontent.com/HealthCatalyst/helm.loadbalancer/master/fabricloadbalancer-1.0.0.tgz"
    realtimePackageUrl = "https://raw.githubusercontent.com/HealthCatalyst/helm.realtime/master/fabricrealtime-1.0.0.tgz"
}

Export-ModuleMember -Variable globals