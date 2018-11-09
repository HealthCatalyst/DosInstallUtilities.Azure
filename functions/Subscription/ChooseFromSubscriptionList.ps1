<#
.SYNOPSIS
ChooseFromSubscriptionList

.DESCRIPTION
ChooseFromSubscriptionList

.INPUTS
ChooseFromSubscriptionList - The name of ChooseFromSubscriptionList

.OUTPUTS
None

.EXAMPLE
ChooseFromSubscriptionList

.EXAMPLE
ChooseFromSubscriptionList


#>
function ChooseFromSubscriptionList()
{
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'ChooseFromSubscriptionList: Starting'

    Set-StrictMode -Version latest
    # stop whenever there is an error
    $ErrorActionPreference = "Stop"

    [Microsoft.Azure.Commands.Profile.Models.PSAzureSubscription[]] $subscriptions = Get-AzureRmSubscription

    [int] $i = 1;
    foreach ($subscription in $subscriptions) {
        Write-Host "$i. $($subscription.Name)"
        $i=$i+1
    }

    [int] $subscriptionNumber = Read-Host -Prompt "Choose subscription by number"

    [Microsoft.Azure.Commands.Profile.Models.PSAzureSubscription] $newSubscription = $subscriptions[$subscriptionNumber-1]

    Write-Host "Chosen: $($newSubscription.Name)"
    SetCurrentAzureSubscription -subscriptionName "$($newSubscription.Name)"

    Write-Verbose 'ChooseFromSubscriptionList: Done'
}

Export-ModuleMember -Function 'ChooseFromSubscriptionList'