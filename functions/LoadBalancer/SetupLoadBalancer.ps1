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
        [AllowEmptyString()]
        [string]
        $ExternalIP
        ,
        [Parameter(Mandatory = $true, HelpMessage="Set this if you want to put the external load balancer in a subnet")]
        [AllowEmptyString()]
        [string]
        $ExternalSubnet
        ,
        [Parameter(Mandatory = $true, HelpMessage="If not set, we will use a random IP from the subnet")]
        [AllowEmptyString()]
        [string]
        $InternalIP
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $InternalSubnet
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $customerid
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $dnshostName
    )

    Write-Verbose 'SetupLoadBalancer: Starting'

    InstallLoadBalancerHelmPackage `
        -ExternalIP $ExternalIP `
        -ExternalSubnet $ExternalSubnet `
        -InternalIP $InternalIP `
        -InternalSubnet $InternalSubnet

    Write-Host "Checking load balancers"
    $loadBalancerIPResult = GetLoadBalancerIPs
    $externalIp = $loadBalancerIPResult.ExternalIP
    $internalIp = $loadBalancerIPResult.InternalIP

    Write-Host "IP for public loadbalancer: [$externalIp], private load balancer: [$internalIp]"

    SaveSecretValue -secretname "dnshostname" -valueName "value" -value $customerid -namespace "default"

    [string] $secret = "certpassword"
    [string] $namespace = "default"
    GenerateSecretPassword -secretname "$secret" -namespace "$namespace"
    [string] $certPassword = $(ReadSecretPassword -secretname "$secret" -namespace "$namespace")
    GenerateCertificates -CertHostName "$dnshostName" -CertPassword $certPassword

    Write-Verbose 'SetupLoadBalancer: Done'
}

Export-ModuleMember -Function "SetupLoadBalancer"