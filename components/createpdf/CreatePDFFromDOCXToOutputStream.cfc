/**
 * This sample illustrates how to create a PDF file from a DOCX file, and then save the result to an output stream.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF From DOCX To OutputStream" {
    public CreatePDFFromDOCXToOutputStream function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");
        variables.java_FileOutputStream = createObject("java", "java.io.FileOutputStream");

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
            var createPdfOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/createPDFInput.docx"
            );
            createPdfOperation.setInput(source);

            // Execute the operation.
            var result = createPdfOperation.execute(executionContext);

            // Create an OutputStream and save the result to the stream.
            var outputStream = prepareOutputStream();
            result.saveAs(outputStream);
        } catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    /**
     * Prepares an OutputStream over a predetermined result file.
     * @return the OutputStream instance
     */
    private any function prepareOutputStream() {
        // Create the result directories if they don't exist.
        if (!directoryExists(application.outputPath)) directoryCreate(application.outputPath);

        var filePath = application.outputPath & "/createPDFAsStream.pdf";
        fileWrite(filePath, "");

        return variables.java_FileOutputStream.init(filePath);
    }
}
