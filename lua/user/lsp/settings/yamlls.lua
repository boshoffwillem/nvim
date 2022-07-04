return {
    settings = {
        yaml = {
            format = true,
            schemaDownload = {
                enable = true
            },
            schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = { "/*Pipeline*.yml" },
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml"
            },
            validate = true
        }
    }
}
