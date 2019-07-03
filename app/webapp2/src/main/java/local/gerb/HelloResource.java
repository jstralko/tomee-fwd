package local.gerb;

import javax.ws.rs.*;

@Path("webapp2")
public class HelloResource {

    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getMessage() {
        return "Hello From Webapp2 Rest Resource";
    }
}
