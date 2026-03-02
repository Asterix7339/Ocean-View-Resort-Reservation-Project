<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Calculate Bill</title>
</head>
<body>

<h2>Calculate & Print Bill</h2>

<form method="get" action="calculate-bill">
    <label>Reservation Number:</label>
    <input type="text" name="reservationNumber" required />
    <button type="submit">Calculate Bill</button>
</form>

<br>
<a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>