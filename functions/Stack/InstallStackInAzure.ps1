<#
  .SYNOPSIS
  InstallStack

  .DESCRIPTION
  InstallStack

  .INPUTS
  InstallStack - The name of InstallStack

  .OUTPUTS
  None

  .EXAMPLE
  InstallStack

  .EXAMPLE
  InstallStack


#>
function InstallStackInAzure() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $namespace
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $package
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $packageUrl
        ,
        [Parameter(Mandatory = $true)]
        [bool]
        $isAzure
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [bool]
        $local
    )

    Write-Verbose 'InstallStackInAzure: Starting'

    [hashtable]$Return = @{}

    if ($namespace -ne "kube-system") {
        if ($isAzure) {
            CreateAzureStorage -namespace $namespace
        }
        else {
            CreateOnPremStorage -namespace $namespace
        }
    }

    InstallStackInKubernetes `
        -namespace $namespace `
        -package $package `
        -packageUrl $packageUrl

    Write-Verbose 'InstallStackInAzure: Done'
    return $Return
}

Export-ModuleMember -Function "InstallStackInAzure"