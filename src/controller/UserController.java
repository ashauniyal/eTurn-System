package controller;

import model.QueuePojo;
import model.UserPojo;
import operation.UserOperation;
import operation_implementor.CounterOperationImpl;
import operation_implementor.UserOperationImpl;
import util.PasswordUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserController")
public class UserController extends HttpServlet {

    UserOperation userOperation = new UserOperationImpl();

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        /* REGISTER */
        if ("register".equals(action)) {

            String password = PasswordUtil.hashPassword(
                    request.getParameter("password"));

            UserPojo user = new UserPojo();
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            user.setContactNumber(request.getParameter("contactNumber"));
            user.setPassword(password);

            boolean result = userOperation.registerUser(user);

            if(result){
                response.sendRedirect("login.jsp?msg=registered");
            }else{
                response.sendRedirect("register.jsp?error=failed");
            }
        }

        /* LOGIN */
        else if ("login".equals(action)) {

            String email = request.getParameter("email");
            String password = PasswordUtil.hashPassword(
                    request.getParameter("password"));

            UserPojo user = userOperation.loginUser(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
            
        }
        
        else if("dashboard".equals(action)){

            HttpSession session = request.getSession(false);

            if(session == null || session.getAttribute("user") == null){
                response.sendRedirect("login.jsp");
                return;
            }

            CounterOperationImpl counterOp = new CounterOperationImpl();
            List<QueuePojo> list = counterOp.getAllQueuesWithService();

            request.setAttribute("queueList", list);

            RequestDispatcher rd =
                request.getRequestDispatcher("dashboard.jsp");
            rd.forward(request, response);
        }

        /* LOGOUT */
        else if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect("login.jsp");
        }
    }
}