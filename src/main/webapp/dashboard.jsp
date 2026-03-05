<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.dao.RoomSummaryDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="com.oceanview.model.RoomSummary" %>

<%
    // If not logged in, send back to login
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Load data for dashboard (simple approach)
    ReservationDAO reservationDAO = new ReservationDAO();
    RoomSummaryDAO roomSummaryDAO = new RoomSummaryDAO();

    List<Reservation> todayCheckins = reservationDAO.findTodayCheckIns();
    List<RoomSummary> roomSummary = roomSummaryDAO.getTodaySummary();

    int todayCheckinsCount = (todayCheckins == null) ? 0 : todayCheckins.size();

    int totalOccupied = 0;
    if (roomSummary != null) {
        for (RoomSummary s : roomSummary) {
            totalOccupied += s.getOccupiedRooms();
        }
    }
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dashboard</title>

   <jsp:include page="includes/head.jsp" />

</head>

<body>

<!-- Navbar include (your existing include) -->
<jsp:include page="includes/navbar.jsp" />

<div class="container-fluid px-3 px-lg-4 page-wrap">

    <!-- Header -->
    <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-2 mb-4">
        <div>
            <h1 class="h3 mb-1 fw-semibold">Dashboard</h1>
            <p class="text-secondary mb-0">
                Today’s overview of occupancy, check-ins, and availability.
            </p>
        </div>

        <!-- Optional: quick actions area (no backend changes, only links you already have) -->
        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-primary" href="add-reservation.jsp">
                + New Reservation
            </a>
            <a class="btn btn-sm btn-outline-secondary" href="all-reservations">
                View All
            </a>
        </div>
    </div>

    <!-- ===== Summary / KPI Cards ===== -->
    <div class="row g-3 mb-4">

        <!-- KPI 1: Total Occupied -->
        <div class="col-12 col-md-6 col-xl-4">
            <div class="surface-card kpi-card h-100 p-3">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-secondary small">Total Occupied (Today)</div>
                        <div class="kpi-value fw-bold mt-1"><%= totalOccupied %></div>
                    </div>
                    <span class="badge text-bg-primary rounded-pill">Live</span>
                </div>
                <div class="text-secondary small mt-2">
                    Rooms currently occupied across all types.
                </div>
            </div>
        </div>

        <!-- KPI 2: Today Check-ins -->
        <div class="col-12 col-md-6 col-xl-4">
            <div class="surface-card kpi-card h-100 p-3">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-secondary small">Today Check-ins</div>
                        <div class="kpi-value fw-bold mt-1"><%= todayCheckinsCount %></div>
                    </div>
                    <span class="badge text-bg-success rounded-pill">Today</span>
                </div>
                <div class="text-secondary small mt-2">
                    Guests scheduled to check-in today.
                </div>
            </div>
        </div>

        <!-- KPI 3: Rooms Available (Today) -->
        <div class="col-12 col-xl-4">
            <div class="surface-card h-100 p-3">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <div class="text-secondary small">Rooms Available (Today)</div>
                        <div class="fw-semibold mt-1">By Room Type</div>
                    </div>
                    <span class="badge text-bg-light border rounded-pill">Summary</span>
                </div>

                <div class="mt-3 d-grid gap-2">
                    <%
                        if (roomSummary == null || roomSummary.isEmpty()) {
                    %>
                        <div class="alert alert-warning mb-0 rounded-3">
                            No room data
                        </div>
                    <%
                        } else {
                            for (RoomSummary s : roomSummary) {
                    %>
                        <div class="availability-item d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-2">
                                <span class="badge text-bg-primary-subtle text-primary border rounded-pill">
                                    <%= s.getRoomTypeCode() %>
                                </span>
                                <span class="text-secondary small">Available</span>
                            </div>
                            <div class="fw-semibold">
                                <%= s.getAvailableRooms() %>
                            </div>
                        </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>

    </div>

    <!-- ===== Today Check-ins Table ===== -->
    <div class="surface-card p-3 p-lg-4">

        <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-2 mb-3">
            <div>
                <h2 class="h5 mb-1 fw-semibold">Today Check-ins Report</h2>
                <p class="text-secondary mb-0 small">
                    Quick access to view, update, billing, or removal actions.
                </p>
            </div>

            <!-- Optional: hint -->
            <div class="text-secondary small">
                Tip: Use the navbar search to find a reservation fast.
            </div>
        </div>

        <%
            if (todayCheckins == null || todayCheckins.isEmpty()) {
        %>
            <div class="alert alert-success rounded-3 mb-0">
                No check-ins today ✅
            </div>
        <%
            } else {
        %>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Reservation No</th>
                        <th>Guest Name</th>
                        <th>Contact</th>
                        <th>Room Type ID</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th class="text-end">Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        for (Reservation r : todayCheckins) {
                    %>
                    <tr>
                        <td class="fw-semibold"><%= r.getReservationNumber() %></td>
                        <td><%= r.getGuestName() %></td>
                        <td><%= r.getContactNumber() %></td>
                        <td><span class="badge text-bg-light border"><%= r.getRoomTypeId() %></span></td>
                        <td><%= r.getCheckIn() %></td>
                        <td><%= r.getCheckOut() %></td>
                        <td class="text-end action-links">
                            <a class="btn btn-sm btn-outline-primary"
                               href="reservation?action=view&reservationNumber=<%= r.getReservationNumber() %>">
                                View
                            </a>

                            <a class="btn btn-sm btn-outline-secondary"
                               href="reservation?action=edit&reservationNumber=<%= r.getReservationNumber() %>">
                                Update
                            </a>

                            <a class="btn btn-sm btn-outline-success"
                               href="reports?action=bill&reservationNumber=<%= r.getReservationNumber() %>">
                                Bill
                            </a>

                            <!-- Remove (Bootstrap modal confirmation) -->
                            <button type="button"
                                    class="btn btn-sm btn-outline-danger"
                                    data-bs-toggle="modal"
                                    data-bs-target="#confirmDeleteModal"
                                    data-delete-url="reservation?action=delete&reservationNumber=<%= r.getReservationNumber() %>"
                                    data-res-no="<%= r.getReservationNumber() %>">
                                Remove
                            </button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

        <%
            }
        %>
    </div>

    <!-- Footer -->
    <footer class="text-center text-secondary small mt-4">
        <div class="py-3">
            © <%= java.time.Year.now() %> Ocean View Resort · All rights reserved
        </div>
    </footer>

</div>

<!-- Delete Confirmation Modal (no backend change; just better UI) -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="confirmDeleteLabel">Confirm Removal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-0">
                <div class="alert alert-warning rounded-3 mb-0">
                    Are you sure you want to delete reservation
                    <span class="fw-semibold" id="deleteResNo">#</span> ?
                </div>
                <p class="text-secondary small mt-2 mb-0">
                    This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <a href="#" class="btn btn-danger" id="confirmDeleteBtn">Yes, Remove</a>
            </div>
        </div>
    </div>
</div>



<script>
    // Wire delete modal to the correct reservation delete URL (keeps your backend URL exactly)
    const deleteModal = document.getElementById('confirmDeleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const deleteResNo = document.getElementById('deleteResNo');

    deleteModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const deleteUrl = button.getAttribute('data-delete-url');
        const resNo = button.getAttribute('data-res-no');

        confirmDeleteBtn.setAttribute('href', deleteUrl);
        deleteResNo.textContent = resNo;
    });
</script>
<jsp:include page="includes/scripts.jsp" />

</body>
</html>