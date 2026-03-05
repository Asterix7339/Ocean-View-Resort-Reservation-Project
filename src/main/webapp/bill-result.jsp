<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
    double rate = (double) request.getAttribute("rate");
    long nights = (long) request.getAttribute("nights");
    double total = (double) request.getAttribute("total");
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bill</title>

    <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/app.css">
    <link rel="stylesheet" href="assets/toast.css"> <!-- only if needed -->

    <!-- Invoice / enterprise theme -->

</head>

<body>

<!-- Navbar for screen only (hidden on print) -->
<div class="no-print">
    <jsp:include page="includes/navbar.jsp" />
</div>

<div class="container-fluid px-3 px-lg-4 page-wrap">
    <div class="row justify-content-center">
        <div class="col-12 col-lg-10 col-xl-8">

            <!-- Header actions (screen only) -->
            <div class="no-print d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
                <div>
                    <h1 class="h4 mb-1 fw-semibold">Bill / Invoice</h1>
                    <p class="text-secondary mb-0 small">Print-ready bill for guest payment.</p>
                </div>

                <div class="d-flex gap-2 flex-wrap">
                    <a class="btn btn-sm btn-outline-secondary"
                       href="reservation?action=view&reservationNumber=<%= r.getReservationNumber() %>">
                        ← Back to Reservation
                    </a>
                    <button class="btn btn-sm btn-primary" onclick="window.print()">
                        Print Bill
                    </button>
                </div>
            </div>

            <!-- Invoice Card -->
            <div class="invoice-card p-3 p-lg-4">

                <!-- Invoice top header -->
                <div class="d-flex flex-column flex-md-row align-items-md-start justify-content-between gap-3 mb-4">
                    <div class="d-flex align-items-center gap-3">
                        <div class="brand-mark">OV</div>
                        <div>
                            <div class="h5 mb-1 fw-bold">Ocean View Resort</div>
                            <div class="text-secondary small">Reservation Billing Statement</div>
                        </div>
                    </div>

                    <div class="text-md-end">
                        <div class="text-secondary small">Invoice For</div>
                        <div class="fw-semibold"><%= r.getGuestName() %></div>
                        <div class="text-secondary small mt-1">
                            Reservation #
                            <span class="fw-semibold"><%= r.getReservationNumber() %></span>
                        </div>
                    </div>
                </div>

                <!-- Details grid -->
                <div class="row g-3">
                    <!-- Booking details -->
                    <div class="col-12 col-md-6">
                        <div class="border rounded-4 p-3 h-100">
                            <div class="fw-semibold mb-2">Booking Details</div>

                            <div class="kv">
                                <div class="label">Reservation Number</div>
                                <div class="value"><%= r.getReservationNumber() %></div>
                            </div>

                            <div class="kv">
                                <div class="label">Guest Name</div>
                                <div class="value"><%= r.getGuestName() %></div>
                            </div>

                            <div class="kv">
                                <div class="label">Check-in</div>
                                <div class="value"><%= r.getCheckIn() %></div>
                            </div>

                            <div class="kv">
                                <div class="label">Check-out</div>
                                <div class="value"><%= r.getCheckOut() %></div>
                            </div>
                        </div>
                    </div>

                    <!-- Charges summary -->
                    <div class="col-12 col-md-6">
                        <div class="border rounded-4 p-3 h-100">
                            <div class="fw-semibold mb-2">Charges Summary</div>

                            <div class="table-responsive">
                                <table class="table align-middle mb-0">
                                    <thead class="table-light">
                                    <tr>
                                        <th>Description</th>
                                        <th class="text-end">Amount (LKR)</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                            Room charges
                                            <div class="text-secondary small">
                                                <%= nights %> night(s) × <%= rate %>
                                            </div>
                                        </td>
                                        <td class="text-end fw-semibold"><%= total %></td>
                                    </tr>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th class="text-end">Total</th>
                                        <th class="text-end">
                                            <span class="badge text-bg-success-subtle text-success border rounded-pill px-3 py-2">
                                                <%= total %> LKR
                                            </span>
                                        </th>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <div class="text-secondary small mt-2">
                                Rate and total are calculated by the system.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer note -->
                <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mt-4 pt-3 border-top">
                    <div class="text-secondary small">
                        Thank you for choosing Ocean View Resort.
                    </div>
                    <div class="text-secondary small">
                        Generated on: <%= java.time.LocalDate.now() %>
                    </div>
                </div>

            </div>

            <!-- Bottom print button (mobile friendly, screen only) -->
            <div class="no-print d-grid d-md-none mt-3">
                <button class="btn btn-primary" onclick="window.print()">Print Bill</button>
            </div>

            <div class="text-center text-secondary small mt-3 no-print">
                © <%= java.time.Year.now() %> Ocean View Resort · Billing
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>