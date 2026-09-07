<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | eTurn System</title>

<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Oxygen,Ubuntu,Cantarell,'Open Sans',sans-serif;
}

body{
background:linear-gradient(135deg,#1a2b4c 0%,#2c3e50 100%);
min-height:100vh;
display:flex;
align-items:center;
justify-content:center;
padding:20px;
}

.hybrid-container{
width:100%;
max-width:480px;
margin:auto;
}

.card{
background:#ffffff;
border-radius:24px;
box-shadow:0 25px 50px -12px rgba(0,0,0,0.25);
overflow:hidden;
}

.card-header{
background:linear-gradient(135deg,#0f2b4b 0%,#1e3a5f 100%);
padding:35px 30px 30px;
text-align:center;
position:relative;
}

.app-title{
color:#ffffff;
font-size:34px;
font-weight:600;
margin-bottom:8px;
}

.app-subtitle{
color:#a0c0e0;
font-size:16px;
}

.card-body{
padding:40px 30px;
background:#ffffff;
}

form{
width:100%;
display:flex;
flex-direction:column;
}

form input[type="text"],
form input[type="email"],
form input[type="password"]{
width:100%;
padding:16px 20px;
margin:8px 0 20px 0;
border:2px solid #e8ecf1;
border-radius:14px;
font-size:16px;
background:#ffffff;
transition:all 0.3s ease;
}

form input:focus{
outline:none;
border-color:#1e3a5f;
box-shadow:0 0 0 4px rgba(30,58,95,0.1);
}

form button{
width:100%;
padding:18px;
background:linear-gradient(135deg,#1e3a5f 0%,#0f2b4b 100%);
color:white;
border:none;
border-radius:14px;
font-size:18px;
font-weight:600;
cursor:pointer;
margin-top:10px;
}

form button:hover{
transform:translateY(-2px);
}

.login-link{
text-align:center;
margin-top:15px;
}

.login-link a{
color:#1e3a5f;
font-weight:700;
text-decoration:none;
}

/* Notification */
.notification{
padding:12px;
border-radius:10px;
text-align:center;
margin-bottom:15px;
font-weight:600;
}

.success{
background:#e6ffed;
color:#0f5132;
}

.error{
background:#ffe6e6;
color:#b30000;
}
</style>
</head>

<body>

<div class="hybrid-container">
<div class="card">

<div class="card-header">
<div class="app-title">eTurn System</div>
<div class="app-subtitle">Queue Management Portal</div>
</div>

<div class="card-body">

<%
String error = request.getParameter("error");
String msg = request.getParameter("msg");

if("failed".equals(error)){
%>
<div class="notification error">
Registration failed or email already registered!
</div>
<%
}

if("registered".equals(msg)){
%>
<div class="notification success">
Registration successful! Please login.
</div>
<%
}
%>

<form action="UserController" method="post">

<input type="hidden" name="action" value="register">
Name:
<input type="text" name="name">
Email:
<input type="email" name="email">
Contact:
<input type="text" name="contactNumber">
Password:
<input type="password" name="password">
<button type="submit">Register</button>

</form>

<div class="login-link">
Already have an account?
<a href="login.jsp">Log in</a>
</div>

</div>
</div>
</div>

</body>
</html>