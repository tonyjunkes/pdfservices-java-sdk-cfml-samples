/**
 * This sample illustrates how to provide data inputs to an HTML file before converting it to PDF. The data input is used
 * by the javascript in the HTML file to manipulate the HTML DOM, thus effectively updating the source HTML file.
 *
 * This mechanismn can be used to provide data to the template HTML dynamically and convert it into a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF From Dynamic HTML" {
    public CreatePDFFromDynamicHTML function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");
        variables.java_PageLayout = createObject("java", "com.adobe.platform.operation.pdfops.options.createpdf.PageLayout");
        variables.java_JSONObject = createObject("java", "org.json.JSONObject");
        variables.java_CreatePDFOptions = createObject("java", "com.adobe.platform.operation.pdfops.options.createpdf.CreatePDFOptions");

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
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/createPDFFromDynamicHtmlInput.zip"
            );
            htmlToPDFOperation.setInput(source);

            // Provide any custom configuration options for the operation.
            setCustomOptions(htmlToPDFOperation);

            // Execute the operation.
            var result = htmlToPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFFromDynamicHtmlOutput.pdf");
        } catch(any e) {
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
        pageLayout.setPageSize(8, 11.5);

        // Set the dataToMerge field that needs to be populated in the HTML before its conversion
        var dataToMerge = variables.java_JSONObject.init();
        dataToMerge.put("title", "Create, Convert PDFs and More!");
        dataToMerge.put("sub_title", "Easily integrate PDF actions within your document workflows.");

        // Set the desired HTML-to-PDF conversion options.
        var htmlToPdfOptions = variables.java_CreatePDFOptions.htmlOptionsBuilder()
            .includeHeaderFooter(true)
            .withPageLayout(pageLayout)
            .withDataToMerge(dataToMerge)
            .build();
        htmlToPDFOperation.setOptions(htmlToPdfOptions);
    }
}
