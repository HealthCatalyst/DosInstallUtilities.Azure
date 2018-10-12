$filename = $($(Split-Path -Leaf MyInvocation.MyCommand.Path).Replace('.Tests.ps1',''))

Describe "$filename Unit Tests" -Tags 'Unit' {
    It "TestMethod" {
    }
}

Describe "$filename Integration Tests" -Tags 'Integration' {
    It "Can Download Credentials" {
        DownloadCredentialsForAks -resourceGroup "fabrickubernetes2" -Verbose
    }
}