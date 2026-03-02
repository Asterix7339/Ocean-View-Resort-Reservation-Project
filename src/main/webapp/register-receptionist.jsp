<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Must be logged in
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Must be ADMIN
    String role = (String) session.getAttribute("role");
    if (!"ADMIN".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<html>
<head>
    <title>Register Receptionist</title>
</head>
<body>

<h2>Register Staff Account (Admin Only)</h2>

<form method="post" action="register-receptionist">
    <label>Username:</label>
    <input type="text" name="username" required />
    <br><br>

    <label>Password:</label>
    <input type="password" name="password" required />
    <br><br>

    <br><br>
    <label>Role:</label>
    <select name="role" required>
        <option value="">-- Select Role --</option>
        <option value="RECEPTIONIST">RECEPTIONIST</option>
        <option value="ADMIN">ADMIN</option>
    </select>
    <br><br>

    <button type="submit">Create Receptionist</button>
</form>

<br>
<a href="admin.jsp">Back to Admin Panel</a>

</body>
</html>