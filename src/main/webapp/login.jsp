<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Ocean View Resort</title>
</head>
<body>

<h2>Ocean View Resort - Staff Login</h2>

<form method="post" action="login">
    <label>Username:</label>
    <input type="text" name="username" required />
    <br><br>

    <label>Password:</label>
    <input type="password" name="password" required />
    <br><br>

    <button type="submit">Login</button>
</form>

<br>
<a href="index.jsp">Back to Home</a>

</body>
</html>