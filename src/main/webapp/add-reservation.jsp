<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Must be logged in
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
    <title>Add Reservation</title>

    <!-- Bootstrap 5.3+ (CDN). Replace with local if needed -->
    <link rel="stylesheet" href="assets/app.css">
    <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/toast.css">
    <!-- Minimal enterprise theme (matches previous pages) -->
    </head>

<body>

<jsp:include page="includes/navbar.jsp" />

<div class="container-fluid px-3 px-lg-4 page-wrap">

    <!-- Page header -->
    <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-2 mb-4">
        <div>
            <h1 class="h3 mb-1 fw-semibold">Add New Reservation</h1>
            <p class="text-secondary mb-0">Enter guest details and booking dates to create a reservation.</p>
        </div>

        <a class="btn btn-sm btn-outline-secondary" href="dashboard.jsp">
            ← Back to Dashboard
        </a>
    </div>

    <div class="row g-3 justify-content-center">
        <div class="col-12 col-lg-10 col-xl-8">

            <!-- Form Card -->
            <div class="surface-card p-3 p-lg-4">

                <!-- Helpful alert / info -->
                <div class="alert alert-info border-0 rounded-3 d-flex align-items-start gap-2 mb-4">
                    <div class="fw-semibold">Tip:</div>
                    <div class="text-secondary">
                        Ensure dates are correct. Check-out must be after check-in.
                    </div>
                </div>

                <!-- Form (backend unchanged) -->
                <form method="post" action="add-reservation" class="needs-validation" novalidate>

                    <div class="row g-3">

                        <!-- Reservation Number -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Reservation Number</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">#</span>
                                <input type="text" name="reservationNumber" class="form-control"
                                       placeholder="e.g., RES-10021" required />
                                <div class="invalid-feedback">Reservation number is required.</div>
                            </div>
                        </div>

                        <!-- Contact Number -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Contact Number</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">
                                    <!-- Phone icon (inline SVG) -->
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-telephone text-secondary" viewBox="0 0 16 16">
                                        <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.6 17.6 0 0 0 4.168 6.608 17.6 17.6 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.68.68 0 0 0-.58-.122l-2.19.547a1.75 1.75 0 0 1-1.657-.459L5.482 8.062a1.75 1.75 0 0 1-.46-1.657l.548-2.19a.68.68 0 0 0-.122-.58z"/>
                                    </svg>
                                </span>
                                <input type="text" name="contactNumber" class="form-control"
                                       placeholder="e.g., 0771234567" required />
                                <div class="invalid-feedback">Contact number is required.</div>
                            </div>
                        </div>

                        <!-- Guest Name -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Guest Name</label>
                            <input type="text" name="guestName" class="form-control"
                                   placeholder="Full name" required />
                            <div class="invalid-feedback">Guest name is required.</div>
                        </div>

                        <!-- Address -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Address</label>
                            <input type="text" name="address" class="form-control"
                                   placeholder="Street, City" required />
                            <div class="invalid-feedback">Address is required.</div>
                        </div>

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

                        <!-- Check-in -->
                        <div class="col-12 col-md-3">
                            <label class="form-label fw-semibold">Check-in Date</label>
                            <input type="date" name="checkIn" class="form-control" required />
                            <div class="invalid-feedback">Check-in date is required.</div>
                        </div>

                        <!-- Check-out -->
                        <div class="col-12 col-md-3">
                            <label class="form-label fw-semibold">Check-out Date</label>
                            <input type="date" name="checkOut" class="form-control" required />
                            <div class="invalid-feedback">Check-out date is required.</div>
                        </div>

                    </div>

                    <hr class="my-4">

                    <!-- Actions -->
                    <div class="d-flex flex-column flex-sm-row gap-2 justify-content-end">
                        <a class="btn btn-light" href="dashboard.jsp">Cancel</a>
                        <button type="submit" class="btn btn-primary">
                            Save Reservation
                        </button>
                    </div>
                </form>

            </div>

            <!-- Footer mini -->
            <div class="text-center text-secondary small mt-3">
                Make sure all details are correct before saving.
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap validation (UI only, backend unchanged) -->
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