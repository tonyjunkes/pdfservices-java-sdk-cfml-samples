/**
 * This sample illustrates how to combine multiple PDF files into a single PDF file.
 * Note that the SDK supports combining upto 12 files in one operation.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Combine PDF" {
    public CombinePDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CombineFilesOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CombineFilesOperation");
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
            var combineFilesOperation = variables.java_CombineFilesOperation.createNew();

            // Add operation input from source files.
            var combineSource1 = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/combineFilesInput1.pdf"
            );
            var combineSource2 = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/combineFilesInput2.pdf"
            );
            combineFilesOperation.addInput(combineSource1);
            combineFilesOperation.addInput(combineSource2);

            // Execute the operation.
            var result = combineFilesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/combineFilesOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
