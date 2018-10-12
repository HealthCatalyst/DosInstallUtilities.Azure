$filename = $($(Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.ps1",""))
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

echo "filename: $filename"

Describe "$filename Unit Tests" -Tags 'Unit' {
    It "TestMethod" {
    }
}

Describe "$filename Cluster Integration Tests" -Tags @('Integration','Cluster') {
    It "Deploys cluster Template" {
        Set-AzureRmContext -SubscriptionId "c8b1589f-9270-46ee-967a-417817e7d10d" -Verbose
        DeployTemplate -ResourceGroup "fabrickubernetes2" -DeploymentName "CreateCluster" -TemplateFile ..\arm\cluster.json -TemplateParameterFile ..\..\clientenvironments\fabrickubernetes2\cluster.parameters.json -Verbose
    }
}

Describe "$filename ACS Integration Tests" -Tags @('Integration','ACS') {
    It "Deploys cluster Template" {
        Set-AzureRmContext -SubscriptionId "c8b1589f-9270-46ee-967a-417817e7d10d" -Verbose
        DeployTemplate -ResourceGroup "fabrickubernetes2" -DeploymentName "DeployACS" -TemplateFile ..\arm\acs.json -TemplateParameterFile ..\..\clientenvironments\fabrickubernetes2\acs.parameters.json -Verbose
    }
}

Describe "$filename AKS Integration Tests" -Tags @('Integration','AKS') {
    It "Deploys cluster Template" {
        Set-AzureRmContext -SubscriptionId "c8b1589f-9270-46ee-967a-417817e7d10d" -Verbose

        $templateFile = "$here\..\..\..\clientenvironments\fabrickubernetes2\aks.parameters.json"
        $templateFile | Should Exist

        DeployTemplate -ResourceGroup "fabrickubernetes2" -DeploymentName "DeployAKS" -TemplateFile "$here\..\..\arm\aks.json" -TemplateParameterFile "$templateFile" -Verbose
    }
}