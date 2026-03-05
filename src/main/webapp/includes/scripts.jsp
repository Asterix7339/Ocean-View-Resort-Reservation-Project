<%@ page contentType="text/html;charset=UTF-8" %>
<% String cp = request.getContextPath(); %>

<div id="toast-root"></div>

<script src="<%= cp %>assets/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/toast.js"></script>

<script>
  // Re-initialize tooltips
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    new bootstrap.Tooltip(el);
  });
</script>