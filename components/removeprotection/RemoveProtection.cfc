/**
 * This sample illustrates how to remove password security from a PDF document.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="RemoveProtection" {
    public RemoveProtection function init() {
        variables.java_Credentials = createObject("java", "com.adobe.platform.operation.auth.Credentials");
        variables.java_ExecutionContext = createObject("java", "com.adobe.platform.operation.ExecutionContext");
        variables.java_RemoveProtectionOperation = createObject("java", "com.adobe.platform.operation.pdfops.RemoveProtectionOperation");
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
            var removeProtectionOperation = variables.java_RemoveProtectionOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/removeProtectionInput.pdf"
            );
            removeProtectionOperation.setInput(source);

            // Set the password for removing security from a PDF document.
            removeProtectionOperation.setPassword("password");

            // Execute the operation.
            var result = removeProtectionOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/removeProtectionOutput.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
