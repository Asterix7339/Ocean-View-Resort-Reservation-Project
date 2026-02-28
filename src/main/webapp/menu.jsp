<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Menu - Ocean View</title>
</head>
<body>
<h2>Welcome, <%= username %> ✅</h2>
<p>Login is working.</p>
</body>
</html>