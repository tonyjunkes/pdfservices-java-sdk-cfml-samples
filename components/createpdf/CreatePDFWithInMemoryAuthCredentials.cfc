/**
 * This sample illustrates how to provide in-memory auth credentials for performing an operation. This enables the
 * clients to fetch the credentials from a secret server during runtime, instead of storing them in a file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF With In Memory Auth Credentials" {
    public CreatePDFWithInMemoryAuthCredentials function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            // An application variable is defined in Application.cfc to read in the required params via the credentials
            // JSON and private.key files which must have been downloaded at the end of Getting the Credentials workflow.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .withClientId(application.credentials.clientID)
                .withClientSecret(application.credentials.clientSecret)
                .withPrivateKey(application.credentials.privateKey)
                .withOrganizationId(application.credentials.organizationID)
                .withAccountId(application.credentials.accountID)
                .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);
            var createPDFOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/createPDFInput.docx"
            );
            createPDFOperation.setInput(source);

            // Execute the operation.
            var result = createPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFWithInMemCredentials.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
