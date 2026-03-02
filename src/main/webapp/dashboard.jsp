<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // If not logged in, send back to login
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>

<h2>Dashboard</h2>

<p>Login success</p>
<p>Welcome: <%= session.getAttribute("username") %></p>
<p>Role: <%= session.getAttribute("role") %></p>
<br><br>
<%
    String role = (String) session.getAttribute("role");
    if ("ADMIN".equals(role)) {
%>
        <br><br>
        <a href="admin.jsp">Go to Admin Panel</a>
<%
    }
%>
<a href="logout">Logout</a>
<br><br>
<a href="add-reservation.jsp">Add New Reservation</a>
<br>
<a href="search-reservation.jsp">Search Reservation</a>
<br>
<a href="bill.jsp">Calculate Bill</a>
<br>
<a href="help.jsp">Help</a>
<br>
<a href="today-checkins">Today Check-ins Report</a>
<br>
<a href="all-reservations">All Reservations</a>
<br>
<a href="logout">Exit System</a>
</body>
</html>