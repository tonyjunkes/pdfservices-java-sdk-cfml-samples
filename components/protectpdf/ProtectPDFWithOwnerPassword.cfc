/**
 * This sample illustrates how to secure a PDF file with owner password and allow certain access permissions
 * such as copying and editing the contents, and printing of the document at low resolution.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="ProtectPDFWithOwnerPassword" {
    public ProtectPDFWithOwnerPassword function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_Permissions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.Permissions");
        variables.java_Permission = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.Permission");
        variables.java_ProtectPDFOptions = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.ProtectPDFOptions");
        variables.java_EncryptionAlgorithm = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.EncryptionAlgorithm");
        variables.java_ContentEncryption = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.protectpdf.ContentEncryption");
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

            // Create new permissions instance and add the required permissions
            var permissions = variables.java_Permissions.createNew();
            permissions.addPermission(variables.java_Permission.PRINT_LOW_QUALITY);
            permissions.addPermission(variables.java_Permission.EDIT_DOCUMENT_ASSEMBLY);
            permissions.addPermission(variables.java_Permission.COPY_CONTENT);

            // Build ProtectPDF options by setting an Owner/Permissions Password, Permissions,
            // Encryption Algorithm (used for encrypting the PDF file) and specifying the type of content to encrypt.
            var protectPDFOptions = variables.java_ProtectPDFOptions.passwordProtectOptionsBuilder()
                .setOwnerPassword("password")
                .setPermissions(permissions)
                .setEncryptionAlgorithm(variables.java_EncryptionAlgorithm.AES_256)
                .setContentEncryption(variables.java_ContentEncryption.ALL_CONTENT_EXCEPT_METADATA)
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
