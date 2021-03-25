/**
 * This sample illustrates how to insert specific pages of multiple PDF files into a single PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Insert PDF Pages" {
    public InsertPDFPages function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_InsertPagesOperation = createObject("java", "com.adobe.platform.operation.pdfops.InsertPagesOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");
        variables.java_PageRanges = createObject("java", "com.adobe.platform.operation.pdfops.options.PageRanges");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile("pdftools-api-credentials.json")
                .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);
            var insertPagesOperation = variables.java_InsertPagesOperation.createNew();

            // Set operation base input from a source file.
            var baseSourceFile = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/baseInput.pdf"
            );
            insertPagesOperation.setBaseInput(baseSourceFile);

            // Create a FileRef instance using a local file.
            var firstFileToInsert = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/firstFileToInsertInput.pdf"
            );
            var pageRanges = getPageRangeForFirstFile();

            // Adds the pages (specified by the page ranges) of the input PDF file to be inserted at
            // the specified page of the base PDF file.
            insertPagesOperation.addPagesToInsertAt(firstFileToInsert, pageRanges, 2);

            // Create a FileRef instance using a local file.
            var secondFileToInsert = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/secondFileToInsertInput.pdf"
            );

            // Adds all the pages of the input PDF file to be inserted at the specified page of the
            // base PDF file.
            insertPagesOperation.addPagesToInsertAt(secondFileToInsert, 3);

            // Execute the operation.
            var result = insertPagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/insertPagesOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getPageRangeForFirstFile() {
        // Specify which pages of the first file are to be inserted in the base file.
        var pageRanges = new PageRanges();
        // Add pages 1 to 3.
        pageRanges.addRange(1, 3);
        // Add page 4.
        pageRanges.addSinglePage(4);

        return pageRanges;
    }
}
