/**
 * This sample illustrates how to export a PDF file to a Word (DOCX) file. The OCR processing is also performed on the input PDF file to extract text from images in the document.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Export PDF To DOCX With OCR Option" {
    public ExportPDFToDOCXWithOCROption function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_ExportPDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ExportPDFOperation");
        variables.java_ExportOCRLocale = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.exportpdf.ExportOCRLocale");
        variables.java_ExportPDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.exportpdf.ExportPDFOptions");
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

            // Create a new ExportPDFOptions instance from the specified OCR locale and set it into the operation.
            var exportPDFOptions = variables.java_ExportPDFOptions.init(variables.java_ExportOCRLocale.EN_US);
            exportPDFOperation.setOptions(exportPDFOptions);

            // Execute the operation.
            var result = exportPdfOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/exportPDFWithOCROptionsOutput.docx");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
