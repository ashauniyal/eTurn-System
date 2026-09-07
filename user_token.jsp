<%@ page import="model.UserPojo" %>
<%@ page import="model.TokenPojo" %>
<%@ page import="operation.TokenOperation" %>
<%@ page import="operation_implementor.TokenOperationImpl" %>

<%
UserPojo user = (UserPojo) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
}

TokenOperation op = new TokenOperationImpl();
TokenPojo token = op.getLatestToken(user.getUserID());

int position = 0;
if(token != null){
    position = op.getUserPosition(token.getTokenID());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Your Token</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<div class="card p-4 shadow">

<h3>Your Token Number: <%= token.getTokenNumber() %></h3>
<p>Status: <%= token.getStatus() %></p>
<p>Your Position: <%= position %></p>

<a href="dashboard.jsp" class="btn btn-secondary">Back</a>

</div>

</body>
</html>