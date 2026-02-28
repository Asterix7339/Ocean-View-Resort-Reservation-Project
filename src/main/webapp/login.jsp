<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>Login - Ocean View Resort</title>
</head>
<body>

<h2>Ocean View Resort Reservation System</h2>
<a href="login.jsp">Go to Login</a>

<% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>

<form action="login" method="post">
    <label>Username:</label><br/>
    <input type="text" name="username" required/><br/><br/>

    <label>Password:</label><br/>
    <input type="password" name="password" required/><br/><br/>

    <button type="submit">Login</button>
</form>

</body>
</html>