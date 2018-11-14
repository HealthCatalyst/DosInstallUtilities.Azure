<#
.SYNOPSIS
Globals

.DESCRIPTION
Globals

.INPUTS
Globals - The name of Globals

.OUTPUTS
None

.EXAMPLE
Globals

.EXAMPLE
Globals


#>
function GlobalsDummy()
{
    [CmdletBinding()]
    param
    (
    )

    Write-Verbose 'Globals: Starting'

    Write-Verbose 'Globals: Done'

}

[hashtable] $globals = @{
    resourceGroup = "fabrickubernetes4"
}

Export-ModuleMember -Variable globals
