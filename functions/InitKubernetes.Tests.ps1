$filename = $($(Split-Path -Leaf MyInvocation.MyCommand.Path).Replace('.Tests.ps1',''))

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

Describe "$filename Unit Tests" -Tags 'Unit' {
    It "TestMethod" {
    }
}

Describe "$filename Integration Tests" -Tags 'Integration' {
    It "Can Init Kubernetes" {
        InitKubernetes -subscriptionName "PlatformStaff-DevTest" -resourceGroup "hcut-aks-rg"
    }
}