/**
 * This sample illustrates how to reorder the pages in a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="ReorderPDFPages" {
    public ReorderPDFPages function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_ReorderPagesOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ReorderPagesOperation");
        variables.java_PageRanges = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.PageRanges");
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
            var reorderPagesOperation = variables.java_ReorderPagesOperation.createNew();

            // Set operation input from a source file, along with specifying the order of the pages for
            // rearranging the pages in a PDF file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/reorderPagesInput.pdf"
            );
            var pageRanges = getPageRangeForReorder();
            reorderPagesOperation.setInput(source);
            reorderPagesOperation.setPagesOrder(pageRanges);

            // Execute the operation.
            var result = reorderPagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/reorderPagesOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getPageRangeForReorder() {
        // Specify order of the pages for an output document.
        var pageRanges = variables.java_PageRanges.init();
        // Add pages 3 to 4.
        pageRanges.addRange(3, 4);

        // Add page 1.
        pageRanges.addSinglePage(1);

        return pageRanges;
    }
}
