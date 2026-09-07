<%@ page import="operation.QueueOperation" %>
<%@ page import="operation_implementor.QueueOperationImpl" %>
<%@ page import="model.QueuePojo" %>
<%@ page import="java.util.List" %>

<%
QueueOperation op = new QueueOperationImpl();
List<QueuePojo> queues = op.getAllQueues();
%>

<!DOCTYPE html>
<html>
<head>
<title>Queue Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h3>Queue Management</h3>

<hr>

<h4>Add Queue</h4>

<form action="AdminController" method="post" class="mb-4">
    <input type="hidden" name="action" value="addQueue">

    <input class="form-control mb-2" name="queueID" placeholder="Queue ID (Q1)" required>
    <input class="form-control mb-2" name="counterID" placeholder="Counter ID (C1)" required>

    <button class="btn btn-success">Add Queue</button>
</form>

<hr>

<h4>Existing Queues</h4>

<table class="table table-bordered">
<tr>
    <th>Queue ID</th>
    <th>Counter ID</th>
    <th>Current Token</th>
    <th>Action</th>
</tr>

<% for(QueuePojo q : queues){ %>

<tr>
    <td><%= q.getQueueID() %></td>
    <td><%= q.getCounterID() %></td>
    <td><%= q.getCurrentToken() %></td>
    <td>

        <form action="AdminController" method="post" style="display:inline;">
            <input type="hidden" name="action" value="deleteQueue">
            <input type="hidden" name="queueID" value="<%= q.getQueueID() %>">
            <button class="btn btn-danger btn-sm">Delete</button>
        </form>

    </td>
</tr>

<% } %>

</table>

<a href="admin_dashboard.jsp" class="btn btn-secondary">Back</a>

</body>
</html>