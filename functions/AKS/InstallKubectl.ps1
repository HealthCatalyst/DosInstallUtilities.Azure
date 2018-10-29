<#
.SYNOPSIS
InstallKubectl

.DESCRIPTION
InstallKubectl

.INPUTS
InstallKubectl - The name of InstallKubectl

.OUTPUTS
None

.EXAMPLE
InstallKubectl

.EXAMPLE
InstallKubectl


#>
function InstallKubectl()
{
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'InstallKubectl: Starting'

    az aks install-cli #--client-version
    $env:path += 'C:\Users\imran.qureshi\.azure-kubectl'
    # az aks get-credentials --resource-group $resourceGroup --name "$clusterName"

    Write-Verbose "--- PATH ---"
    $env:path
    Write-Verbose "--- end PATH ---"

    Write-Verbose 'InstallKubectl: Done'

}

Export-ModuleMember -Function 'InstallKubectl'