package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBconfig.GetConnection;

@WebServlet("/QRCodeController")
public class QRCodeController extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

String action = request.getParameter("action");
String queueID = request.getParameter("queueID");

Connection con = GetConnection.getConnection();

try{

if("delete".equals(action)){

PreparedStatement ps = con.prepareStatement(
"DELETE FROM QRCode WHERE queueID=?");

ps.setString(1, queueID);
ps.executeUpdate();

}

if("create".equals(action)){

PreparedStatement ps = con.prepareStatement(
"INSERT INTO QRCode(queueID) VALUES(?)");

ps.setString(1, queueID);
ps.executeUpdate();

}

}catch(Exception e){
e.printStackTrace();
}

}
}