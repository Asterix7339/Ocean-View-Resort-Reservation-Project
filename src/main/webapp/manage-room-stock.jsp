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
    <title>Manage Room Stock</title>

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
            <h1 class="h3 mb-1 fw-semibold">Manage Room Stock</h1>
            <p class="text-secondary mb-0">Admin only — update total rooms for each room type.</p>
        </div>

        <a class="btn btn-sm btn-outline-secondary" href="admin.jsp">
            ← Back to Admin Panel
        </a>
    </div>

    <div class="row g-3 justify-content-center">
        <div class="col-12 col-lg-9 col-xl-7">

            <!-- Form Card -->
            <div class="surface-card p-3 p-lg-4">

                <div class="d-flex align-items-start gap-3 mb-3">
                    <div class="icon-pill">
                        <!-- boxes icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                             class="bi bi-box-seam text-primary" viewBox="0 0 16 16">
                            <path d="M9.828.722a.5.5 0 0 0-.656-.293l-7 3A.5.5 0 0 0 2 3.89V12.11a.5.5 0 0 0 .172.38l7 3a.5.5 0 0 0 .656-.293l3-7a.5.5 0 0 0 0-.394zM8 1.5 2.8 3.7 8 5.9l5.2-2.2zM2.5 4.5 7.5 6.64v8.35l-5-2.14zM8.5 14.99V6.64l5-2.14v8.35z"/>
                        </svg>
                    </div>

                    <div>
                        <div class="fw-semibold">Update Room Inventory</div>
                        <div class="text-secondary small">
                            Select a room type and set the total rooms available in the property.
                        </div>
                    </div>
                </div>

                <!-- IMPORTANT: backend unchanged -->
                <form method="post" action="update-room-stock" class="needs-validation" novalidate>

                    <div class="row g-3">

                        <!-- Room Type -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Room Type</label>
                            <select name="roomTypeId" class="form-select" required>
                                <option value="">-- Select --</option>
                                <option value="1">STANDARD</option>
                                <option value="2">DELUXE</option>
                                <option value="3">SUITE</option>
                            </select>
                            <div class="invalid-feedback">Please select a room type.</div>
                        </div>

                        <!-- Total Rooms -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Total Rooms</label>
                            <input type="number" name="totalRooms" min="0" class="form-control"
                                   placeholder="e.g., 25" required />
                            <div class="invalid-feedback">Please enter a valid number (0 or above).</div>
                            <div class="form-text text-secondary">
                                Use <span class="fw-semibold">0</span> if a room type is temporarily unavailable.
                            </div>
                        </div>

                    </div>

                    <hr class="my-4">

                    <div class="d-flex flex-column flex-sm-row gap-2 justify-content-end">
                        <a class="btn btn-light" href="admin.jsp">Cancel</a>
                        <button type="submit" class="btn btn-primary">
                            Update
                        </button>
                    </div>

                </form>

            </div>

            <div class="text-center text-secondary small mt-3">
                Changes apply to availability calculations on the dashboard and reports.
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap validation (UI-only) -->
<script>
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

</body>
</html>