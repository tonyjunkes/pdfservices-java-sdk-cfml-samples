/**
 * This sample illustrates how to rotate pages in a PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="RotatePDFPages" {
    public RotatePDFPages function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_RotatePagesOperation = createObject("java", "com.adobe.platform.operation.pdfops.RotatePagesOperation");
        variables.java_PageRanges = createObject("java", "com.adobe.platform.operation.pdfops.options.PageRanges");
        variables.java_Angle = createObject("java", "com.adobe.platform.operation.pdfops.options.rotatepages.Angle");
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
            var rotatePagesOperation = variables.java_RotatePagesOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/rotatePagesInput.pdf"
            );
            rotatePagesOperation.setInput(source);

            // Sets angle by 90 degrees (in clockwise direction) for rotating the specified pages of
            // the input PDF file.
            var firstPageRange = getFirstPageRangeForRotation();
            rotatePagesOperation.setAngleToRotatePagesBy(variables.java_Angle._90, firstPageRange);

            // Sets angle by 180 degrees (in clockwise direction) for rotating the specified pages of
            // the input PDF file.
            var secondPageRange = getSecondPageRangeForRotation();
            rotatePagesOperation.setAngleToRotatePagesBy(variables.java_Angle._180, secondPageRange);

            // Execute the operation.
            var result = rotatePagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/rotatePagesOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }

    private any function getFirstPageRangeForRotation() {
        // Specify pages for rotation.
        var firstPageRange = variables.java_PageRanges.init();
        // Add page 1.
        firstPageRange.addSinglePage(1);

        // Add pages 3 to 4.
        firstPageRange.addRange(3, 4);

        return firstPageRange;
    }

    private any function getSecondPageRangeForRotation() {
        // Specify pages for rotation.
        var secondPageRange = variables.java_PageRanges.init();
        // Add page 2.
        secondPageRange.addSinglePage(2);

        return secondPageRange;
    }
}
