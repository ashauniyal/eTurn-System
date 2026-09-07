package controller;

import operation.NotificationOperation;
import operation_implementor.NotificationOperationImpl;
import model.NotificationPojo;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/NotificationController")
public class NotificationController extends HttpServlet {

    NotificationOperation notificationOperation =
            new NotificationOperationImpl();

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("user") == null){
            response.sendRedirect("login.jsp");
            return;
        }

        int userID =
                ((model.UserPojo)session.getAttribute("user")).getUserID();

        List<NotificationPojo> list =
                notificationOperation.getNotificationsByUser(userID);

        request.setAttribute("notifications", list);

        RequestDispatcher rd =
                request.getRequestDispatcher("notifications.jsp");
        rd.forward(request, response);
    }
}