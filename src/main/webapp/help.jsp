<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Help</title>
</head>
<body>

<h2>Help - Ocean View Reservation System</h2>

<h3>1) Login</h3>
<p>Use your staff username and password to access the system.</p>

<h3>2) Add New Reservation</h3>
<ul>
    <li>Enter a unique reservation number.</li>
    <li>Fill guest details and select room type.</li>
    <li>Check-out date must be after check-in date.</li>
</ul>

<h3>3) Search Reservation</h3>
<p>Use the reservation number to view full reservation details.</p>

<h3>4) Calculate & Print Bill</h3>
<ul>
    <li>Enter reservation number.</li>
    <li>System calculates nights and total amount using room rate.</li>
    <li>Click “Print Bill” to print.</li>
</ul>

<h3>5) Logout</h3>
<p>Always logout after work to keep the system secure.</p>

<br>
<a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>