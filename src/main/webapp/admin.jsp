<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");
    if (!"ADMIN".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Panel</title>
</head>
<body>

<h2>Admin Panel </h2>
<p>Only ADMIN can see this page.</p>

<a href="dashboard.jsp">Back to Dashboard</a> |
<br><br>
<a href="register-receptionist.jsp">Register Receptionist</a>
<br><br>
<a href="manage-room-stock.jsp">Manage Room Stock</a>
<a href="logout">Logout</a>

</body>
</html>