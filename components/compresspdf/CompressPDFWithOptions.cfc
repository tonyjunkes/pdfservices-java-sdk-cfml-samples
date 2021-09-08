/**
 * This sample illustrates how to compress PDF by reducing the size of the PDF file on the basis of
 * provided compression level.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Compress PDF With Options" {
    public CompressPDFWithOptions function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CompressPDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CompressPDFOperation");
        variables.java_CompressPDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.compresspdf.CompressPDFOptions");
        variables.java_CompressionLevel = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.compresspdf.CompressionLevel");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");

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

            // Build CompressPDF options from supported compression levels and set them into the operation
            var compressPDFOptions = variables.java_CompressPDFOptions.compressPDFOptionsBuilder()
                .withCompressionLevel(variables.java_CompressionLevel.LOW)
                .build();
            compressPDFOperation.setOptions(compressPDFOptions);

            // Execute the operation
            var result = compressPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/compressPDFWithOptionsOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation #e.message#");
        }
    }
}
