/**
 * This sample illustrates how to replace specific pages in a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="ReplacePDFPages" {
    public ReplacePDFPages function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_ReplacePagesOperation = createObject("java", "com.adobe.platform.operation.pdfops.ReplacePagesOperation");
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

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);
            var replacePagesOperation = variables.java_ReplacePagesOperation.createNew();

            // Set operation base input from a source file.
            var baseSourceFile = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/baseInput.pdf"
            );
            replacePagesOperation.setBaseInput(baseSourceFile);

            // Create a FileRef instance using a local file.
            var firstInputFile = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/replacePagesInput1.pdf"
            );
            var pageRanges = getPageRangeForFirstFile();

            // Adds the pages (specified by the page ranges) of the input PDF file for replacing the
            // page of the base PDF file.
            replacePagesOperation.addPagesForReplace(firstInputFile, pageRanges, 1);


            // Create a FileRef instance using a local file.
            var secondInputFile = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/replacePagesInput2.pdf"
            );

            // Adds all the pages of the input PDF file for replacing the page of the base PDF file.
            replacePagesOperation.addPagesForReplace(secondInputFile, 3);

            // Execute the operation
            var result = replacePagesOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/replacePagesOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getPageRangeForFirstFile() {
        // Specify pages of the first file for replacing the page of base PDF file.
        var pageRanges = variables.java_PageRanges.init();
        // Add pages 1 to 3.
        pageRanges.addRange(1, 3);

        // Add page 4.
        pageRanges.addSinglePage(4);

        return pageRanges;
    }
}
