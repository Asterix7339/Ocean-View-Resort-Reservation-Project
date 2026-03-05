<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - Ocean View Resort</title>

    <link href="assets/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/app.css">
    <link rel="stylesheet" href="assets/toast.css"> <!-- only if needed -->
</head>

<body>

<div class="auth-wrap">
    <div class="container-fluid px-3 px-lg-4">
        <div class="row justify-content-center">
            <!-- Medium range width -->
            <div class="col-12 col-md-10 col-lg-8 col-xl-6">

                <div class="surface-card overflow-hidden">
                    <div class="row g-0">

                        <!-- Left / Info panel (visible on md+) -->
                        <div class="col-md-5 d-none d-md-block">
                            <div class="h-100 p-4 p-lg-5 text-white"
                                 style="background: linear-gradient(135deg, #0d6efd, #20c997);">
                                <div class="d-flex align-items-center gap-2 mb-4">
                                    <div class="brand-mark bg-white text-primary" style="box-shadow:none;">
                                        OV
                                    </div>
                                    <div>
                                        <div class="fw-bold">Ocean View Resort</div>
                                        <div class="small opacity-75">Staff Portal</div>
                                    </div>
                                </div>

                                <h3 class="h5 fw-semibold">Welcome back</h3>
                                <p class="opacity-75 mb-4">
                                    Sign in to manage reservations, room availability, and daily operations.
                                </p>

                                <div class="bg-white bg-opacity-10 border border-white border-opacity-25 rounded-4 p-3">
                                    <div class="small fw-semibold mb-1">Security Tip</div>
                                    <div class="small opacity-75">
                                        Always logout after your shift to keep the system secure.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right / Form panel -->
                        <div class="col-12 col-md-7">
                            <div class="p-4 p-lg-5">

                                <!-- Mobile brand header -->
                                <div class="d-flex d-md-none align-items-center gap-2 mb-3">
                                    <div class="brand-mark">OV</div>
                                    <div class="lh-sm">
                                        <div class="fw-bold">Ocean View Resort</div>
                                        <div class="text-secondary small">Staff Login</div>
                                    </div>
                                </div>

                                <h1 class="h4 fw-semibold mb-1">Staff Login</h1>
                                <p class="text-secondary mb-4">
                                    Enter your username and password to continue.
                                </p>

                                <!-- Form (backend unchanged) -->
                                <form method="post" action="login" class="needs-validation" novalidate>

                                    <!-- Username -->
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Username</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white">
                                                <!-- person icon -->
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                     fill="currentColor" class="bi bi-person text-secondary" viewBox="0 0 16 16">
                                                    <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                                                    <path d="M14 14s-1 0-1-1 1-4-5-4-5 3-5 4 1 1 1 1z"/>
                                                </svg>
                                            </span>
                                            <input type="text" name="username" class="form-control"
                                                   placeholder="e.g., receptionist01" required />
                                            <div class="invalid-feedback">Username is required.</div>
                                        </div>
                                    </div>

                                    <!-- Password -->
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white">
                                                <!-- lock icon -->
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                     fill="currentColor" class="bi bi-lock text-secondary" viewBox="0 0 16 16">
                                                    <path d="M8 1a2 2 0 0 0-2 2v4H5a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-1V3a2 2 0 0 0-2-2m1 6V3a1 1 0 0 0-2 0v4z"/>
                                                </svg>
                                            </span>
                                            <input type="password" name="password" class="form-control"
                                                   placeholder="Enter your password" required />
                                            <div class="invalid-feedback">Password is required.</div>
                                        </div>
                                    </div>

                                    <!-- Remember (UI only, no backend change; you can remove if you don't want) -->
                                    <div class="d-flex align-items-center justify-content-between mb-4">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                                            <label class="form-check-label text-secondary" for="rememberMe">
                                                Remember me (browser)
                                            </label>
                                        </div>

                                        <span class="text-secondary small">
                                            Need help? <a class="helper-link" href="help.jsp">Help</a>
                                        </span>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            Login
                                        </button>

                                        <a href="index.jsp" class="btn btn-outline-secondary">
                                            ← Back to Home
                                        </a>
                                    </div>
                                </form>

                                <hr class="my-4">

                                <div class="text-center text-secondary small">
                                    © <%= java.time.Year.now() %> Ocean View Resort · Staff Portal
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

                <!-- Toast root (kept) -->
                <div id="toast-root"></div>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Your toast JS (kept) -->
<script src="assets/toast.js"></script>

<!-- Bootstrap validation (UI-only, backend unchanged) -->
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