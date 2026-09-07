<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
<title>Login | eTurn System</title>

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

.card-header::after{
content:'';
position:absolute;
bottom:0;
left:0;
right:0;
height:30px;
background:linear-gradient(to bottom right, transparent 49%, #ffffff 50%);
}

.app-title{
color:#ffffff;
font-size:34px;
font-weight:600;
margin-bottom:8px;
letter-spacing:0.5px;
}

.app-subtitle{
color:#a0c0e0;
font-size:16px;
}

.card-body{
padding:40px 30px;
background:#ffffff;
}

/* LOGIN ERROR NOTIFICATION */

.notification{
background:#ffe6e6;
color:#b30000;
padding:12px;
border-radius:10px;
text-align:center;
font-weight:600;
margin-bottom:15px;
}

/* FORM STYLE */

form{
width:100%;
}

form input[type="email"],
form input[type="password"]{
width:100%;
padding:16px 20px;
margin:8px 0 20px 0;
border:2px solid #e8ecf1;
border-radius:14px;
font-size:16px;
}

form input[type="email"]:focus,
form input[type="password"]:focus{
outline:none;
border-color:#1e3a5f;
box-shadow:0 0 0 4px rgba(30,58,95,0.1);
}

form br{
display:none;
}

form button[type="submit"]{
width:100%;
padding:18px;
background:linear-gradient(135deg,#1e3a5f 0%,#0f2b4b 100%);
color:white;
border:none;
border-radius:14px;
font-size:18px;
font-weight:600;
cursor:pointer;
margin:10px 0 15px 0;
}

.login-options{
display:flex;
justify-content:space-between;
align-items:center;
margin:20px 0;
font-size:14px;
}

.remember-me{
display:flex;
align-items:center;
gap:8px;
color:#5f7d9c;
}

.forgot-password{
color:#1e3a5f;
text-decoration:none;
font-weight:600;
border-bottom:2px solid #e8ecf1;
padding-bottom:2px;
}

.register-link{
text-align:center;
margin-top:25px;
color:#5f7d9c;
font-size:15px;
}

.register-link a{
color:#1e3a5f;
font-weight:700;
text-decoration:none;
margin-left:8px;
border-bottom:2px solid #e8ecf1;
padding-bottom:2px;
}

</style>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>

<body>

<div class="hybrid-container">
<div class="card">

<div class="card-header">
<div class="app-title">eTurn System</div>
<div class="app-subtitle">Queue Management Portal</div>
</div>

<div class="card-body">

<!-- LOGIN FAILED NOTIFICATION -->

<%
String error = request.getParameter("error");

if("invalid".equals(error)){
%>

<div class="notification">
Invalid email or password. Please try again.
</div>

<%
}
%>

<!-- ORIGINAL LOGIN FORM (UNCHANGED) -->

<form action="UserController" method="post">

<input type="hidden" name="action" value="login">

Email: <input type="email" name="email"><br>
Password: <input type="password" name="password"><br>

<button type="submit">Login</button>

</form>

<!-- LOGIN OPTIONS -->

<div class="login-options">
<label class="remember-me">
<input type="checkbox"> Remember me
</label>

<a href="#" class="forgot-password">Forgot Password?</a>
</div>

<div class="register-link">
Don't have an account?
<a href="register.jsp">Register here</a>
</div>

</div>
</div>
</div>

</body>
</html>