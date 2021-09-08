/**
 * This sample illustrates how to extract Text Information along with text character bounds from PDF.
 *
 * Refer to README.md for instructions on how to run the samples & understand output zip file.
 */
component displayname="Extract Text Info With Char Bounds From PDF" {
    public ExtractTextInfoWithCharBoundsFromPDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");
        variables.java_ExtractPDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ExtractPDFOperation");
        variables.java_ExtractPDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.extractpdf.ExtractPDFOptions");
        variables.java_ExtractElementType = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.extractpdf.ExtractElementType");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            // Create an ExecutionContext using credentials.
            var executionContext = variables.java_ExecutionContext.create(credentials);

            var extractPDFOperation = variables.java_ExtractPDFOperation.createNew();

            // Provide an input FileRef for the operation
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/extractPdfInput.pdf"
            );
            extractPDFOperation.setInputFile(source);

            // Build ExtractPDF options and set them into the operation
            var extractPDFOptions = variables.java_ExtractPDFOptions
                .extractPdfOptionsBuilder()
                .addElementToExtract(variables.java_ExtractElementType.TEXT)
                .addCharInfo(true)
                .build();
            extractPDFOperation.setOptions(extractPDFOptions);

            // Execute the operation
            var result = extractPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/ExtractTextInfoWithCharBoundsFromPDF.zip");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
