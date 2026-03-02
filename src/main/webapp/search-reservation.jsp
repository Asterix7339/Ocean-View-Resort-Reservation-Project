<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Search Reservation</title>
</head>
<body>

<h2>Search Reservation Details</h2>

<form method="get" action="view-reservation">
    <label>Reservation Number:</label>
    <input type="text" name="reservationNumber" required />
    <button type="submit">Search</button>
</form>

<br>
<a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>