package local.gerb;

import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            String operationString = req.getParameter("op");

            if (operationString == null) {
                RequestDispatcher dispatcher;
                dispatcher = getServletContext().getContext("/web2").getRequestDispatcher("/servlet2");
                dispatcher.forward(req, resp);
            } else {
                RequestDispatcher dispatcher;
                dispatcher = getServletContext().getContext("/web2").getRequestDispatcher("/webapp2/hello");
                dispatcher.forward(req, resp);
            }

        } catch (Exception e) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw, true);
                e.printStackTrace(pw);
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, sw.toString());
            }
    }
}
