$filename = $($(Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.ps1",""))
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "$filename Unit Tests" -Tags 'Unit' {
    It "TestMethod" {
    }
}

Describe "$filename Integration Tests" -Tags @('Integration','Cluster') {
    It "Deploys cluster Template" {
        Set-AzureRmContext -SubscriptionId "c8b1589f-9270-46ee-967a-417817e7d10d" -Verbose

        $templateFile = "$here\..\..\..\clientenvironments\fabrickubernetes2\cluster.parameters.json"
        $templateFile | Should Exist

        $globals.resourceGroup | Should Not BeNullOrEmpty
        $globals.resourceGroup | Should BeOfType [string]

        CleanResourceGroup -resourceGroup "$($globals.resourceGroup)" -DeploymentName "CleanCluster" -TemplateFile "$here\..\..\arm\cluster.json" -TemplateParameterFile "$templateFile" -Verbose
    }
}
