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

    [int[]] $myPortArray = 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8012, 8013, 8014, 8015, 8016, 8017, 8018, 8019, 8020, 8021, 8022, 8023, 8024, 8025, 8026, 8027, 8028, 8029, 8030, 8031, 8032, 8033, 8034, 8035, 8036, 8037, 8038, 8039
    [int] $port = $(Find-OpenPort -portArray $myPortArray).Port
    Write-Host "Starting Aks Dashboard on port $port"

    $sb = [scriptblock]::Create("az aks browse --resource-group $resourceGroup --name $clusterName --listen-port $port")
    $job = Start-Job -Name "KubDashboard" -ScriptBlock $sb -ErrorAction Stop
    Wait-Job $job -Timeout 5;
    Write-Host "job state: $($job.state)"
    Receive-Job -Job $job 6>&1
    # Start-AzureRmAksDashboard -ResourceGroupName $resourceGroup -Name "$clusterName"

    Write-Verbose 'LaunchAksDashboard: Done'
}

Export-ModuleMember -Function 'LaunchAksDashboard'