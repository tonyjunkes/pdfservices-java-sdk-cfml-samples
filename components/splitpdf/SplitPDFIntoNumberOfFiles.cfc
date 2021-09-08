/**
 * This sample illustrates how to split input PDF into multiple PDF files on the basis of the number of documents.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="SplitPDFIntoNumberOfFiles" {
    public SplitPDFIntoNumberOfFiles function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_SplitPDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.SplitPDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");

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

            // Set the number of documents to split the input PDF file into.
            splitPDFOperation.setFileCount(2);

            // Execute the operation.
            var result = splitPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            var index = 0;
            for (var fileRef in result) {
                fileRef.saveAs(application.outputPath & "/SplitPDFIntoNumberOfFilesOutput_" & index & ".pdf");
                index++;
            }
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
