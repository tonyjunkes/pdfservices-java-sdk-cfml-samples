/**
 * This sample illustrates how to export a PDF file to JPEG.
 *
 * The resulting file is a ZIP archive containing one image per page of the source PDF file
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Export PDF To JPEG Zip" {
    public ExportPDFToJPEGZip function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_ExportPDFToImagesOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ExportPDFToImagesOperation");
        variables.java_ExportPDFToImagesTargetFormat = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.exportpdftoimages.ExportPDFToImagesTargetFormat");
        variables.java_OutputType = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.exportpdftoimages.OutputType");
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
            var exportPDFToImagesOperation = variables.java_ExportPDFToImagesOperation.createNew(
                variables.java_ExportPDFToImagesTargetFormat.JPEG
            );

            // Set operation input from a source file.
            var sourceFileRef = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/exportPDFToImageInput.pdf"
            );
            exportPDFToImagesOperation.setInput(sourceFileRef);

            // Set the output type to create zip of images.
            exportPDFToImagesOperation.setOutputType(variables.java_OutputType.ZIP_OF_PAGE_IMAGES);

            // Execute the operation.
            var results = exportPDFToImagesOperation.execute(executionContext);

            writeLog("Media type of the received asset is " & results.get(0).getMediaType());

            // Save the result to the specified location.
            results.get(0).saveAs(application.outputPath & "/exportPDFToJPEGOutput.zip");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
