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

    Write-Verbose "GetClusterName: Starting ($resourceGroup)"

    $result.ClusterName = "Kluster-$resourceGroup"

    Write-Verbose "GetClusterName: Done $($result.ClusterName)"

    return $result
}

Export-ModuleMember -Function 'GetClusterName'