<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Help</title>

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
            <h1 class="h3 mb-1 fw-semibold">Help</h1>
            <p class="text-secondary mb-0">Ocean View Reservation System — quick guidance for staff operations.</p>
        </div>

        <a class="btn btn-sm btn-outline-secondary" href="dashboard.jsp">
            ← Back to Dashboard
        </a>
    </div>

    <div class="row g-3 justify-content-center">
        <div class="col-12 col-lg-10 col-xl-8">

            <!-- Quick Tips -->
            <div class="surface-card p-3 p-lg-4 mb-3">
                <div class="d-flex align-items-start gap-3">
                    <div class="icon-pill">
                        <!-- info icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor"
                             class="bi bi-info-circle text-primary" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                            <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
                        </svg>
                    </div>

                    <div>
                        <div class="fw-semibold">Quick Tips</div>
                        <ul class="text-secondary mb-0 mt-2">
                            <li>Use the navbar search to quickly locate a reservation.</li>
                            <li>Double-check dates before saving or billing.</li>
                            <li>Always logout after finishing your shift.</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Help Content (Accordion for clean enterprise UX) -->
            <div class="surface-card overflow-hidden">
                <div class="p-3 p-lg-4 border-bottom">
                    <div class="fw-semibold">Guides</div>
                    <div class="text-secondary small">Expand each section for details.</div>
                </div>

                <div class="p-3 p-lg-4">
                    <div class="accordion" id="helpAccordion">

                        <!-- 1) Login -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="h-login">
                                <button class="accordion-button" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#c-login"
                                        aria-expanded="true" aria-controls="c-login">
                                    1) Login
                                </button>
                            </h2>
                            <div id="c-login" class="accordion-collapse collapse show"
                                 aria-labelledby="h-login" data-bs-parent="#helpAccordion">
                                <div class="accordion-body text-secondary">
                                    Use your staff username and password to access the system.
                                </div>
                            </div>
                        </div>

                        <!-- 2) Add New Reservation -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="h-add">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#c-add"
                                        aria-expanded="false" aria-controls="c-add">
                                    2) Add New Reservation
                                </button>
                            </h2>
                            <div id="c-add" class="accordion-collapse collapse"
                                 aria-labelledby="h-add" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    <ul class="text-secondary mb-0">
                                        <li>Enter a unique reservation number.</li>
                                        <li>Fill guest details and select room type.</li>
                                        <li>Check-out date must be after check-in date.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- 3) Search Reservation -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="h-search">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#c-search"
                                        aria-expanded="false" aria-controls="c-search">
                                    3) Search Reservation
                                </button>
                            </h2>
                            <div id="c-search" class="accordion-collapse collapse"
                                 aria-labelledby="h-search" data-bs-parent="#helpAccordion">
                                <div class="accordion-body text-secondary">
                                    Use the reservation number to view full reservation details.
                                </div>
                            </div>
                        </div>

                        <!-- 4) Calculate & Print Bill -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="h-bill">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#c-bill"
                                        aria-expanded="false" aria-controls="c-bill">
                                    4) Calculate & Print Bill
                                </button>
                            </h2>
                            <div id="c-bill" class="accordion-collapse collapse"
                                 aria-labelledby="h-bill" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    <ul class="text-secondary mb-0">
                                        <li>Enter reservation number.</li>
                                        <li>System calculates nights and total amount using room rate.</li>
                                        <li>Click “Print Bill” to print.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- 5) Logout -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="h-logout">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#c-logout"
                                        aria-expanded="false" aria-controls="c-logout">
                                    5) Logout
                                </button>
                            </h2>
                            <div id="c-logout" class="accordion-collapse collapse"
                                 aria-labelledby="h-logout" data-bs-parent="#helpAccordion">
                                <div class="accordion-body text-secondary">
                                    Always logout after work to keep the system secure.
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Support Note -->
            <div class="text-center text-secondary small mt-3">
                If you face issues, contact your system administrator.
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

</body>
</html>