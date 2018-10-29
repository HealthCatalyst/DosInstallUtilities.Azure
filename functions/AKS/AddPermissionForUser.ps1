<#
.SYNOPSIS
AddPermissionForUser

.DESCRIPTION
AddPermissionForUser

.INPUTS
AddPermissionForUser - The name of AddPermissionForUser

.OUTPUTS
None

.EXAMPLE
AddPermissionForUser

.EXAMPLE
AddPermissionForUser


#>
function AddPermissionForUser()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, HelpMessage="Full domain username e.g., imran.longbow@healthcatalyst.com")]
        [ValidateNotNullOrEmpty()]
        [string]
        $userName
    )

    Write-Verbose "AddPermissionForUser: Starting $userName"

    [int] $pos = $userName.IndexOf("@")
    [string] $leftPart = $userName.Substring(0, $pos)

    kubectl create clusterrolebinding "kubernetes-cluster-admin-$leftPart" --clusterrole="cluster-admin" --user="$userName"

    Write-Verbose 'AddPermissionForUser: Done'
}

Export-ModuleMember -Function 'AddPermissionForUser'