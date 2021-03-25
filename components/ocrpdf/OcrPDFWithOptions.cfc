/**
 * This sample illustrates how to perform an OCR operation on a PDF file and convert it into an searchable PDF file on
 * the basis of provided locale and SEARCHABLE_IMAGE_EXACT ocr type to keep the original image
 * (Recommended for cases requiring maximum fidelity to the original image.).
 *
 * Note that OCR operation on a PDF file results in a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="OcrPDF" {
    public OcrPDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_OCROperation = createObject("java", "com.adobe.platform.operation.pdfops.OCROperation");
        variables.java_OCRSupportedLocale = createObject("java", "com.adobe.platform.operation.pdfops.OCRSupportedLocale");
        variables.java_OCRSupportedType = createObject("java", "com.adobe.platform.operation.pdfops.OCRSupportedType");
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
            var ocrOperation = variables.java_OCROperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/ocrInput.pdf"
            );
            ocrOperation.setInput(source);

            // Build OCR options from supported locales and OCR-types and set them into the operation
            var ocrOptions = variables.java_OCROptions.ocrOptionsBuilder()
                .withOCRLocale(variables.java_OCRSupportedLocale.EN_US)
                .withOCRType(variables.java_OCRSupportedType.SEARCHABLE_IMAGE_EXACT)
                .build();
            ocrOperation.setOptions(ocrOptions);

            // Execute the operation
            var result = ocrOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/ocrWithOptionsOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
