/**
 * @hint Executes a specific sample CFC from the currently running project server.
 */
component {
    property name="ServerService" inject="ServerService";

    void function run(required string cfcPath) {
        // Get server config data
        var config = expandPath("./server.json");
        var serverInfo = ServerService.getServerInfoByServerConfigFile(config);

        // Set URL and execute CFC method
        if (!serverInfo.isEmpty()) {
            var baseURL = serverInfo.defaultBaseURL;
            // Only try to process if server is actually running
            if (ServerService.isServerRunning(serverInfo)) {
                var cfcURL = "#baseURL#/components/proxy.cfc?method=run&cfcPath=#arguments.cfcPath#";
                cfhttp(result = "response", method = "POST", url = cfcURL);

                if(response.statusCode == "200 OK"){
                    print.line().greenLine( "Done!" );
                    print.line().yellow( "File generated in: " ).cyanLine( expandPath("./output") );
                } else {
                    print.line().redLine( "An error occurred while trying to execute the sample CFC: HTTP Status Code #response.statusCode#");
                    print.line().yellowLine( "Make sure the provided CFC path is correct." );
                }
            } else {
                print.line().redLine( "Could not find a running server in the current working directory!" );
                print.line().yellowLine( "Make sure:" );
                print.yellow( "* " ).cyanLine( "The server has been started and is running." );
            }
        }
        // Return error message if no data is found
        else {
            print.line().redLine( "Could not find a server config file in the current working directory!" );
            print.line().yellowLine( "Make sure:" );
            print.yellow( "* " ).cyanLine( "You are in the correct working directory where the server is running." );
            print.yellow( "* " ).cyanLine( "The server.json file has not been removed from the project root." );
        }
    }
}
