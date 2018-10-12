<#
.SYNOPSIS
DownloadCredentialsForAks

.DESCRIPTION
DownloadCredentialsForAks

.INPUTS
DownloadCredentialsForAks - The name of DownloadCredentialsForAks

.OUTPUTS
None

.EXAMPLE
DownloadCredentialsForAks

.EXAMPLE
DownloadCredentialsForAks


#>
function DownloadCredentialsForAks()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
    )

    Write-Verbose 'DownloadCredentialsForAks: Starting'

    Import-AzureRmAksCredential -ResourceGroupName $resourceGroup -Name "Kluster-$resourceGroup"

    Write-Verbose 'DownloadCredentialsForAks: Done'

}

Export-ModuleMember -Function 'DownloadCredentialsForAks'