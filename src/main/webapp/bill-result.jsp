<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
    double rate = (double) request.getAttribute("rate");
    long nights = (long) request.getAttribute("nights");
    double total = (double) request.getAttribute("total");
%>
<html>
<head>
    <title>Bill</title>
</head>
<body>

<h2>Ocean View Resort - Bill</h2>

<p><b>Reservation Number:</b> <%= r.getReservationNumber() %></p>
<p><b>Guest Name:</b> <%= r.getGuestName() %></p>
<p><b>Check-in:</b> <%= r.getCheckIn() %></p>
<p><b>Check-out:</b> <%= r.getCheckOut() %></p>

<hr>

<p><b>Nights:</b> <%= nights %></p>
<p><b>Rate per night (LKR):</b> <%= rate %></p>
<p><b>Total (LKR):</b> <%= total %></p>

<br>
<button onclick="window.print()">Print Bill</button>

<br><br>
<a href="bill.jsp">Calculate Another</a> |
<a href="dashboard.jsp">Dashboard</a>

</body>
</html>