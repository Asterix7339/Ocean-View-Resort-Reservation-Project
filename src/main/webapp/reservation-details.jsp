<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="com.oceanview.dao.RoomTypeDAO" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
    RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
    String roomTypeName = roomTypeDAO.getNameById(r.getRoomTypeId());
%>

<html>
<head>
    <title>Reservation Details</title>
</head>
<body>

<h2>Reservation Details </h2>

<p><b>Reservation Number:</b> <%= r.getReservationNumber() %></p>
<p><b>Guest Name:</b> <%= r.getGuestName() %></p>
<p><b>Address:</b> <%= r.getAddress() %></p>
<p><b>Contact Number:</b> <%= r.getContactNumber() %></p>
<p><b>Room Type:</b> <%= roomTypeName %></p>
<p><b>Check-in:</b> <%= r.getCheckIn() %></p>
<p><b>Check-out:</b> <%= r.getCheckOut() %></p>
<p><b>Total Amount:</b> <%= r.getTotalAmount() %></p>

<br>
<a href="search-reservation.jsp">Search Another</a> |
<a href="dashboard.jsp">Dashboard</a>

</body>
</html>