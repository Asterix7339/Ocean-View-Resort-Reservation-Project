<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    boolean loggedIn = (session != null && session.getAttribute("username") != null);
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Ocean View Resort</title>

   <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="assets/app.css">
   <link rel="stylesheet" href="assets/toast.css">


    <!-- Minimal enterprise theme (lightweight custom CSS) -->

</head>

<body>

<!-- NAVBAR (Enterprise / Bootstrap 5) -->
<nav class="navbar navbar-expand-lg app-navbar sticky-top">
    <div class="container-fluid px-3 px-lg-4">

        <!-- Brand -->
        <a class="navbar-brand d-flex align-items-center gap-2 fw-semibold" href="dashboard.jsp">
            <span class="brand-mark">OV</span>
            <span class="d-flex flex-column lh-sm">
                <span>Ocean View Resort</span>
                <small class="text-secondary fw-normal d-none d-sm-block">Reservation & Operations</small>
            </span>
        </a>

        <!-- Mobile toggler -->
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#appNavbar"
                aria-controls="appNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="appNavbar">

            <!-- Left: Links -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-lg-1">

                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp">
                        Dashboard
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="add-reservation.jsp">
                        New Reservation
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="all-reservations">
                        All Reservations
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="reports?action=roomsSummary">
                        Rooms Availability
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="help.jsp">
                        Help
                    </a>
                </li>

                <%
                    if ("ADMIN".equals(role)) {
                %>
                <!-- Admin only -->
                <li class="nav-item">
                    <a class="nav-link text-primary fw-semibold" href="admin.jsp"
                       data-bs-toggle="tooltip" data-bs-placement="bottom"
                       data-bs-title="Admin access">
                        Admin Panel
                    </a>
                </li>
                <%
                    }
                %>
            </ul>

            <!-- Right: Search + Logout (only when logged in) -->
            <div class="d-flex align-items-lg-center gap-2 gap-lg-3 flex-column flex-lg-row">

                <%
                    if (loggedIn) {
                %>
                <!-- Search -->
                <form class="app-search d-flex align-items-center gap-2"
                      action="reservation" method="get" style="margin:0;">
                    <input type="hidden" name="action" value="view" />

                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-white border-end-0">
                            <!-- Bootstrap Icon (inline SVG, no extra library needed) -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" class="bi bi-search text-secondary" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                            </svg>
                        </span>

                        <input type="text" class="form-control border-start-0"
                               name="reservationNumber"
                               placeholder="Search reservation #"
                               required
                               aria-label="Search reservation number"/>

                        <button class="btn btn-primary" type="submit">
                            Search
                        </button>
                    </div>
                </form>

                <!-- Logout -->
                <a class="btn btn-sm btn-outline-secondary"
                   href="logout"
                   data-bs-toggle="modal"
                   data-bs-target="#logoutConfirmModal"
                   role="button">
                    Logout
                </a>
                <%
                    }
                %>

            </div>
        </div>
    </div>
</nav>

<!-- OPTIONAL: Logout confirmation modal (Bootstrap JS interactivity)
     NOTE: This does not change backend. It only adds a confirmation UI.
     If you want instant logout without modal, remove data-bs-* attributes on the Logout button and remove this modal.
-->
<div class="modal fade" id="logoutConfirmModal" tabindex="-1" aria-labelledby="logoutConfirmLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow-sm border-0">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="logoutConfirmLabel">Confirm Logout</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-0">
                <div class="alert alert-warning d-flex align-items-start gap-2 mb-0 rounded-3">
                    <span class="fw-semibold">Are you sure?</span>
                    <span class="text-secondary">You will be signed out of the system.</span>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <a href="logout" class="btn btn-primary">Yes, Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Toast root (kept exactly) -->


<!-- Bootstrap JS bundle (includes Popper for dropdowns/modals/tooltips) -->
<script src="assets/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>

<!-- Your existing toast script (kept) -->

<!-- Bootstrap interactivity: tooltips + form validation (safe defaults) -->
<script>
    // Enable tooltips
    document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
        new bootstrap.Tooltip(el);
    });

    // Optional: prevent accidental modal trigger if not logged in (defensive)
    // (No backend changes; this is just UI behavior.)
</script>
<div id="toast-root"></div>
<script src="<%= request.getContextPath() %>/assets/toast.js"></script>
</body>
</html>