<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.RoomSummary" %>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<RoomSummary> list = (List<RoomSummary>) request.getAttribute("summary");
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Rooms Availability</title>

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
            <h1 class="h3 mb-1 fw-semibold">Rooms Availability</h1>
            <p class="text-secondary mb-0">Today’s live snapshot of total, occupied, and available rooms.</p>
        </div>

        <a class="btn btn-sm btn-outline-secondary" href="dashboard.jsp">
            ← Back to Dashboard
        </a>
    </div>

    <!-- Content Card -->
    <div class="surface-card overflow-hidden">

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 p-3 p-lg-4 border-bottom">
            <div class="fw-semibold">Rooms Availability (Today)</div>
            <div class="text-secondary small">
                <%
                    int count = (list == null) ? 0 : list.size();
                %>
                Room types: <span class="fw-semibold"><%= count %></span>
            </div>
        </div>

        <div class="p-3 p-lg-4">

            <%
                if (list == null || list.isEmpty()) {
            %>
                <div class="alert alert-warning rounded-3 mb-0">
                    No data found ❌
                </div>
            <%
                } else {
            %>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th>Room Type</th>
                            <th>Total Rooms</th>
                            <th>Occupied Rooms</th>
                            <th>Available Rooms</th>
                        </tr>
                        </thead>

                        <tbody>
                        <%
                            for (RoomSummary s : list) {
                        %>
                        <tr>
                            <td class="fw-semibold">
                                <span class="badge text-bg-primary-subtle text-primary border metric-badge">
                                    <%= s.getRoomTypeCode() %>
                                </span>
                            </td>

                            <td>
                                <span class="badge text-bg-light border metric-badge">
                                    <%= s.getTotalRooms() %>
                                </span>
                            </td>

                            <td>
                                <span class="badge text-bg-warning-subtle text-warning border metric-badge">
                                    <%= s.getOccupiedRooms() %>
                                </span>
                            </td>

                            <td>
                                <span class="badge text-bg-success-subtle text-success border metric-badge">
                                    <%= s.getAvailableRooms() %>
                                </span>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>

                <!-- Optional: small note -->
                <div class="text-secondary small mt-3">
                    Values are generated from today’s summary report.
                </div>

            <%
                }
            %>

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