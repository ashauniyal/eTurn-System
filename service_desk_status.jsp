<%@ page import="operation.QueueOperation" %>
<%@ page import="operation_implementor.QueueOperationImpl" %>
<%@ page import="model.QueuePojo" %>
<%@ page import="java.util.List" %>

<%
QueueOperationImpl queueOp = new QueueOperationImpl();
List<QueuePojo> queues = queueOp.getAllQueues();
%>

<!DOCTYPE html>
<html>
<head>

<title>Clinic Service Desk Status</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#1a2b4c 0%,#2c3e50 100%);
min-height:100vh;
padding:30px;
font-family:'Segoe UI',sans-serif;
}

.main-card{
background:white;
border-radius:18px;
padding:30px;
box-shadow:0 15px 40px rgba(0,0,0,0.2);
}

.table th{
background:#1e3a5f;
color:white;
}

h3{
color:#1e3a5f;
}

</style>

</head>

<body>

<div class="container">

<a href="counter_management.jsp" class="btn btn-light mb-3">
Go Back
</a>

<div class="main-card">

<h3>Clinic Service Desk Status</h3>

<hr>

<table class="table table-bordered text-center align-middle">

<tr>
<th>Queue ID</th>
<th>Counter</th>
<th>Status</th>
<th>Users Joined</th>
<th>Users Served</th>
<th>Remaining Users</th>
</tr>

<% for(QueuePojo q : queues){ %>

<tr>

<td><b><%= q.getQueueID() %></b></td>

<td><%= q.getCounterID() %></td>

<td>
<span class="badge bg-success">
Active
</span>
</td>

<td>--</td>

<td>--</td>

<td>--</td>

</tr>

<% } %>

</table>

</div>

</div>

</body>
</html>