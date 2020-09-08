/**
 * This CFC is simply to make remote calls to the sample CFCs a bit more direct
 * without requiring them to be remote themselves.
 */
component displayname="Proxy" output="false" {
    remote void function run(required string cfcPath) {
        new "#arguments.cfcPath#"().run();
    }
}
