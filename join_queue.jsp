<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<title>Join Queue</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#1a2b4c,#2c3e50);
min-height:100vh;
display:flex;
align-items:center;
justify-content:center;
font-family:'Segoe UI';
}

.card{
padding:30px;
border-radius:15px;
width:400px;
box-shadow:0 10px 30px rgba(0,0,0,0.3);
}

</style>

</head>

<body>

<div class="card">

<h4 class="text-center mb-4">Join Clinic Queue</h4>

<%
String queueID = request.getParameter("queueID");
if(queueID == null){
queueID = "";
}
%>

<form action="TokenController" method="post">

<input type="hidden" name="action" value="join">

<label class="form-label">Queue ID</label>

<input
type="text"
class="form-control mb-3"
name="queueID"
value="<%= queueID %>"
placeholder="Enter Queue ID"
required
>

<button class="btn btn-primary w-100">
Join Queue
</button>

</form>

</div>

</body>
</html>