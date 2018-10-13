<#
.SYNOPSIS
LaunchAksDashboard


.DESCRIPTION
LaunchAksDashboard


.INPUTS
LaunchAksDashboard
 - The name of LaunchAksDashboard


.OUTPUTS
None

.EXAMPLE
LaunchAksDashboard


.EXAMPLE
LaunchAksDashboard



#>
function LaunchAksDashboard()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
    )

    Write-Verbose 'LaunchAksDashboard: Starting'

    Start-AzureRmAksDashboard -ResourceGroupName $resourceGroup -Name "Kluster-$resourceGroup"

    Write-Verbose 'LaunchAksDashboard: Done'

}

Export-ModuleMember -Function 'LaunchAksDashboard
'