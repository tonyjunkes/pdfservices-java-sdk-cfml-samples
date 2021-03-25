/**
 * This sample illustrates how to provide custom http timeouts for performing an operation. This enables the
 * clients to set custom timeouts on the basis of their network speed.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF With Custom Timeouts" {
    public CreatePDFWithCustomTimeouts function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ClientConfig = createObject("java", "com.adobe.platform.operation.ClientConfig");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            // Create client config instance with custom time-outs.
            var clientConfig = variables.java_ClientConfig.builder()
                .withConnectTimeout(10000)
                .withSocketTimeout(40000)
                .build();

            //Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials, clientConfig);
            var createPDFOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/createPDFInput.docx"
            );
            createPDFOperation.setInput(source);

            // Execute the operation.
            var result = createPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFWithCustomTimeouts.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
