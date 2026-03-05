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

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reservation Details</title>

    <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/app.css">
    <link rel="stylesheet" href="assets/toast.css"> <!-- only if needed -->
</head>

<body>

<jsp:include page="includes/navbar.jsp" />

<div class="container-fluid px-3 px-lg-4 page-wrap">

    <!-- Header -->
    <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-2 mb-4">
        <div>
            <h1 class="h3 mb-1 fw-semibold">Reservation Details ✅</h1>
            <p class="text-secondary mb-0">
                Reservation #
                <span class="fw-semibold"><%= r.getReservationNumber() %></span>
            </p>
        </div>

        <div class="d-flex gap-2 flex-wrap">
            <a class="btn btn-sm btn-outline-secondary" href="search-reservation.jsp">
                Search Another
            </a>
            <a class="btn btn-sm btn-primary" href="dashboard.jsp">
                Dashboard
            </a>
        </div>
    </div>

    <!-- Details Card -->
    <div class="surface-card p-3 p-lg-4">

        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-3">
            <div class="fw-semibold">Reservation Information</div>
            <span class="badge text-bg-light border rounded-pill"><%= roomTypeName %></span>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <tbody>
                <tr>
                    <th class="text-secondary fw-semibold">Reservation Number</th>
                    <td class="fw-semibold"><%= r.getReservationNumber() %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Guest Name</th>
                    <td><%= r.getGuestName() %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Address</th>
                    <td><%= r.getAddress() %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Contact Number</th>
                    <td><%= r.getContactNumber() %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Room Type</th>
                    <td><%= roomTypeName %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Check-in</th>
                    <td><%= r.getCheckIn() %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Check-out</th>
                    <td><%= r.getCheckOut() %></td>
                </tr>
                <tr>
                    <th class="text-secondary fw-semibold">Total Amount</th>
                    <td><%= r.getTotalAmount() %></td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>

    <!-- Footer -->
    <footer class="text-center text-secondary small mt-4">
        <div class="py-3">
            © <%= java.time.Year.now() %> Ocean View Resort · All rights reserved
        </div>
    </footer>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>