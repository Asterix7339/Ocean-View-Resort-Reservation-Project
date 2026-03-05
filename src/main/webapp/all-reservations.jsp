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

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>All Reservations</title>

    <!-- Bootstrap 5.3+ -->
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
            <h1 class="h3 mb-1 fw-semibold">All Reservations</h1>
            <p class="text-secondary mb-0">Search, review, edit, billing, and manage reservations.</p>
        </div>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-primary" href="add-reservation.jsp">+ New Reservation</a>
            <a class="btn btn-sm btn-outline-secondary" href="dashboard.jsp">← Back to Dashboard</a>
        </div>
    </div>

    <!-- Search Card -->
    <div class="surface-card p-3 p-lg-4 mb-3">
        <form method="get" action="all-reservations" class="row g-2 align-items-center">
            <div class="col-12 col-lg-8">
                <label class="form-label fw-semibold mb-1">
                    Search (Reservation No / Guest Name / Contact)
                </label>

                <div class="input-group">
                    <span class="input-group-text bg-white">
                        <!-- search icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                             fill="currentColor" class="bi bi-search text-secondary" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                        </svg>
                    </span>

                    <input type="text" name="q" value="<%= q %>" class="form-control"
                           placeholder="Type reservation #, guest name, or contact..." />
                </div>

                <div class="form-text text-secondary">
                    Example: <span class="fw-semibold">RES-10021</span> or <span class="fw-semibold">Satham</span>
                </div>
            </div>

            <div class="col-12 col-lg-4 d-flex gap-2 justify-content-lg-end mt-2 mt-lg-4">
                <button type="submit" class="btn btn-primary">Search</button>
                <a href="all-reservations" class="btn btn-light">Clear</a>
            </div>
        </form>
    </div>

    <!-- Results Card -->
    <div class="surface-card p-0 overflow-hidden">

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 p-3 p-lg-4 border-bottom">
            <div class="fw-semibold">Reservation List</div>
            <div class="text-secondary small">
                <%
                    int count = (list == null) ? 0 : list.size();
                %>
                Total: <span class="fw-semibold"><%= count %></span>
            </div>
        </div>

        <div class="p-3 p-lg-4">

            <%
                if (list == null || list.isEmpty()) {
            %>
                <div class="alert alert-success rounded-3 mb-0">
                    No reservations found ✅
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
                            <th>Room Type</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                            <th class="text-end">Action</th>
                        </tr>
                        </thead>

                        <tbody>
                        <%
                            for (Reservation r : list) {
                        %>
                        <tr>
                            <td class="fw-semibold"><%= r.getReservationNumber() %></td>
                            <td><%= r.getGuestName() %></td>
                            <td><%= r.getContactNumber() %></td>
                            <td>
                                <span class="badge text-bg-light border">
                                    <%= roomTypeDAO.getNameById(r.getRoomTypeId()) %>
                                </span>
                            </td>
                            <td><%= r.getCheckIn() %></td>
                            <td><%= r.getCheckOut() %></td>

                            <td class="text-end action-btns">
                                <div class="d-inline-flex flex-wrap gap-1 justify-content-end">

                                    <a class="btn btn-sm btn-outline-primary"
                                       href="reservation?action=view&reservationNumber=<%= r.getReservationNumber() %>">
                                        View
                                    </a>

                                    <a class="btn btn-sm btn-outline-secondary"
                                       href="reservation?action=edit&reservationNumber=<%= r.getReservationNumber() %>">
                                        Edit
                                    </a>

                                    <a class="btn btn-sm btn-outline-success"
                                       href="reports?action=bill&reservationNumber=<%= r.getReservationNumber() %>">
                                        Bill
                                    </a>

                                    <!-- Delete -> Bootstrap modal confirmation (same backend URL) -->
                                    <button type="button"
                                            class="btn btn-sm btn-outline-danger"
                                            data-bs-toggle="modal"
                                            data-bs-target="#confirmDeleteModal"
                                            data-delete-url="reservation?action=delete&reservationNumber=<%= r.getReservationNumber() %>"
                                            data-res-no="<%= r.getReservationNumber() %>">
                                        Delete
                                    </button>

                                </div>
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
    </div>

    <!-- Footer -->
    <footer class="text-center text-secondary small mt-4">
        <div class="py-3">
            © <%= java.time.Year.now() %> Ocean View Resort · All rights reserved
        </div>
    </footer>

</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="confirmDeleteLabel">Confirm Delete</h5>
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
                <a href="#" class="btn btn-danger" id="confirmDeleteBtn">Yes, Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Set correct delete URL in modal (keeps your backend URL exactly)
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
<div id="toast-root"></div>
<script src="assets/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/toast.js"></script>

<script>
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    new bootstrap.Tooltip(el);
  });
</script>
</body>
</html>