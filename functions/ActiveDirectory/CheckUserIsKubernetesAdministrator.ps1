<#
.SYNOPSIS
CheckUserIsKubernetesAdministrator

.DESCRIPTION
CheckUserIsKubernetesAdministrator

.INPUTS
CheckUserIsKubernetesAdministrator - The name of CheckUserIsKubernetesAdministrator

.OUTPUTS
None

.EXAMPLE
CheckUserIsKubernetesAdministrator

.EXAMPLE
CheckUserIsKubernetesAdministrator


#>
function CheckUserIsKubernetesAdministrator() {
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'CheckUserIsKubernetesAdministrator: Starting'
    Set-StrictMode -Version latest
    $ErrorActionPreference = 'Stop'


    Write-Verbose "Connecting to Azure AD"
    Connect-AzureAD

    Write-Verbose "Checking user is logged in"
    $currentAzureContext = Get-AzureRmContext
    $tenantId = $currentAzureContext.Tenant.Id
    $accountId = $currentAzureContext.Account.Id

    Write-Verbose "Checking membership in Kubernetes Administrators"
    [string] $accountId = $currentAzureContext.Account.Id

    [object[]] $groups = Get-AzureADUserMembership -ObjectId "$accountId"

    # Get-AzureADUserMembership -ObjectId "imran.qureshi@healthcatalyst.com"

    $membershipExists = $groups | Where-Object {$_.DisplayName -eq "Kubernetes Administrators"}

    if ($membershipExists) {
        Write-Verbose "User $accountId is a member of Kubernetes Administrators"
        Write-Verbose 'CheckUserIsKubernetesAdministrator: Done'
        Return $true
    }
    else {
        Write-Verbose "User $accountId is NOT a member of Kubernetes Administrators"
        Write-Verbose 'CheckUserIsKubernetesAdministrator: Done'
        Return $false
    }
}

Export-ModuleMember -Function 'CheckUserIsKubernetesAdministrator'