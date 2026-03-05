<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Reservation> list = (List<Reservation>) request.getAttribute("checkins");
%>

<html>
<head>
    <title>Today Check-ins</title>
</head>
<body>

<h2>Today Check-ins Report</h2>
<p><b>Total Today Check-ins:</b> <%= request.getAttribute("todayCheckinsCount") %></p>

<%
    if (list == null || list.isEmpty()) {
%>
        <p>No check-ins for today ✅</p>
<%
    } else {
%>
        <table border="1" cellpadding="8">
            <tr>
                <th>Reservation No</th>
                <th>Guest Name</th>
                <th>Contact</th>
                <th>Room Type ID</th>
                <th>Check-in</th>
                <th>Check-out</th>
            </tr>
            <%
                for (Reservation r : list) {
            %>
            <tr>
                <td><%= r.getReservationNumber() %></td>
                <td><%= r.getGuestName() %></td>
                <td><%= r.getContactNumber() %></td>
                <td><%= r.getRoomTypeId() %></td>
                <td><%= r.getCheckIn() %></td>
                <td><%= r.getCheckOut() %></td>
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