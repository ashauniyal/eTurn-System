package controller;

import operation.TokenOperation;
import operation_implementor.TokenOperationImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/TokenController")
public class TokenController extends HttpServlet {

    TokenOperation tokenOperation = new TokenOperationImpl();

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if("join".equals(action)){

            HttpSession session = request.getSession(false);

            if(session == null || session.getAttribute("user") == null){
                response.sendRedirect("login.jsp");
                return;
            }

            int userID = ((model.UserPojo)
                    session.getAttribute("user")).getUserID();

            String queueID = request.getParameter("queueID");

            tokenOperation.joinQueue(queueID, userID);

            response.sendRedirect("dashboard.jsp?msg=joined");
        }
    }
}