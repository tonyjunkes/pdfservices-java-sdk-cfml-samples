/**
 * This sample illustrates how to delete pages in a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Delete PDF Pages" {
    public DeletePDFPages function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_DeletePagesOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.DeletePagesOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");
        variables.java_PageRanges = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.PageRanges");

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
            var deletePagesOperation = variables.java_DeletePagesOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/deletePagesInput.pdf"
            );
            deletePagesOperation.setInput(source);

            // Delete pages of the document (as specified by PageRanges).
            var pageRangeForDeletion = getPageRangeForDeletion();
            deletePagesOperation.setPageRanges(pageRangeForDeletion);

            // Execute the operation.
            var result = deletePagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/deletePagesOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getPageRangeForDeletion() {
        // Specify pages for deletion.
        var pageRangeForDeletion = variables.java_PageRanges.init();
        // Add page 1.
        pageRangeForDeletion.addSinglePage(1);
        // Add pages 3 to 4.
        pageRangeForDeletion.addRange(3, 4);

        return pageRangeForDeletion;
    }
}
