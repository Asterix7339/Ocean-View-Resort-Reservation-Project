function showToast(type, msg) {
    const root = document.getElementById("toast-root");
    if (!root) return;

    const div = document.createElement("div");

    // Assign our new unique classes based on the type
    const styleClass = (type === "success") ? "success-style" : "error-style";

    // We use 'ov-toast' to avoid Bootstrap's default '.toast' behavior
    div.className = "ov-toast " + styleClass;
    div.innerText = msg;

    root.appendChild(div);

    // Auto-remove after 4 seconds
    setTimeout(() => {
        div.style.opacity = "0";
        setTimeout(() => div.remove(), 300);
    }, 4000);
}

function checkToastFromURL() {
    const params = new URLSearchParams(window.location.search);
    const success = params.get("success");
    const error = params.get("error");

    if (success) showToast("success", success);
    if (error) showToast("error", error);

    // Clean the URL so the toast doesn't reappear on refresh
    if (success || error) {
        window.history.replaceState({}, document.title, window.location.pathname);
    }
}

document.addEventListener("DOMContentLoaded", checkToastFromURL);