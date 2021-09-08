/**
 * This sample illustrates how to perform OCR operation on a PDF file and convert it into a searchable PDF file.
 *
 * Note that OCR operation on a PDF file results in a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="OcrPDF" {
    public OcrPDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_OCROperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.OCROperation");
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
            var ocrOperation = variables.java_OCROperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/ocrInput.pdf"
            );
            ocrOperation.setInput(source);

            // Execute the operation
            var result = ocrOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/ocrOutput.pdf");

        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
