<%@ page import="java.sql.*" %>
<%@ page import="model.UserPojo" %>
<%@ page import="DBconfig.GetConnection" %>

<%
UserPojo user=(UserPojo)session.getAttribute("user");

if(user==null){
response.sendRedirect("login.jsp");
return;
}

Connection con=GetConnection.getConnection();

boolean joined=false;
String queueID="";
int userID=user.getUserID();

String check="SELECT * FROM Token WHERE userID=? AND status IN('Waiting','Called')";
PreparedStatement psCheck=con.prepareStatement(check);

psCheck.setInt(1,userID);

ResultSet rsCheck=psCheck.executeQuery();

if(rsCheck.next()){
joined=true;
queueID=rsCheck.getString("queueID");
}

if(request.getParameter("action")!=null){

if("join".equals(request.getParameter("action"))){

String q=request.getParameter("queueID");

PreparedStatement ps=con.prepareStatement("CALL GenerateToken(?,?)");

ps.setString(1,q);
ps.setInt(2,userID);

ps.executeUpdate();

response.sendRedirect("dashboard.jsp");

}

if("leave".equals(request.getParameter("action"))){

PreparedStatement ps=con.prepareStatement(
"DELETE FROM Token WHERE userID=? AND status='Waiting'"
);

ps.setInt(1,userID);

ps.executeUpdate();

response.sendRedirect("dashboard.jsp");

}

}
%>

<html>
<head>

<title>User Dashboard</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Oxygen,Ubuntu,Cantarell,'Open Sans',sans-serif;
}

/* SAME BACKGROUND AS REGISTER PAGE */

body{
background:linear-gradient(135deg,#1a2b4c 0%,#2c3e50 100%);
min-height:100vh;
padding:30px;
}

/* HEADER */

.header{
background:linear-gradient(135deg,#0f2b4b 0%,#1e3a5f 100%);
padding:30px;
border-radius:20px;
color:white;
margin-bottom:25px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 25px 50px -12px rgba(0,0,0,0.25);
}

.header-title{
font-size:28px;
font-weight:600;
}

.header-sub{
color:#a0c0e0;
font-size:14px;
margin-top:5px;
}

.user-box{
display:flex;
align-items:center;
gap:15px;
}

.user-badge{
background:rgba(255,255,255,0.1);
padding:8px 15px;
border-radius:20px;
color:white;
}

.logout-btn{
background:#ff4d4d;
border:none;
padding:8px 16px;
border-radius:10px;
color:white;
cursor:pointer;
}

/* MAIN CARD */

.container{
max-width:850px;
margin:auto;
background:white;
padding:30px;
border-radius:20px;
box-shadow:0 25px 50px -12px rgba(0,0,0,0.25);
}

/* QUEUE CARDS */

.queue{
border:2px solid #e8ecf1;
padding:15px;
margin:12px 0;
border-radius:14px;
display:flex;
justify-content:space-between;
align-items:center;
}

button{
padding:10px 18px;
background:linear-gradient(135deg,#1e3a5f 0%,#0f2b4b 100%);
color:white;
border:none;
border-radius:10px;
cursor:pointer;
}

.leave{
background:#dc3545;
}

/* TABLE */

table{
width:100%;
border-collapse:collapse;
margin-top:20px;
}

table th{
background:#1e3a5f;
color:white;
padding:10px;
}

table td{
padding:10px;
border:1px solid #ddd;
text-align:center;
}

</style>

</head>

<body>

<!-- HEADER -->

<div class="header">

<div>
<div class="header-title">Welcome back, <%=user.getName()%></div>
<div class="header-sub">eTurn System - Queue Management Portal</div>
</div>

<div class="user-box">

<div class="user-badge">
 <%=user.getName()%>
</div>

<form action="UserController" method="post">
<input type="hidden" name="action" value="logout">
<button class="logout-btn">Logout</button>
</form>

</div>

</div>


<div class="container">

<%
if(joined){
%>

<h3>You joined Queue : <%=queueID%></h3>

<form method="post">

<input type="hidden" name="action" value="leave">

<button class="leave">Leave Queue</button>

</form>

<br>

<%
}
%>

<h2>Available Queues</h2>

<%
PreparedStatement ps=con.prepareStatement("SELECT * FROM Queue");
ResultSet rs=ps.executeQuery();

while(rs.next()){
%>

<div class="queue">

<div>
Queue : <b><%=rs.getString("queueID")%></b>
</div>

<%
if(!joined){
%>

<form method="post">

<input type="hidden" name="action" value="join">
<input type="hidden" name="queueID" value="<%=rs.getString("queueID")%>">

<button>Join Queue</button>

</form>

<%
}
%>

</div>

<%
}
%>


<!-- QUEUE STATUS TABLE -->

<table>

<tr>
<th>Queue ID</th>
<th>Person Being Served</th>
<th>People Waiting</th>
</tr>

<%
PreparedStatement statusPS=con.prepareStatement(
"SELECT q.queueID,"+
"(SELECT tokenNumber FROM Token t WHERE t.queueID=q.queueID AND status='Called' LIMIT 1) AS currentToken,"+
"(SELECT COUNT(*) FROM Token t WHERE t.queueID=q.queueID AND status='Waiting') AS waitingCount "+
"FROM Queue q"
);

ResultSet statusRS=statusPS.executeQuery();

while(statusRS.next()){
%>

<tr>

<td><%=statusRS.getString("queueID")%></td>

<td>
<%
if(statusRS.getInt("currentToken")==0){
out.print("None");
}else{
out.print(statusRS.getInt("currentToken"));
}
%>
</td>

<td><%=statusRS.getInt("waitingCount")%></td>

</tr>

<%
}
%>

</table>

</div>

</body>
</html>