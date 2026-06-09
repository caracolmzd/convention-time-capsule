const DOMAINS = [
  "Technical systems and integrations",
  "Logistical operations",
  "Attendee satisfaction",
  "Vendor collaboration",
  "Staff morale",
  "Health and safety",
];

const state = { config: null, user: null };

async function loadConfig() {
  const res = await fetch("config.json");
  if (!res.ok) throw new Error("Missing site/config.json — copy from config.example.json");
  state.config = await res.json();
}

function setStatus(el, message, variant = "info") {
  if (!el) return;
  el.textContent = message;
  el.className = `status-banner status-banner--${variant}`;
  el.hidden = !message;
}

function populateDomainSelect(select) {
  if (!select) return;
  select.innerHTML = '<option value="">Select a domain…</option>';
  for (const d of DOMAINS) {
    const opt = document.createElement("option");
    opt.value = d;
    opt.textContent = d;
    select.appendChild(opt);
  }
}

function renderPriorList(listEl, items) {
  if (!listEl) return;
  listEl.innerHTML = "";
  if (!items || items.length === 0) {
    const li = document.createElement("li");
    li.textContent = "No prior submissions for this domain yet.";
    listEl.appendChild(li);
    return;
  }
  for (const item of items) {
    const li = document.createElement("li");
    li.innerHTML = `<span class="domain">${item.domain}</span><br>${item.body}`;
    listEl.appendChild(li);
  }
}

function initSubmitPage() {
  const form = document.getElementById("submit-form");
  const domainSelect = document.getElementById("domain");
  const priorList = document.getElementById("prior-list");
  const signInBtn = document.getElementById("sign-in");
  const statusEl = document.getElementById("status");
  const userEl = document.getElementById("user-info");

  populateDomainSelect(domainSelect);
  renderPriorList(priorList, []);

  signInBtn?.addEventListener("click", () => {
    setStatus(statusEl, "Google sign-in will be wired in M-006 (Web OAuth + WASM).", "info");
    state.user = { email: "pending@example.com" };
    if (userEl) userEl.textContent = "Signed in: (placeholder)";
    form?.querySelectorAll("input, select, textarea, button[type=submit]").forEach((el) => {
      if (el.id !== "sign-in") el.disabled = false;
    });
  });

  domainSelect?.addEventListener("change", () => {
    renderPriorList(priorList, []);
    setStatus(statusEl, "Prior submissions load when backend is connected (M-006).", "info");
  });

  form?.addEventListener("submit", (e) => {
    e.preventDefault();
    setStatus(statusEl, "Submit will write to Google Sheets in M-006.", "warn");
  });
}

function initClassifyPage() {
  setStatus(document.getElementById("status"), "Team-lead classification ships in M-007.", "info");
}

async function init() {
  const page = document.body.dataset.page;
  try { await loadConfig(); } catch (err) {
    setStatus(document.getElementById("status"), err.message, "warn");
  }
  if (page === "submit") initSubmitPage();
  if (page === "classify") initClassifyPage();
}

document.addEventListener("DOMContentLoaded", init);
