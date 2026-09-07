package controller;

import model.AdminPojo;
import model.CounterPojo;
import model.QueuePojo;
import operation.AdminOperation;
import operation_implementor.AdminOperationImpl;
import operation_implementor.CounterOperationImpl;
import operation_implementor.QueueOperationImpl;
import util.PasswordUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {

    AdminOperation adminOperation = new AdminOperationImpl();
    CounterOperationImpl counterOperation = new CounterOperationImpl();
    QueueOperationImpl queueOperation = new QueueOperationImpl();

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        /* ================= LOGIN ================= */

        if ("login".equals(action)) {

            String username = request.getParameter("username");

            String password = PasswordUtil.hashPassword(
                    request.getParameter("password"));

            AdminPojo admin =
                    adminOperation.loginAdmin(username, password);

            if (admin != null) {

                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);

                response.sendRedirect("admin_dashboard.jsp");
                return;

            } else {

                response.sendRedirect("admin_login.jsp?error=invalid");
                return;
            }
        }

        /* ================= CALL NEXT TOKEN ================= */

        else if ("callNext".equals(action)) {

            String queueID = request.getParameter("queueID");

            adminOperation.callNextToken(queueID);

            response.sendRedirect("admin_dashboard.jsp?msg=called");
            return;
        }

        /* ================= ADD COUNTER ================= */

        else if ("addCounter".equals(action)) {

            CounterPojo counter = new CounterPojo();

            counter.setCounterID(request.getParameter("counterID"));
            counter.setServiceType(request.getParameter("serviceType"));
            counter.setStatus("Active");

            counterOperation.addCounter(counter);

            response.sendRedirect("counter_management.jsp");
            return;
        }

        /* ================= UPDATE COUNTER STATUS ================= */

        else if ("updateStatus".equals(action)) {

            String counterID = request.getParameter("counterID");
            String status = request.getParameter("status");

            counterOperation.updateStatus(counterID, status);

            response.sendRedirect("counter_management.jsp");
            return;
        }

        /* ================= DELETE COUNTER ================= */

        else if ("deleteCounter".equals(action)) {

            String counterID = request.getParameter("counterID");

            counterOperation.deleteCounter(counterID);

            response.sendRedirect("counter_management.jsp");
            return;
        }

        /* ================= ADD QUEUE ================= */

        else if ("addQueue".equals(action)) {

            QueuePojo queue = new QueuePojo();

            queue.setQueueID(request.getParameter("queueID"));
            queue.setCounterID(request.getParameter("counterID"));

            queueOperation.createQueue(queue);

            response.sendRedirect("queue_management.jsp");
            return;
        }

        /* ================= DELETE QUEUE ================= */

        else if ("deleteQueue".equals(action)) {

            String queueID = request.getParameter("queueID");

            queueOperation.deleteQueue(queueID);

            response.sendRedirect("queue_management.jsp");
            return;
        }

        /* ================= LOGOUT ================= */

        else if ("logout".equals(action)) {

            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect("admin_login.jsp");
            return;
        }
    }
}