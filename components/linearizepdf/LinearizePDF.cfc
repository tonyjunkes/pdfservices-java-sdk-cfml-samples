/**
 * This sample illustrates how to convert a PDF file into a Linearized (also known as "web optimized") PDF file.
 * Such PDF files are optimized for incremental access in network environments.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="LinearizePDF" {
    public InsertPDFPages function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_LinearizePDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.LinearizePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);
            var linearizePDFOperation = variables.java_LinearizePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/linearizePDFInput.pdf"
            );
            linearizePDFOperation.setInput(source);

            // Execute the operation
            var result = linearizePDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/linearizePDFOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
