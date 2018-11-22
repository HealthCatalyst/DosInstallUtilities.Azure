<#
.SYNOPSIS
GetDNSCommands

.DESCRIPTION
GetDNSCommands

.INPUTS
GetDNSCommands - The name of GetDNSCommands

.OUTPUTS
None

.EXAMPLE
GetDNSCommands

.EXAMPLE
GetDNSCommands


#>
function GetDNSCommands()
{
    [CmdletBinding()]
    [OutputType([hashtable])]
    param
    (
    )

    Write-Verbose 'GetDNSCommands: Starting'
    Set-StrictMode -Version latest
    $ErrorActionPreference = 'Stop'

    [hashtable]$Return = @{}

    [string[]] $myCommands = @()

    [hashtable] $loadBalancerIps = $(GetLoadBalancerIPs)

    [string] $dnshostname = $(ReadSecretValue -secretname dnshostname -namespace "default")
    AssertStringIsNotNullOrEmpty -text $dnshostname

    [string[]] $dnshostnameparts = $dnshostname.Split('.')
    [string] $customerid = $dnshostnameparts[0]
    AssertStringIsNotNullOrEmpty -text $customerid
    $customerid = $customerid.ToLower().Trim()

    if(3 -eq $dnshostnameparts.Count){
        [string] $domain = "$($dnshostnameparts[1]).$($dnshostnameparts[2])"
    }
    else {
        [string] $domain = 'healthcatalyst.net'
    }

    # first get DNS entries for internal facing services
    [string] $loadBalancerInternalIP = $loadBalancerIps.InternalIP

    $myCommands += "dnscmd cafeaddc-01.cafe.healthcatalyst.com /recorddelete $domain internal.$customerid A /f"
    $myCommands += "dnscmd cafeaddc-01.cafe.healthcatalyst.com /recordadd $domain internal.$customerid A $loadBalancerInternalIP"

    # now get DNS entries for external facing services
    [string] $loadBalancerExternalIP = $loadBalancerIps.ExternalIP

    $myCommands += "dnscmd cafeaddc-01.cafe.healthcatalyst.com /recorddelete $domain $customerid A /f"
    $myCommands += "dnscmd cafeaddc-01.cafe.healthcatalyst.com /recordadd $domain $customerid A $loadBalancerExternalIP"

    $Return.Commands = $myCommands

    Write-Verbose 'GetDNSCommands: Done'
    return $Return
}

Export-ModuleMember -Function 'GetDNSCommands'