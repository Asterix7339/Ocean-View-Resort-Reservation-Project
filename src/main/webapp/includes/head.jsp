<%@ page contentType="text/html;charset=UTF-8" %>
<% String cp = request.getContextPath(); %>

<style>
  :root {
    --app-bg:#f6f8fb; --app-surface:#fff; --app-border:rgba(15,23,42,.08);
  }
  body { background:var(--app-bg); }
  .app-navbar { background:var(--app-surface); border-bottom:1px solid var(--app-border); }
  .brand-mark { width:36px; height:36px; display:inline-grid; place-items:center; border-radius:12px;
    background:linear-gradient(135deg,#0d6efd,#20c997); color:#fff; font-weight:700; }
  /* ... keep your other styles ... */
</style>