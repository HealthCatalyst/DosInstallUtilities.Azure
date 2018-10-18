<#
.SYNOPSIS
DeleteNamespaceAndData

.DESCRIPTION
DeleteNamespaceAndData

.INPUTS
DeleteNamespaceAndData - The name of DeleteNamespaceAndData

.OUTPUTS
None

.EXAMPLE
DeleteNamespaceAndData

.EXAMPLE
DeleteNamespaceAndData


#>
function DeleteNamespaceAndData() {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $namespace
        ,
        [Parameter(Mandatory=$true)]
        [bool]
        $isAzure
    )

    Write-Verbose 'DeleteNamespaceAndData: Starting'
    [hashtable]$Return = @{}

    CleanOutNamespace -namespace $namespace

    if ($isAzure) {
        DeleteAzureStorage -namespace $namespace
    }
    else {
        DeleteOnPremStorage -namespace $namespace
    }

    DeleteAllSecretsInNamespace -namespace $namespace -Verbose

    Write-Verbose 'DeleteNamespaceAndData: Done'
    return $Return

}

Export-ModuleMember -Function 'DeleteNamespaceAndData'