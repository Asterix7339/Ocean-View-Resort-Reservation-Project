<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");
    if (!"ADMIN".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Panel</title>

    <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/app.css">
    <link rel="stylesheet" href="assets/toast.css"> <!-- only if needed -->

    <!-- Minimal enterprise theme -->

</head>

<body>

<jsp:include page="includes/navbar.jsp" />

<div class="container-fluid px-3 px-lg-4 page-wrap">

    <!-- Header -->
    <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-2 mb-4">
        <div>
            <h1 class="h3 mb-1 fw-semibold">Admin Panel <span class="ms-1">✅</span></h1>
            <p class="text-secondary mb-0">Only ADMIN can see this page.</p>
        </div>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-outline-secondary" href="dashboard.jsp">← Back to Dashboard</a>

            <!-- Keep the same logout link; just styled -->
            <a class="btn btn-sm btn-outline-danger" href="logout">Logout</a>
        </div>
    </div>

    <!-- Admin actions -->
    <div class="row g-3">

        <!-- Register Receptionist -->
        <div class="col-12 col-lg-6">
            <div class="surface-card action-card p-3 p-lg-4 h-100">
                <div class="d-flex align-items-start gap-3">
                    <div class="icon-pill" title="User Management" data-bs-toggle="tooltip" data-bs-placement="bottom">
                        <!-- person-plus icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                             class="bi bi-person-plus text-primary" viewBox="0 0 16 16">
                            <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                            <path d="M2 13s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1z"/>
                            <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
                        </svg>
                    </div>

                    <div class="flex-grow-1">
                        <div class="fw-semibold">Register Receptionist</div>
                        <div class="text-secondary small mt-1">
                            Create receptionist accounts for front-desk reservation handling.
                        </div>

                        <div class="mt-3">
                            <a href="register-receptionist.jsp" class="btn btn-primary">
                                Open Registration
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Manage Room Stock -->
        <div class="col-12 col-lg-6">
            <div class="surface-card action-card p-3 p-lg-4 h-100">
                <div class="d-flex align-items-start gap-3">
                    <div class="icon-pill" title="Room Inventory" data-bs-toggle="tooltip" data-bs-placement="bottom">
                        <!-- building icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                             class="bi bi-building text-primary" viewBox="0 0 16 16">
                            <path d="M4 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5V14h1a.5.5 0 0 1 0 1H3a.5.5 0 0 1 0-1h1zM5 3v11h6V3z"/>
                            <path d="M6.5 4.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5zM6.5 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5zM6.5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5z"/>
                        </svg>
                    </div>

                    <div class="flex-grow-1">
                        <div class="fw-semibold">Manage Room Stock</div>
                        <div class="text-secondary small mt-1">
                            Maintain room type counts and ensure inventory accuracy.
                        </div>

                        <div class="mt-3">
                            <a href="manage-room-stock.jsp" class="btn btn-primary">
                                Manage Rooms
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <footer class="text-center text-secondary small mt-4">
        <div class="py-3">
            © <%= java.time.Year.now() %> Ocean View Resort · All rights reserved
        </div>
    </footer>

</div>

<!-- Toast root (kept) -->
<div id="toast-root"></div>

<!-- Your local Bootstrap JS (kept) -->
<script src="assets/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>

<!-- Your toast JS (kept) -->
<script src="assets/toast.js"></script>

<script>
  // Enable tooltips
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    new bootstrap.Tooltip(el);
  });
</script>

</body>
</html>