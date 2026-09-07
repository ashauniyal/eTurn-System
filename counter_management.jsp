<%@ page import="java.sql.*" %>
<%@ page import="DBconfig.GetConnection" %>

<%
Connection con = GetConnection.getConnection();
String msg="";

/* CHECK IF QUEUE EXISTS */
boolean queueExists=false;

PreparedStatement checkQueue = con.prepareStatement("SELECT * FROM Queue LIMIT 1");
ResultSet rsQueueCheck = checkQueue.executeQuery();

if(rsQueueCheck.next()){
    queueExists=true;
}

/* CREATE QUEUE */
if(request.getParameter("action")!=null){

    if("create".equals(request.getParameter("action"))){

        String queueID=request.getParameter("queueID");
        String counterID=request.getParameter("counterID");

        String insert="INSERT INTO Queue(queueID,counterID,currentToken) VALUES(?,?,0)";
        PreparedStatement psInsert=con.prepareStatement(insert);

        psInsert.setString(1,queueID);
        psInsert.setString(2,counterID);

        psInsert.executeUpdate();

        msg="Queue created successfully!";
    }

    /* DELETE QUEUE */
    if("delete".equals(request.getParameter("action"))){

        String queueID=request.getParameter("queueID");

        String delete="DELETE FROM Queue WHERE queueID=?";
        PreparedStatement psDelete=con.prepareStatement(delete);

        psDelete.setString(1,queueID);
        psDelete.executeUpdate();

        msg="Queue deleted!";
    }
}

/* CALL NEXT TOKEN */
if(request.getParameter("callQueue")!=null){

String q=request.getParameter("callQueue");

PreparedStatement ps=con.prepareStatement("CALL CallNextToken(?)");
ps.setString(1,q);
ps.executeUpdate();

msg="Next token called!";
}
%>

<html>
<head>

<title>Counter Management</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:40px;
}

.container{
width:900px;
margin:auto;
background:white;
padding:30px;
border-radius:8px;
box-shadow:0 5px 20px rgba(0,0,0,0.08);
}

.topbar{
display:flex;
justify-content:flex-end;
margin-bottom:10px;
}

.logout{
background:#0b2545;
color:white;
border:none;
padding:10px 18px;
cursor:pointer;
border-radius:4px;
}

input,select,button{
padding:10px;
margin:8px;
}

button{
background:#0b2545;
color:white;
border:none;
cursor:pointer;
border-radius:4px;
}

button:hover{
background:#133b6b;
}

.delete{
background:#b71c1c;
}

.delete:hover{
background:#8a1212;
}

table{
width:100%;
border-collapse:collapse;
margin-top:20px;
}

th,td{
padding:10px;
border:1px solid #ddd;
text-align:center;
}

th{
background:#0b2545;
color:white;
}

</style>

</head>

<body>

<div class="container">
<a href="admin_dashboard.jsp" class="btn btn-light mb-3">
Go Back
</a>

<!-- CREATE QUEUE (VISIBLE ONLY IF NO QUEUE EXISTS) -->
<% if(!queueExists){ %>

<h2>Create Queue</h2>

<form method="post">

<input type="hidden" name="action" value="create">

<input type="text" name="queueID" placeholder="Queue ID" required>

<select name="counterID">

<%
PreparedStatement psC=con.prepareStatement("SELECT counterID FROM Counter WHERE status='Active'");
ResultSet rsC=psC.executeQuery();

while(rsC.next()){
%>

<option value="<%=rsC.getString("counterID")%>">
<%=rsC.getString("counterID")%>
</option>

<%
}
%>

</select>

<button>Create Queue</button>

</form>

<% } %>

<!-- EXISTING QUEUE SECTION -->

<h2>Existing Queue</h2>

<%
PreparedStatement psQ=con.prepareStatement(
"SELECT q.queueID,c.serviceType FROM Queue q JOIN Counter c ON q.counterID=c.counterID"
);

ResultSet rsQ=psQ.executeQuery();

while(rsQ.next()){

String queueID=rsQ.getString("queueID");
%>

<form method="post">

Queue : <b><%=queueID%></b> 
(Service : <%=rsQ.getString("serviceType")%>)

<input type="hidden" name="queueID" value="<%=queueID%>">
<input type="hidden" name="action" value="delete">

<button class="delete">Delete Queue</button>

</form>

<br>

<form method="post">

<input type="hidden" name="callQueue" value="<%=queueID%>">

<button>Call Next Token</button>

</form>

<!-- TOKENS TABLE -->
<table>

<tr>
<th>User</th>
<th>Token</th>
<th>Status</th>
</tr>

<%
PreparedStatement psUsers=con.prepareStatement(
"SELECT u.name,t.tokenNumber,t.status "+
"FROM Token t "+
"JOIN Users u ON t.userID=u.userID "+
"WHERE t.queueID=? "+
"ORDER BY t.tokenNumber"
);

psUsers.setString(1,queueID);

ResultSet rsUsers=psUsers.executeQuery();

while(rsUsers.next()){
%>

<tr>

<td><%=rsUsers.getString("name")%></td>

<td><%=rsUsers.getInt("tokenNumber")%></td>

<td><%=rsUsers.getString("status")%></td>

</tr>

<%
}
%>

</table>

<br>

<!-- USER LINE STATUS TABLE -->
<h3>Queue Line Status</h3>

<table>

<tr>
<th>User</th>
<th>Token</th>
<th>Status</th>
<th>Position In Line</th>
</tr>

<%
PreparedStatement psLine=con.prepareStatement(
"SELECT t.tokenID,u.name,t.tokenNumber,t.status "+
"FROM Token t "+
"JOIN Users u ON t.userID=u.userID "+
"WHERE t.queueID=? "+
"ORDER BY t.tokenNumber"
);

psLine.setString(1,queueID);

ResultSet rsLine=psLine.executeQuery();

while(rsLine.next()){

int tokenID=rsLine.getInt("tokenID");

PreparedStatement psPos=con.prepareStatement(
"SELECT GetUserPosition(?)"
);

psPos.setInt(1,tokenID);

ResultSet rsPos=psPos.executeQuery();
rsPos.next();

%>

<tr>

<td><%=rsLine.getString("name")%></td>

<td><%=rsLine.getInt("tokenNumber")%></td>

<td><%=rsLine.getString("status")%></td>

<td><%=rsPos.getInt(1)%></td>

</tr>

<%
}
%>

</table>

<br><br>

<%
}
%>

<p style="color:green;"><%=msg%></p>

</div>

</body>
</html>