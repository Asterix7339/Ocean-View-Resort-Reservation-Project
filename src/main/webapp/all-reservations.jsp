<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="com.oceanview.dao.RoomTypeDAO" %>

<%
    // Must be logged in
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Reservation> list = (List<Reservation>) request.getAttribute("reservations");
    String q = (String) request.getAttribute("q");
    if (q == null) q = "";
    RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
%>

<html>
<head>
    <title>All Reservations</title>
</head>
<body>

<h2>All Reservations</h2>

<form method="get" action="all-reservations">
    <label>Search (Reservation No / Guest Name / Contact):</label>
    <input type="text" name="q" value="<%= q %>" />
    <button type="submit">Search</button>
    <a href="all-reservations">Clear</a>
</form>

<br>

<%
    if (list == null || list.isEmpty()) {
%>
    <p>No reservations found ✅</p>
<%
    } else {
%>
    <table border="1" cellpadding="8">
        <tr>
            <th>Reservation No</th>
            <th>Guest Name</th>
            <th>Contact</th>
            <th>Room Type </th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Action</th>
        </tr>

        <%
            for (Reservation r : list) {
        %>
        <tr>
            <td><%= r.getReservationNumber() %></td>
            <td><%= r.getGuestName() %></td>
            <td><%= r.getContactNumber() %></td>
            <td><%= roomTypeDAO.getNameById(r.getRoomTypeId()) %></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td>
                <a href="view-reservation?reservationNumber=<%= r.getReservationNumber() %>">View</a>
                |
                <a href="edit-reservation?reservationNumber=<%= r.getReservationNumber() %>">Edit</a>
                |
                <a href="calculate-bill?reservationNumber=<%= r.getReservationNumber() %>">Bill</a>
                |

                <a href="delete-reservation?reservationNumber=<%= r.getReservationNumber() %>"
                   onclick="return confirm('Are you sure you want to delete this reservation?');">
                   Delete
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
<%
    }
%>

<br>
<a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>