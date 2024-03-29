/**
 * This sample illustrates how to create a PDF file from a DOCX file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF From DOCX" {
    public CreatePDFFromDOCX function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CreatePDFOperation");
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
            var createPdfOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(application.resourcesPath & "/createPDFInput.docx");
            createPdfOperation.setInput(source);

            // Execute the operation.
            var result = createPdfOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFFromDOCX.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
