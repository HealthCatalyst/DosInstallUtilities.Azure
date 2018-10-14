<#
  .SYNOPSIS
  DeployTemplate

  .DESCRIPTION
  DeployTemplate

  .INPUTS
  DeployTemplate - The name of DeployTemplate

  .OUTPUTS
  None

  .EXAMPLE
  DeployTemplate

  .EXAMPLE
  DeployTemplate


#>
function DeployTemplate() {
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
        $DeploymentName
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $TemplateFile
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $TemplateParameterFile
    )

    Write-Verbose 'DeployTemplate: Starting'

    Write-Host "Deploying AKS takes about 10-20 minutes"

    # get tenantId via Get-AzureRmSubscription
    # get objectId via $(Get-AzureRmADUser -UserPrincipalName '{imran.qureshi@healthcatalyst.com}').Id

    # https://vincentlauzon.com/2018/08/28/deploying-aks-with-arm-template-network-integration/

    # Create or update the resource group using the specified template file and template parameters file
    New-AzureRmResourceGroupDeployment -Name "$DeploymentName" `
        -ResourceGroupName $resourceGroup `
        -TemplateFile $TemplateFile `
        -TemplateParameterFile $TemplateParameterFile `
        -Force -Verbose

    Write-Verbose 'DeployTemplate: Done'
}


Export-ModuleMember -Function "DeployTemplate"