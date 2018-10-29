<#
.SYNOPSIS
LoginAsServiceAccount

.DESCRIPTION
LoginAsServiceAccount

.INPUTS
LoginAsServiceAccount - The name of LoginAsServiceAccount

.OUTPUTS
None

.EXAMPLE
LoginAsServiceAccount

.EXAMPLE
LoginAsServiceAccount


#>
function LoginAsServiceAccount()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $servicePrincipalClientId
        ,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $servicePrincipalClientSecret
        ,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $tenantId
    )

    Write-Verbose 'LoginAsServiceAccount: Starting'
    az login -u $servicePrincipalClientId `
    --service-principal -p $servicePrincipalClientSecret `
    --tenant $tenantId `
    --allow-no-subscriptions

    Write-Verbose 'LoginAsServiceAccount: Done'
}

Export-ModuleMember -Function 'LoginAsServiceAccount'