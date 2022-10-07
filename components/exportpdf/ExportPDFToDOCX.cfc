/**
 * This sample illustrates how to export a PDF file to a Word (DOCX) file
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Export PDF To DOCX" {
    public ExportPDFToDOCX function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_ExportPDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ExportPDFOperation");
        variables.java_ExportPDFTargetFormat = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.exportpdf.ExportPDFTargetFormat");
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
            var exportPdfOperation = variables.java_ExportPDFOperation.createNew(
                variables.java_ExportPDFTargetFormat.DOCX
            );

            // Set operation input from a local PDF file
            var sourceFileRef = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/exportPDFInput.pdf"
            );
            exportPdfOperation.setInput(sourceFileRef);

            // Execute the operation.
            var result = exportPdfOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/exportPdfOutput.docx");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
