<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Must be logged in
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Must be ADMIN
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
    <title>Register Receptionist</title>

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
            <h1 class="h3 mb-1 fw-semibold">Register Staff Account</h1>
            <p class="text-secondary mb-0">Admin only — create staff login credentials securely.</p>
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
                        <!-- person-badge icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                             class="bi bi-person-badge text-primary" viewBox="0 0 16 16">
                            <path d="M6.5 2a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1z"/>
                            <path d="M11 8a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path d="M4.5 9.5A3.5 3.5 0 0 0 8 13a3.5 3.5 0 0 0 3.5-3.5v-.128a.5.5 0 0 0-.146-.354l-.353-.353a.5.5 0 0 0-.354-.146H5.353a.5.5 0 0 0-.354.146l-.353.353a.5.5 0 0 0-.146.354z"/>
                            <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2z"/>
                        </svg>
                    </div>

                    <div>
                        <div class="fw-semibold">Create New Staff User</div>
                        <div class="text-secondary small">
                            Choose the correct role. Receptionist handles reservations; Admin has full access.
                        </div>
                    </div>
                </div>

                <!-- IMPORTANT: backend unchanged -->
                <form method="post" action="register-receptionist" class="needs-validation" novalidate>

                    <div class="row g-3">

                        <!-- Username -->
                        <div class="col-12">
                            <label class="form-label fw-semibold">Username</label>
                            <input type="text" name="username" class="form-control"
                                   placeholder="e.g., receptionist01" required />
                            <div class="invalid-feedback">Username is required.</div>
                        </div>

                        <!-- Password -->
                        <div class="col-12">
                            <label class="form-label fw-semibold">Password</label>
                            <input type="password" name="password" class="form-control"
                                   placeholder="Enter a strong password" required />
                            <div class="invalid-feedback">Password is required.</div>

                            <div class="form-text text-secondary">
                                Tip: Use a mix of letters and numbers to improve security.
                            </div>
                        </div>

                        <!-- Role -->
                        <div class="col-12">
                            <label class="form-label fw-semibold">Role</label>
                            <select name="role" class="form-select" required>
                                <option value="">-- Select Role --</option>
                                <option value="RECEPTIONIST">RECEPTIONIST</option>
                                <option value="ADMIN">ADMIN</option>
                            </select>
                            <div class="invalid-feedback">Please select a role.</div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <div class="d-flex flex-column flex-sm-row gap-2 justify-content-end">
                        <a class="btn btn-light" href="admin.jsp">Cancel</a>
                        <button type="submit" class="btn btn-primary">
                            Create Receptionist
                        </button>
                    </div>
                </form>

            </div>

            <div class="text-center text-secondary small mt-3">
                Only admins can create staff accounts.
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