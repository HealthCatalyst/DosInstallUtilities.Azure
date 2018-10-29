<#
.SYNOPSIS
GetClusterName

.DESCRIPTION
GetClusterName

.INPUTS
GetClusterName - The name of GetClusterName

.OUTPUTS
None

.EXAMPLE
GetClusterName

.EXAMPLE
GetClusterName


#>
function GetClusterName()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
    )

    [hashtable] $result = @{}

    Write-Verbose 'GetClusterName: Starting'

    $result.ClusterName = "Kluster-$resourceGroup"

    Write-Verbose 'GetClusterName: Done'

    return $result
}

Export-ModuleMember -Function 'GetClusterName'