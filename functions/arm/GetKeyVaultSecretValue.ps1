<#
  .SYNOPSIS
  GetKeyVaultSecretValue

  .DESCRIPTION
  GetKeyVaultSecretValue

  .INPUTS
  GetKeyVaultSecretValue - The name of GetKeyVaultSecretValue

  .OUTPUTS
  None

  .EXAMPLE
  GetKeyVaultSecretValue

  .EXAMPLE
  GetKeyVaultSecretValue


#>
function GetKeyVaultSecretValue()
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true)]
    [string]
    $keyVaultName
    ,
    [Parameter(Mandatory = $true)]
    [string]
    $keyVaultSecretName
  )

  Write-Verbose "GetKeyVaultSecretValue: Starting ($keyVaultSecretName)"

  $secret = Get-AzureKeyVaultSecret -VaultName $keyVaultName -Name $keyVaultSecretName

  Write-Verbose "'GetKeyVaultSecretValue: Done ($keyVaultSecretName)"
  return $secret.SecretValueText #.Replace('"', '\"')
}

Export-ModuleMember -Function "GetKeyVaultSecretValue"