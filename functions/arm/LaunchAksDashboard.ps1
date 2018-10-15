<#
.SYNOPSIS
LaunchAksDashboard

.DESCRIPTION
LaunchAksDashboard

.INPUTS
LaunchAksDashboard - The name of LaunchAksDashboard

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

    $clusterName = "Kluster-$resourceGroup"

    az aks install-cli
    $env:path += 'C:\Users\imran.qureshi\.azure-kubectl'
    # az aks get-credentials --resource-group $resourceGroup --name "$clusterName"

    $env:path

    az aks browse --resource-group $resourceGroup --name $clusterName

    # Start-AzureRmAksDashboard -ResourceGroupName $resourceGroup -Name "$clusterName"

    Write-Verbose 'LaunchAksDashboard: Done'
}

Export-ModuleMember -Function 'LaunchAksDashboard'