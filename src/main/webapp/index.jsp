<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Ocean View Reservation</title>

    <!-- Bootstrap first -->
    <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Your shared theme -->
    <link rel="stylesheet" href="assets/app.css">
</head>

<body class="auth-bg">

<!-- Top bar (simple, clean) -->
<nav class="navbar navbar-expand-lg app-navbar">
    <div class="container-fluid px-3 px-lg-4 py-2">
        <a class="navbar-brand d-flex align-items-center gap-2 fw-semibold" href="index.jsp">
            <span class="brand-mark">OV</span>
            <span class="d-flex flex-column lh-sm">
                <span>Ocean View Resort</span>
                <small class="text-secondary fw-normal d-none d-sm-block">Reservation System</small>
            </span>
        </a>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-outline-secondary" href="help.jsp">Help</a>
            <a class="btn btn-sm btn-primary" href="login.jsp">Staff Login</a>
        </div>
    </div>
</nav>

<div class="container-fluid px-3 px-lg-4 py-5">

    <!-- HERO -->
    <div class="row align-items-center g-4">
        <div class="col-12 col-lg-7">
            <div class="mb-3">
                <span class="badge text-bg-primary-subtle text-primary border rounded-pill px-3 py-2">
                    Ocean View Reservation System
                </span>
            </div>

            <h1 class="display-6 fw-semibold mb-3">
                Manage reservations, availability, and daily operations — fast and reliably.
            </h1>

            <p class="text-secondary fs-5 mb-4">
                A clean staff portal for reception and administration. Search reservations, create bookings,
                track today’s check-ins, and generate billing with a consistent enterprise UI.
            </p>

            <div class="d-flex flex-column flex-sm-row gap-2">
                <a class="btn btn-primary btn-lg" href="login.jsp">
                    Go to Staff Login
                </a>
                <a class="btn btn-outline-secondary btn-lg" href="help.jsp">
                    View Help Guide
                </a>
            </div>

            <div class="text-secondary small mt-3">
                Status: <span class="badge text-bg-success-subtle text-success border rounded-pill">Web app is running</span>
            </div>
        </div>

        <!-- Right-side card -->
        <div class="col-12 col-lg-5">
            <div class="surface-card p-3 p-lg-4">
                <div class="d-flex align-items-start justify-content-between gap-2 mb-3">
                    <div>
                        <div class="fw-semibold">Quick Access</div>
                        <div class="text-secondary small">Start working in one click.</div>
                    </div>
                    <span class="badge text-bg-light border rounded-pill">Staff Portal</span>
                </div>

                <div class="d-grid gap-2">
                    <a href="login.jsp" class="btn btn-primary">
                        Staff Login
                    </a>
                    <a href="help.jsp" class="btn btn-outline-secondary">
                        Help & Instructions
                    </a>
                </div>

                <hr class="my-4">

                <div class="text-secondary small">
                    Tip: Always logout after your shift to keep accounts secure.
                </div>
            </div>
        </div>
    </div>

    <!-- FEATURES -->
    <div class="row g-3 mt-5">
        <div class="col-12 col-md-6 col-xl-3">
            <div class="surface-card p-3 h-100">
                <div class="icon-pill mb-3">
                    <!-- calendar icon -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                         class="bi bi-calendar2-check text-primary" viewBox="0 0 16 16">
                        <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h.5A1.5 1.5 0 0 1 15 2.5v11A1.5 1.5 0 0 1 13.5 15h-11A1.5 1.5 0 0 1 1 13.5v-11A1.5 1.5 0 0 1 2.5 1H3V.5a.5.5 0 0 1 .5-.5M2 4h12v9.5a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5z"/>
                        <path d="M10.854 8.146a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708 0l-1-1a.5.5 0 1 1 .708-.708l.646.647 1.646-1.647a.5.5 0 0 1 .708 0"/>
                    </svg>
                </div>
                <div class="fw-semibold">Reservations</div>
                <div class="text-secondary small mt-1">
                    Create, view, edit, and manage guest reservations quickly.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <div class="surface-card p-3 h-100">
                <div class="icon-pill mb-3">
                    <!-- search icon -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                         class="bi bi-search text-primary" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                    </svg>
                </div>
                <div class="fw-semibold">Fast Search</div>
                <div class="text-secondary small mt-1">
                    Find reservations instantly by number, guest name, or contact.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <div class="surface-card p-3 h-100">
                <div class="icon-pill mb-3">
                    <!-- building icon -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                         class="bi bi-building text-primary" viewBox="0 0 16 16">
                        <path d="M4 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5V14h1a.5.5 0 0 1 0 1H3a.5.5 0 0 1 0-1h1zM5 3v11h6V3z"/>
                        <path d="M6.5 4.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                </div>
                <div class="fw-semibold">Availability</div>
                <div class="text-secondary small mt-1">
                    View room availability summaries for today at a glance.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <div class="surface-card p-3 h-100">
                <div class="icon-pill mb-3">
                    <!-- receipt icon -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                         class="bi bi-receipt text-primary" viewBox="0 0 16 16">
                        <path d="M1.92.506A.5.5 0 0 1 2.5 0h11a.5.5 0 0 1 .58.506l-1 14a.5.5 0 0 1-.58.494H3.5a.5.5 0 0 1-.58-.494zM3 2h10l.8 11.2H2.2z"/>
                        <path d="M4 4.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 4.5M4 7a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 7m0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5"/>
                    </svg>
                </div>
                <div class="fw-semibold">Billing</div>
                <div class="text-secondary small mt-1">
                    Generate bills, review totals, and print invoices in one click.
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center text-secondary small mt-5">
        <div class="py-3">
            © <%= java.time.Year.now() %> Ocean View Resort · Reservation System
        </div>
    </footer>

</div>

<script src="assets/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>