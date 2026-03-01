<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Must be logged in
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add Reservation</title>
</head>
<body>

<h2>Add New Reservation</h2>

<form method="post" action="add-reservation">

    <label>Reservation Number:</label>
    <input type="text" name="reservationNumber" required />
    <br><br>

    <label>Guest Name:</label>
    <input type="text" name="guestName" required />
    <br><br>

    <label>Address:</label>
    <input type="text" name="address" required />
    <br><br>

    <label>Contact Number:</label>
    <input type="text" name="contactNumber" required />
    <br><br>

    <label>Room Type:</label>
    <select name="roomTypeId" required>
        <option value="">-- Select --</option>
        <option value="1">STANDARD</option>
        <option value="2">DELUXE</option>
        <option value="3">SUITE</option>
    </select>
    <br><br>

    <label>Check-in Date:</label>
    <input type="date" name="checkIn" required />
    <br><br>

    <label>Check-out Date:</label>
    <input type="date" name="checkOut" required />
    <br><br>

    <button type="submit">Save Reservation</button>
</form>

<br>
<a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>