/**
 * This sample illustrates how to export a PDF file to JPEG.
 *
 * Note that exporting a PDF file to an image format results in a ZIP archive containing one image per page.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Export PDF To JPEG" {
    public ExportPDFToJPEG function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_ExportPDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.ExportPDFOperation");
        variables.java_ExportPDFTargetFormat = createObject("java", "com.adobe.platform.operation.pdfops.options.exportpdf.ExportPDFTargetFormat");
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
            var exportPdfOperation = variables.java_ExportPDFOperation.createNew(
                variables.java_ExportPDFTargetFormat.JPEG
            );

            // Set operation input from a source file.
            var sourceFileRef = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/exportPDFToImageInput.pdf"
            );
            exportPdfOperation.setInput(sourceFileRef);

            // Execute the operation.
            var result = exportPdfOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/exportPDFToJPEG.zip");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
