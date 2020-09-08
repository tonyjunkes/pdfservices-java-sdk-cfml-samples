/**
 * This sample illustrates how to create a PDF file from a DOCX input stream.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF From DOCX InputStream" {
    public CreatePDFFromDOCXInputStream function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");
        variables.java_FileInputStream = createObject("java", "java.io.FileInputStream");
        variables.java_SupportedSourceFormat = createObject("java", "com.adobe.platform.operation.pdfops.CreatePDFOperation$SupportedSourceFormat");

        return this;
    }

    public void function run() {
        // Prepare an input stream for the file that needs to be converted.
        try {
            var inputStream = getDOCXInputStream();

            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);
            var createPdfOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from the source stream by specifying the stream media type.
            var source = variables.java_FileRef.createFromStream(
                inputStream,
                variables.java_SupportedSourceFormat.DOCX.getMediaType()
            );
            createPdfOperation.setInput(source);

            // Execute the operation.
            var result = createPdfOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFFromDOCXStream.pdf");
        } catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getDOCXInputStream() {
        return variables.java_FileInputStream.init(
            application.resourcesPath & "/createPDFInput.docx"
        );
    }
}
