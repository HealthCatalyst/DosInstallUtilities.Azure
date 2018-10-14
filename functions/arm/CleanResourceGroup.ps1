<#
  .SYNOPSIS
  CleanResourceGroup

  .DESCRIPTION
  CleanResourceGroup

  .INPUTS
  CleanResourceGroup - The name of CleanResourceGroup

  .OUTPUTS
  None

  .EXAMPLE
  CleanResourceGroup

  .EXAMPLE
  CleanResourceGroup


#>
function CleanResourceGroup()
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $resourceGroup
        ,
        [Parameter(Mandatory = $true)]
        [string]
        $DeploymentName
        ,
        [Parameter(Mandatory = $true)]
        [string]
        $TemplateFile
        ,
        [Parameter(Mandatory = $true)]
        [string]
        $TemplateParameterFile
    )

    Write-Verbose 'CleanResourceGroup: Starting'

    Write-Host "Info: Cleaning a resoure group typically takes less than a minute"

    # get tenantId via Get-AzureRmSubscription
    # get objectId via $(Get-AzureRmADUser -UserPrincipalName '{imran.qureshi@healthcatalyst.com}').Id

    # Create or update the resource group using the specified template file and template parameters file
    New-AzureRmResourceGroupDeployment -Name "$DeploymentName" `
        -ResourceGroupName $resourceGroup `
        -TemplateFile $TemplateFile `
        -TemplateParameterFile $TemplateParameterFile `
        -Mode Complete `
        -Force -Verbose

  Write-Verbose 'CleanResourceGroup: Done'
}

Export-ModuleMember -Function "CleanResourceGroup"