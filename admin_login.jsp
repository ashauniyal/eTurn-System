<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Login | eTurn System</title>

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

/* CONTAINER */

.container-box{
width:100%;
max-width:450px;
}

/* CARD */

.card{
background:white;
border-radius:24px;
box-shadow:0 25px 50px -12px rgba(0,0,0,0.25);
overflow:hidden;
}

/* HEADER */

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
color:white;
font-size:32px;
font-weight:600;
margin-bottom:6px;
}

.app-subtitle{
color:#a0c0e0;
font-size:15px;
}

/* BODY */

.card-body{
padding:40px 30px;
}

/* FORM */

form{
width:100%;
}

form input{
width:100%;
padding:16px 20px;
margin-bottom:18px;
border:2px solid #e8ecf1;
border-radius:14px;
font-size:16px;
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
}

form button:hover{
opacity:0.95;
}

</style>

</head>

<body>

<div class="container-box">

<div class="card">

<div class="card-header">

<div class="app-title">Admin Panel</div>
<div class="app-subtitle">eTurn System Management</div>

</div>

<div class="card-body">

<form action="AdminController" method="post">

<input type="hidden" name="action" value="login">

<input
class="form-control"
name="username"
placeholder="Username"
required
>

<input
class="form-control"
type="password"
name="password"
placeholder="Password"
required
>

<button type="submit">Login</button>

</form>

</div>

</div>

</div>

</body>
</html>