/**
 * This sample illustrates how to merge the Word based document template with the input JSON data to generate
 * the output document in the PDF format.
 *
 * To know more about document generation and document templates, please see the http://www.adobe.com/go/dcdocgen_overview_doc
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Merge Document To PDF" {
    public MergeDocumentToPDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_JSONObject = createObject("java", "org.json.JSONObject");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");
        variables.java_DocumentMergeOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.documentmerge.DocumentMergeOptions");
        variables.java_DocumentMergeOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.DocumentMergeOperation");
        variables.java_OutputFormat = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.documentmerge.OutputFormat");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            // Setup input data for the document merge process
            var content = toString(fileReadBinary(application.resourcesPath & "/salesOrder.json"));
            var jsonDataForMerge = variables.java_JSONObject.init(content);

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials);

            // Create a new DocumentMergeOptions instance
            var documentMergeOptions = variables.java_DocumentMergeOptions.init(jsonDataForMerge, variables.java_OutputFormat.PDF);

            // Create a new DocumentMergeOperation instance with the DocumentMergeOptions instance
            var documentMergeOperation = variables.java_DocumentMergeOperation.createNew(documentMergeOptions);

            // Set the operation input document template from a source file.
            var documentTemplate = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/salesOrderTemplate.docx"
            );
            documentMergeOperation.setInput(documentTemplate);

            // Execute the operation
            var result = documentMergeOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/salesOrderOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
