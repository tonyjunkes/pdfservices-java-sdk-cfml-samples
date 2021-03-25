/**
 * This sample illustrates how to combine specific pages of multiple PDF files into a single PDF file.
 * Note that the SDK supports combining upto 12 files in one operation
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Combine PDF With Page Ranges" {
    public CombinePDFWithPageRanges function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_CombineFilesOperation = createObject("java", "com.adobe.platform.operation.pdfops.CombineFilesOperation");
        variables.java_FileRef = createObject("java", "com.adobe.platform.operation.io.FileRef");
        variables.java_PageRanges = createObject("java", "com.adobe.platform.operation.pdfops.options.PageRanges");

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
            var combineFilesOperation = variables.java_CombineFilesOperation.createNew();

            // Create a FileRef instance from a local file.
            var firstFileToCombine = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/combineFileWithPageRangeInput1.pdf"
            );
            var pageRangesForFirstFile = getPageRangeForFirstFile();
            // Add the first file as input to the operation, along with its page range.
            combineFilesOperation.addInput(firstFileToCombine, pageRangesForFirstFile);

            // Create a second FileRef instance using a local file.
            var secondFileToCombine = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/combineFileWithPageRangeInput2.pdf"
            );
            var pageRangesForSecondFile = getPageRangeForSecondFile();
            // Add the second file as input to the operation, along with its page range.
            combineFilesOperation.addInput(secondFileToCombine, pageRangesForSecondFile);

            // Execute the operation.
            var result = combineFilesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/combineFilesWithPageOptionsOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getPageRangeForSecondFile() {
        // Specify which pages of the second file are to be included in the combined file.
        var pageRangesForSecondFile = variables.java_PageRanges.init();
        // Add all pages including and after page 3.
        pageRangesForSecondFile.addAllFrom(3);

        return pageRangesForSecondFile;
    }

    private any function getPageRangeForFirstFile() {
        // Specify which pages of the first file are to be included in the combined file.
        var pageRangesForFirstFile = variables.java_PageRanges.init();
        // Add page 1.
        pageRangesForFirstFile.addSinglePage(1);
        // Add page 2.
        pageRangesForFirstFile.addSinglePage(2);
        // Add pages 3 to 4.
        pageRangesForFirstFile.addRange(3, 4);

        return pageRangesForFirstFile;
    }
}
