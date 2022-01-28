/**
 * This sample illustrates how to setup Proxy Server configurations for performing an operation. This enables the
 * clients to set proxy server configurations to enable the API calls in a network where calls are blocked unless they
 * are routed via Proxy server.
 *
 * Refer to README.md for instructions on how to run the samples.
 */
component displayname="Create PDF With Proxy Server" {
    public CreatePDFWithProxyServer function init() {
        variables.java_Credentials = createObject("java", "com.adobe.pdfservices.operation.auth.Credentials");
        variables.java_ClientConfig = createObject("java", "com.adobe.pdfservices.operation.ClientConfig");
        variables.java_ClientConfig$ProxyScheme = createObject("java", "com.adobe.pdfservices.operation.ClientConfig$ProxyScheme");
        variables.java_ExecutionContext = createObject("java", "com.adobe.pdfservices.operation.ExecutionContext");
        variables.java_CreatePDFOperation = createObject("java", "com.adobe.pdfservices.operation.pdfops.CreatePDFOperation");
        variables.java_FileRef = createObject("java", "com.adobe.pdfservices.operation.io.FileRef");

        return this;
    }

    public void function run() {
        try {
            // Initial setup, create credentials instance.
            var credentials = variables.java_Credentials.serviceAccountCredentialsBuilder()
                .fromFile(application.credentialsJSONFile)
                .build();

            /*
            Initial setup, Create client config instance with proxy server configuration.
            Replace the values of PROXY_HOSTNAME with the proxy server hostname.
            If the scheme of proxy server is not HTTPS then, replace ProxyScheme parameter with HTTP.
            If the port for proxy server is diff than the default port for HTTP and HTTPS, then please set the PROXY_PORT,
                else, remove its setter statement.
            */

            // Create client config instance with custom time-outs.
            var clientConfig = variables.java_ClientConfig.builder()
                .withConnectTimeout(10000)
                .withSocketTimeout(40000)
                .withProxyScheme(variables.java_ClientConfig$ProxyScheme.HTTPS) // Replace it with HTTP if the proxy server scheme is http
                .withProxyHost("PROXY_HOSTNAME")
                .withProxyPort(443)
                .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            var executionContext = variables.java_ExecutionContext.create(credentials, clientConfig);
            var createPDFOperation = variables.java_CreatePDFOperation.createNew();

            // Set operation input from a source file.
            var source = variables.java_FileRef.createFromLocalFile(
                application.resourcesPath & "/createPDFInput.docx"
            );
            createPDFOperation.setInput(source);

            // Execute the operation.
            var result = createPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs(application.outputPath & "/createPDFWithProxyServer.pdf");
        }
        catch(any e) {
            writeLog("Exception encountered while executing operation: #e.message#");
        }
    }
}
