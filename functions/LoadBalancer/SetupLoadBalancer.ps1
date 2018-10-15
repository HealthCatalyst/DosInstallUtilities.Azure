<#
  .SYNOPSIS
  SetupLoadBalancer

  .DESCRIPTION
  SetupLoadBalancer

  .INPUTS
  SetupLoadBalancer - The name of SetupLoadBalancer

  .OUTPUTS
  None

  .EXAMPLE
  SetupLoadBalancer

  .EXAMPLE
  SetupLoadBalancer


#>
function SetupLoadBalancer() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ExternalIp
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $customerid
    )

    Write-Verbose 'SetupLoadBalancer: Starting'

    $packageUrl = $globals.loadbalancerPackageUrl
    InstallLoadBalancerHelmPackage `
        -externalIp "$externalip"

    Write-Host "Checking load balancers"
    $loadBalancerIPResult = GetLoadBalancerIPs
    $externalIp = $loadBalancerIPResult.ExternalIP
    $internalIp = $loadBalancerIPResult.InternalIP

    Write-Host "IP for public loadbalancer: [$externalIp], private load balancer: [$internalIp]"

    SaveSecretValue -secretname "dnshostname" -valueName "value" -value $customerid -namespace "default"

    Write-Verbose 'SetupLoadBalancer: Done'
}

Export-ModuleMember -Function "SetupLoadBalancer"