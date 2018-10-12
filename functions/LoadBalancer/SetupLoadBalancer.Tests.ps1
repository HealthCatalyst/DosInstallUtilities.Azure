$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$filename = $($(Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.ps1",""))

$mockConfig = @"
{
    "customerid": "test",
    "azure": {
        "subscription": "PlatformStaff-DevTest",
        "resourceGroup": "hcut-acs-rg",
        "location": "westus"
    },
    "ingress": {
        "external": {
            "type": "public"
        },
        "internal": {
            "type": "public"
        }
    },
    "dns": {
        "name": "hcut.healthcatalyst.net"
    }       
}
"@ | ConvertFrom-Json

$GITHUB_URL = "$here\..\..\..\"

Describe "$filename Unit Tests" -Tags 'Unit' {
    It "TestMethod" {
    }
}

Describe "$filename Integration Tests" -Tags 'Integration' {
    It "Sets up Load Balancer" {
        SetupLoadBalancer -baseUrl $GITHUB_URL -config $mockConfig -local $true -Verbose
    }
}