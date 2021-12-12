/**
 * This sample illustrates how to export a PDF file to a list of JPEG files.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Export PDF To JPEG List" {
    public ExportPDFToJPEGList function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");
        variables.java_ExportPDFToImagesOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ExportPDFToImagesOperation");
        variables.java_ExportPDFToImagesTargetFormat = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.exportpdftoimages.ExportPDFToImagesTargetFormat");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);
            var exportPDFToImagesOperation = variables.java_ExportPDFToImagesOperation.createNew(
                variables.java_ExportPDFToImagesTargetFormat.JPEG
            );

            // Set operation input from a source file.
            var sourceFileRef = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/exportPDFToImageInput.pdf"
            );
            exportPDFToImagesOperation.setInput(sourceFileRef);

            // Execute the operation.
            var results = exportPDFToImagesOperation.execute(executionContext);

            // Save the result to the specified location.
            var index = 0;
            for (var result in results) {
                result.saveAs(application.outputPath & "/exportPDFToImagesOutput_" & index & ".jpeg");
                index++;
            }
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
