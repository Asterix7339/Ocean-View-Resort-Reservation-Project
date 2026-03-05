<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Edit Reservation</title>

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
            <h1 class="h3 mb-1 fw-semibold">Edit Reservation</h1>
            <p class="text-secondary mb-0">
                Update reservation #
                <span class="fw-semibold"><%= r.getReservationNumber() %></span>
            </p>
        </div>

        <a class="btn btn-sm btn-outline-secondary" href="all-reservations">
            ← Back to All Reservations
        </a>
    </div>

    <div class="row g-3 justify-content-center">
        <div class="col-12 col-lg-10 col-xl-8">

            <!-- Form Card -->
            <div class="surface-card p-3 p-lg-4">

                <div class="alert alert-info border-0 rounded-3 mb-4">
                    Tip: Check-out must be after check-in. Verify contact details before saving.
                </div>

                <!-- Backend unchanged -->
                <form method="post" action="reservation" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="update" />

                    <div class="row g-3">

                        <!-- Reservation Number (readonly) -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Reservation Number</label>
                            <input type="text" name="reservationNumber" class="form-control"
                                   value="<%= r.getReservationNumber() %>" readonly />
                            <div class="readonly-hint mt-1">This field cannot be changed.</div>
                        </div>

                        <!-- Contact Number -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Contact Number</label>
                            <input type="text" name="contactNumber" class="form-control"
                                   value="<%= r.getContactNumber() %>" required />
                            <div class="invalid-feedback">Contact number is required.</div>
                        </div>

                        <!-- Guest Name -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Guest Name</label>
                            <input type="text" name="guestName" class="form-control"
                                   value="<%= r.getGuestName() %>" required />
                            <div class="invalid-feedback">Guest name is required.</div>
                        </div>

                        <!-- Address -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Address</label>
                            <input type="text" name="address" class="form-control"
                                   value="<%= r.getAddress() %>" required />
                            <div class="invalid-feedback">Address is required.</div>
                        </div>

                        <!-- Room Type -->
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold">Room Type</label>
                            <select name="roomTypeId" class="form-select" required>
                                <option value="1" <%= (r.getRoomTypeId()==1 ? "selected" : "") %>>STANDARD</option>
                                <option value="2" <%= (r.getRoomTypeId()==2 ? "selected" : "") %>>DELUXE</option>
                                <option value="3" <%= (r.getRoomTypeId()==3 ? "selected" : "") %>>SUITE</option>
                            </select>
                            <div class="invalid-feedback">Please select a room type.</div>
                        </div>

                        <!-- Check-in -->
                        <div class="col-12 col-md-3">
                            <label class="form-label fw-semibold">Check-in Date</label>
                            <input type="date" name="checkIn" class="form-control"
                                   value="<%= r.getCheckIn() %>" required />
                            <div class="invalid-feedback">Check-in date is required.</div>
                        </div>

                        <!-- Check-out -->
                        <div class="col-12 col-md-3">
                            <label class="form-label fw-semibold">Check-out Date</label>
                            <input type="date" name="checkOut" class="form-control"
                                   value="<%= r.getCheckOut() %>" required />
                            <div class="invalid-feedback">Check-out date is required.</div>
                        </div>

                    </div>

                    <hr class="my-4">

                    <!-- Actions -->
                    <div class="d-flex flex-column flex-sm-row gap-2 justify-content-end">
                        <a class="btn btn-light" href="all-reservations">Cancel</a>
                        <button type="submit" class="btn btn-primary">
                            Update Reservation
                        </button>
                    </div>

                </form>
            </div>

            <div class="text-center text-secondary small mt-3">
                Changes will be applied immediately after update.
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

<!-- Bootstrap validation (UI only) -->
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