/**
 * This sample illustrates how to provide documentLanguage option when creating a pdf file from docx file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF From DOCX With Options" {
    public CreatePDFFromDOCXWithOptions function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");
        variables.java_SupportedDocumentLanguage = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.createpdf.word.SupportedDocumentLanguage");
        variables.java_CreatePDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.createpdf.CreatePDFOptions");

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

            // Provide any custom configuration options for the operation.
            setCustomOptions(createPdfOperation);

            // Execute the operation.
            var result = createPdfOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFFromDOCXWithOptionsOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    /**
     * @hint Sets any custom options for the operation.
     * @createPdfOperation.hint createPdfOperation operation instance for which the options are provided.
     */
    private void function setCustomOptions(any createPdfOperation) {
        // Select the documentLanguage for input file.
        var documentLanguage = variables.java_SupportedDocumentLanguage.EN_US;

        // Set the desired Word-to-PDF conversion options.
        var wordOptions = variables.java_CreatePDFOptions.wordOptionsBuilder().
            withDocumentLanguage(documentLanguage).
            build();

        createPdfOperation.setOptions(wordOptions);
    }
}
