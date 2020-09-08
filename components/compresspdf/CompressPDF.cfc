/**
 * This sample illustrates how to compress PDF by reducing the size of the PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Compress PDF" {
    public CompressPDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_CompressPDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.CompressPDFOperation");
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
            var compressPDFOperation = variables.java_CompressPDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/compressPDFInput.pdf"
            );
            compressPDFOperation.setInput(source);

            // Execute the operation
            var result = compressPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/compressPDFOutput.pdf");
        } catch(any e) {
            writeLog("Exception encountered while executing operation #e.message#");
        }
    }
}
