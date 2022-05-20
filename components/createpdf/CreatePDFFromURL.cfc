/**
 * This sample illustrates how to convert an HTML file specified via URL to a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF From URL" {
    public CreatePDFFromURL function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");
        variables.java_URL = createObject("java", "java.net.URL");
        variables.java_PageLayout = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.createpdf.PageLayout");
        variables.java_CreatePDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.createpdf.CreatePDFOptions");

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
            var htmlToPDFOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromURL(
                variables.java_URL.init("https://developer.adobe.com/document-services/docs/overview/")
            );
            htmlToPDFOperation.setInput(source);

            // Provide any custom configuration options for the operation.
            var htmlToPdfOptions = variables.java_CreatePDFOptions
                .htmlOptionsBuilder()
                .includeHeaderFooter(true)
                .build();
            htmlToPDFOperation.setOptions(htmlToPdfOptions);

            // Provide any custom configuration options for the operation.
            setCustomOptions(htmlToPDFOperation);

            // Execute the operation.
            var result = htmlToPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFFromURLOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    /**
     * @hint Sets any custom options for the operation.
     * @htmlToPDFOperation operation instance for which the options are provided.
     */
    private void function setCustomOptions(required any htmlToPDFOperation) {
        // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
        var pageLayout = variables.java_PageLayout.init();
        pageLayout.setPageSize(20, 25);

        // Set the desired HTML-to-PDF conversion options.
        var htmlToPdfOptions = variables.java_CreatePDFOptions
            .htmlOptionsBuilder()
            .includeHeaderFooter(true)
            .withPageLayout(pageLayout)
            .build();
        htmlToPDFOperation.setOptions(htmlToPdfOptions);
    }
}
