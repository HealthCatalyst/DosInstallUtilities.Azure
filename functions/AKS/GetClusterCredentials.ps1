<#
.SYNOPSIS
GetClusterCredentials

.DESCRIPTION
GetClusterCredentials

.INPUTS
GetClusterCredentials - The name of GetClusterCredentials

.OUTPUTS
None

.EXAMPLE
GetClusterCredentials

.EXAMPLE
GetClusterCredentials


#>
function GetClusterCredentials() {
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

    Write-Verbose 'GetClusterCredentials: Starting'

    az aks get-credentials --name $clusterName --resource-group $resourceGroup --overwrite-existing

    Write-Verbose 'Verifying that we can connect to kubernetes cluster'
    kubectl version

    [bool] $result = $?
    if (!$result) {
        Write-Error "Could not connect to kubernetes cluster $clusterName in resource  group $resourceGroup"
    }

    Write-Verbose 'GetClusterCredentials: Done'
}

Export-ModuleMember -Function 'GetClusterCredentials'