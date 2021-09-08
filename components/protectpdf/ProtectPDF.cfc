/**
 * This sample illustrates how to convert a PDF file into a password protected PDF file.
 * The password is used for encrypting PDF contents and will be required for viewing the PDF file.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="ProtectPDF" {
    public ProtectPDF function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_ProtectPDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.ProtectPDFOptions");
        variables.java_EncryptionAlgorithm = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.EncryptionAlgorithm");
        variables.java_ProtectPDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.ProtectPDFOperation");
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

            // Build ProtectPDF options by setting a User Password and Encryption
            // Algorithm (used for encrypting the PDF file).
            var protectPDFOptions = variables.java_ProtectPDFOptions.passwordProtectOptionsBuilder()
                .setUserPassword("encryptPassword")
                .setEncryptionAlgorithm(variables.java_EncryptionAlgorithm.AES_256)
                .build();

            // Create a new operation instance.
            var protectPDFOperation = variables.java_ProtectPDFOperation.createNew(protectPDFOptions);

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/protectPDFInput.pdf"
            );
            protectPDFOperation.setInput(source);

            // Execute the operation
            var result = protectPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs(application.outputPath & "/protectPDFOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
