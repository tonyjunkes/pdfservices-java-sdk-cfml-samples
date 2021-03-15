/**
 * This sample illustrates how to split input PDF into multiple PDF files on the basis of page ranges.
 * Each page range corresponds to a single output file having the pages specified in the page range.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="SplitPDFByPageRanges" {
    public SplitPDFByPageRanges function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_SplitPDFOperation = createObject("java", "com.adobe.platform.operation.pdfops.SplitPDFOperation");
        variables.java_PageRanges = createObject("java", "com.adobe.platform.operation.pdfops.options.PageRanges");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");

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
            var splitPDFOperation = variables.java_SplitPDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/splitPDFInput.pdf"
            );
            splitPDFOperation.setInput(source);

            // Set the page ranges where each page range corresponds to a single output file.
            var pageRanges = getPageRanges();
            splitPDFOperation.setPageRanges(pageRanges);

            // Execute the operation.
            var result = splitPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            var index = 0;
            for (var fileRef in result) {
                fileRef.saveAs(application.outputPath & "/SplitPDFByPageRangesOutput_" + index + ".pdf");
                index++;
            }
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getPageRanges() {
        // Specify page ranges.
        var pageRanges = variables.java_PageRanges.init();
        // Add page 1.
        pageRanges.addSinglePage(1);
        // Add pages 3 to 4.
        pageRanges.addRange(3, 4);

        return pageRanges;
    }
}
