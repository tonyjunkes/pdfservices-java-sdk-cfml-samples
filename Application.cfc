component {
    this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
    this.javaSettings.loadPaths = directoryList(expandPath("./lib"), true, "path", "*.jar");
    this.mappings = {
        "/components": expandPath("./components"),
        "/resources": expandPath("./resources"),
        "/output": expandPath("./output")
    };

    public boolean function onApplicationStart() {
        application.credentialsJSONFile = expandPath("./pdfservices-api-credentials.json");
        application.privateKeyFile = expandPath("./private.key");
        application.resourcesPath = expandPath("/resources");
        application.outputPath = expandPath("/output");

        // In memory credential settings
        var credentialsJSON = deserializeJSON(fileRead(application.credentialsJSONFile));
        application.credentials = {
            clientID: credentialsJSON.client_credentials.client_id,
            clientSecret: credentialsJSON.client_credentials.client_secret,
            privateKey: fileRead(application.privateKeyFile),
            organizationID: credentialsJSON.service_account_credentials.organization_id,
            accountID: credentialsJSON.service_account_credentials.account_id
        };

        return true;
    }
}