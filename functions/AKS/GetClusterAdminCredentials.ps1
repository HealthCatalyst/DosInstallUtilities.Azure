<#
.SYNOPSIS
GetClusterAdminCredentials

.DESCRIPTION
GetClusterAdminCredentials

.INPUTS
GetClusterAdminCredentials - The name of GetClusterAdminCredentials

.OUTPUTS
None

.EXAMPLE
GetClusterAdminCredentials

.EXAMPLE
GetClusterAdminCredentials


#>
function GetClusterAdminCredentials() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $clusterName
    )

    Write-Verbose 'GetClusterAdminCredentials: Starting'

    az aks get-credentials --name $clusterName --resource-group $resourceGroup --admin --overwrite-existing

    Write-Verbose 'Verifying that we can connect to kubernetes cluster'
    kubectl version

    [bool] $result = $?
    if (!$result) {
        Write-Error "Could not connect to kubernetes cluster $clusterName in resource  group $resourceGroup"
    }

    Write-Verbose 'GetClusterAdminCredentials: Done'
}

Export-ModuleMember -Function 'GetClusterAdminCredentials'