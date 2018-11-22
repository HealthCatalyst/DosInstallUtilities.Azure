<#
.SYNOPSIS
WriteDNSCommands

.DESCRIPTION
WriteDNSCommands

.INPUTS
WriteDNSCommands - The name of WriteDNSCommands

.OUTPUTS
None

.EXAMPLE
WriteDNSCommands

.EXAMPLE
WriteDNSCommands


#>
function WriteDNSCommands()
{
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'WriteDNSCommands: Starting'
    Set-StrictMode -Version latest
    $ErrorActionPreference = 'Stop'

    [hashtable]$Return = @{}

    [string[]] $myCommands = $(GetDNSCommands).Commands
    Write-Host "To setup DNS entries in CAFE environment, remote desktop to CAFE DNS server: 10.5.2.4"
    Write-Host "Open Powershell window As Administrator and paste the following:"
    Write-Host "--------------------- CUT BELOW -------------------------"
    ForEach ($myCommand in $myCommands) {
        Write-Host $myCommand
    }
    Write-Host ""
    Write-Host "--------------------- CUT ABOVE -------------------------"

    Write-Host ""
    Write-Verbose 'WriteDNSCommands: Done'

    return $Return
}

Export-ModuleMember -Function 'WriteDNSCommands'