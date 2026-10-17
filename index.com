<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#090d1d">
<title>Local AI Bot Studio</title>

<style>
:root {
  --bg:#090d1d;
  --surface:#11172b;
  --card:#151d35;
  --card2:#1c2744;
  --border:#293656;
  --text:#f2f5ff;
  --muted:#929fbd;
  --purple:#9167ff;
  --blue:#37c9ff;
  --green:#55e6a5;
  --orange:#ffbd69;
  --red:#ff7285;
  --radius:20px;
}

* {
  box-sizing:border-box;
  -webkit-tap-highlight-color:transparent;
}

html {
  scroll-behavior:smooth;
}

body {
  margin:0;
  background:var(--bg);
  color:var(--text);
  font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;
}

button,input,textarea,select {
  font:inherit;
}

button {
  cursor:pointer;
}

button:focus-visible,
input:focus-visible,
textarea:focus-visible,
select:focus-visible {
  outline:2px solid var(--blue);
  outline-offset:2px;
}

button:disabled {
  opacity:.5;
  cursor:not-allowed;
}

#app {
  min-height:100dvh;
  padding-bottom:90px;
  background:
    radial-gradient(ellipse at 0% 0%,rgba(145,103,255,.15),transparent 42%),
    radial-gradient(ellipse at 100% 20%,rgba(55,201,255,.08),transparent 38%),
    var(--bg);
}

.topbar {
  position:sticky;
  top:0;
  z-index:20;
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  padding:14px 16px;
  background:rgba(9,13,29,.94);
  border-bottom:1px solid rgba(41,54,86,.8);
  backdrop-filter:blur(18px);
}

.brand {
  display:flex;
  align-items:center;
  gap:11px;
  min-width:0;
}

.brand-icon {
  width:44px;
  height:44px;
  flex-shrink:0;
  display:grid;
  place-items:center;
  border-radius:15px;
  background:linear-gradient(135deg,var(--purple),var(--blue));
  box-shadow:0 5px 24px rgba(145,103,255,.25);
  font-size:24px;
}

.brand h1 {
  margin:0;
  font-size:16px;
  letter-spacing:-.4px;
}

.brand p {
  margin:3px 0 0;
  color:var(--muted);
  font-size:11px;
}

.top-actions {
  display:flex;
  align-items:center;
  gap:8px;
}

.icon-btn {
  min-width:42px;
  min-height:42px;
  display:grid;
  place-items:center;
  border:1px solid var(--border);
  border-radius:14px;
  background:var(--surface);
  color:var(--text);
  font-size:19px;
}

.status-pill {
  padding:7px 10px;
  border:1px solid rgba(85,230,165,.25);
  border-radius:30px;
  background:rgba(85,230,165,.08);
  color:var(--green);
  font-size:11px;
  white-space:nowrap;
}

#main {
  width:100%;
  max-width:1050px;
  margin:auto;
  padding:18px 16px 28px;
}

.view {
  display:none;
  animation:appear .2s ease;
}

.view.active {
  display:block;
}

@keyframes appear {
  from { opacity:0; transform:translateY(5px); }
  to { opacity:1; transform:translateY(0); }
}

.eyebrow {
  color:var(--blue);
  font-size:11px;
  font-weight:800;
  letter-spacing:1.8px;
  text-transform:uppercase;
}

h2 {
  margin:7px 0 10px;
  font-size:27px;
  letter-spacing:-1px;
}

h3 {
  margin:0 0 12px;
  font-size:17px;
}

p {
  line-height:1.6;
}

.muted {
  color:var(--muted);
}

.small {
  font-size:12px;
}

.hero {
  position:relative;
  overflow:hidden;
  padding:24px 20px;
  border:1px solid rgba(145,103,255,.3);
  border-radius:26px;
  background:
    radial-gradient(circle at 90% 10%,rgba(55,201,255,.18),transparent 35%),
    linear-gradient(135deg,#201a43,#121b36 65%,#10283c);
}

.hero::after {
  content:"✦";
  position:absolute;
  right:17px;
  top:12px;
  color:rgba(255,255,255,.12);
  font-size:100px;
  pointer-events:none;
}

.hero h2 {
  position:relative;
  z-index:1;
  max-width:520px;
  font-size:30px;
}

.hero p {
  position:relative;
  z-index:1;
  max-width:500px;
  color:#b8c5e6;
  font-size:14px;
}

.gradient-text {
  background:linear-gradient(90deg,#c3aaff,#54d7ff);
  -webkit-background-clip:text;
  background-clip:text;
  color:transparent;
}

.button-row {
  position:relative;
  z-index:1;
  display:flex;
  flex-wrap:wrap;
  gap:9px;
  margin-top:19px;
}

.btn {
  min-height:44px;
  padding:11px 15px;
  border:1px solid var(--border);
  border-radius:13px;
  background:var(--card2);
  color:var(--text);
  font-weight:700;
  font-size:13px;
}

.btn.primary {
  border:0;
  background:linear-gradient(120deg,var(--purple),#5a8dff);
  box-shadow:0 6px 20px rgba(113,93,255,.2);
  color:white;
}

.btn.secondary {
  background:rgba(255,255,255,.05);
}

.btn.danger {
  border-color:rgba(255,114,133,.3);
  background:rgba(255,114,133,.08);
  color:var(--red);
}

.section {
  margin-top:27px;
}

.section-heading {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-bottom:13px;
}

.section-heading h3 {
  margin:0;
}

.text-btn {
  border:0;
  background:none;
  color:var(--blue);
  font-size:12px;
  font-weight:800;
}

.stats-grid {
  display:grid;
  grid-template-columns:repeat(3,minmax(0,1fr));
  gap:10px;
  margin-top:16px;
}

.stat-card {
  min-width:0;
  padding:14px 12px;
  border:1px solid var(--border);
  border-radius:17px;
  background:rgba(17,23,43,.85);
}

.stat-icon {
  font-size:20px;
}

.stat-number {
  display:block;
  margin-top:8px;
  font-size:23px;
  font-weight:850;
}

.stat-label {
  color:var(--muted);
  font-size:11px;
}

.search-box {
  display:flex;
  align-items:center;
  gap:10px;
  padding:0 14px;
  min-height:50px;
  border:1px solid var(--border);
  border-radius:15px;
  background:var(--surface);
}

.search-box span {
  color:var(--muted);
  font-size:20px;
}

.search-box input {
  width:100%;
  min-width:0;
  border:0;
  outline:none;
  background:transparent;
  color:var(--text);
  font-size:14px;
}

.category-grid {
  display:grid;
  grid-template-columns:repeat(2,minmax(0,1fr));
  gap:11px;
}

.category-card {
  position:relative;
  min-width:0;
  min-height:135px;
  overflow:hidden;
  padding:15px;
  text-align:left;
  border:1px solid var(--border);
  border-radius:19px;
  background:linear-gradient(145deg,var(--card),#10172a);
  color:var(--text);
  transition:transform .15s,border-color .15s;
}

.category-card:active {
  transform:scale(.98);
}

.category-card:hover {
  border-color:#6f70c9;
}

.category-icon {
  display:grid;
  place-items:center;
  width:43px;
  height:43px;
  margin-bottom:12px;
  border:1px solid rgba(255,255,255,.08);
  border-radius:14px;
  background:rgba(145,103,255,.13);
  font-size:22px;
}

.category-card strong {
  display:block;
  font-size:13px;
}

.category-card small {
  display:block;
  margin-top:5px;
  color:var(--muted);
  font-size:10px;
  line-height:1.5;
}

.category-arrow {
  position:absolute;
  right:12px;
  top:14px;
  color:var(--muted);
}

.cards-grid {
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
  gap:12px;
}

.card {
  min-width:0;
  padding:17px;
  border:1px solid var(--border);
  border-radius:19px;
  background:linear-gradient(145deg,rgba(21,29,53,.98),rgba(14,21,39,.98));
}

.card-header {
  display:flex;
  align-items:flex-start;
  justify-content:space-between;
  gap:12px;
}

.feature-icon {
  display:grid;
  place-items:center;
  width:45px;
  height:45px;
  flex-shrink:0;
  border-radius:14px;
  background:rgba(55,201,255,.1);
  font-size:22px;
}

.card h4 {
  margin:10px 0 6px;
  font-size:15px;
}

.card p {
  margin:5px 0;
  color:var(--muted);
  font-size:12px;
}

.chip {
  display:inline-flex;
  align-items:center;
  gap:5px;
  padding:5px 8px;
  border:1px solid var(--border);
  border-radius:30px;
  color:var(--muted);
  font-size:10px;
}

.form-grid {
  display:grid;
  grid-template-columns:repeat(2,minmax(0,1fr));
  gap:12px;
}

.field {
  display:flex;
  flex-direction:column;
  gap:7px;
  min-width:0;
}

.field.full {
  grid-column:1/-1;
}

.field label {
  color:#c6cee7;
  font-size:12px;
  font-weight:700;
}

.field input,
.field textarea,
.field select {
  width:100%;
  min-height:45px;
  padding:11px 12px;
  border:1px solid var(--border);
  border-radius:12px;
  background:var(--bg);
  color:var(--text);
}

.field textarea {
  min-height:110px;
  resize:vertical;
}

.field option {
  background:var(--surface);
}

.list {
  display:flex;
  flex-direction:column;
  gap:10px;
}

.list-item {
  display:flex;
  align-items:center;
  gap:12px;
  padding:13px;
  border:1px solid var(--border);
  border-radius:15px;
  background:var(--surface);
}

.list-item .item-content {
  flex:1;
  min-width:0;
}

.list-item strong {
  display:block;
  font-size:13px;
}

.list-item small {
  display:block;
  margin-top:4px;
  color:var(--muted);
  font-size:11px;
}

.list-item .item-action {
  flex-shrink:0;
}

.empty-state {
  padding:28px 15px;
  text-align:center;
  border:1px dashed var(--border);
  border-radius:18px;
  color:var(--muted);
}

.empty-state .empty-icon {
  font-size:34px;
}

.empty-state h3 {
  margin:10px 0 5px;
  color:var(--text);
}

.toolbar {
  display:flex;
  flex-wrap:wrap;
  gap:9px;
  margin:14px 0;
}

.toolbar > * {
  flex:1;
  min-width:120px;
}

.toolbar select {
  padding:10px;
  border:1px solid var(--border);
  border-radius:12px;
  background:var(--surface);
  color:var(--text);
}

.feature-list {
  display:grid;
  grid-template-columns:repeat(2,minmax(0,1fr));
  gap:10px;
}

.feature-button {
  display:flex;
  align-items:center;
  gap:10px;
  min-height:72px;
  padding:12px;
  text-align:left;
  border:1px solid var(--border);
  border-radius:16px;
  background:var(--card);
  color:var(--text);
}

.feature-button .feature-symbol {
  font-size:23px;
}

.feature-button strong {
  display:block;
  font-size:12px;
}

.feature-button small {
  display:block;
  margin-top:4px;
  color:var(--muted);
  font-size:10px;
}

.bottom-nav {
  position:fixed;
  z-index:30;
  bottom:0;
  left:0;
  right:0;
  display:flex;
  justify-content:space-around;
  gap:3px;
  padding:8px 5px calc(8px + env(safe-area-inset-bottom));
  border-top:1px solid var(--border);
  background:rgba(9,13,29,.97);
  backdrop-filter:blur(18px);
}

.nav-btn {
  flex:1;
  min-width:0;
  min-height:54px;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  gap:4px;
  border:0;
  border-radius:13px;
  background:transparent;
  color:var(--muted);
}

.nav-btn span:first-child {
  font-size:20px;
}

.nav-btn span:last-child {
  font-size:9px;
}

.nav-btn.active {
  background:rgba(145,103,255,.15);
  color:#d9ccff;
}

.floating-ai {
  position:fixed;
  z-index:40;
  right:18px;
  bottom:100px;
  width:59px;
  height:59px;
  display:grid;
  place-items:center;
  border:2px solid rgba(255,255,255,.22);
  border-radius:50%;
  background:linear-gradient(135deg,var(--purple),#4b8cff 65%,var(--blue));
  box-shadow:0 8px 28px rgba(83,102,255,.4);
  color:white;
  font-size:25px;
  touch-action:none;
  user-select:none;
}

.floating-ai small {
  position:absolute;
  right:0;
  bottom:-5px;
  padding:3px 5px;
  border:1px solid var(--border);
  border-radius:7px;
  background:var(--surface);
  font-size:8px;
}

.overlay {
  position:fixed;
  z-index:100;
  inset:0;
  display:none;
  flex-direction:column;
  background:var(--bg);
}

.overlay.open {
  display:flex;
}

.overlay-header {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:10px;
  padding:13px 15px;
  border-bottom:1px solid var(--border);
  background:var(--surface);
}

.overlay-header h3 {
  margin:0;
  font-size:15px;
}

.overlay-body {
  flex:1;
  overflow:auto;
  padding:16px;
}

.chat-messages {
  display:flex;
  flex-direction:column;
  gap:12px;
  padding-bottom:15px;
}

.chat-message {
  max-width:88%;
  padding:12px 14px;
  border:1px solid var(--border);
  border-radius:16px;
  background:var(--card);
  font-size:13px;
  line-height:1.65;
  overflow-wrap:anywhere;
}

.chat-message.user {
  align-self:flex-end;
  border-color:rgba(145,103,255,.35);
  background:linear-gradient(135deg,#30245b,#1a3154);
}

.chat-message.assistant {
  align-self:flex-start;
}

.chat-composer {
  display:flex;
  align-items:flex-end;
  gap:8px;
  padding:12px;
  border-top:1px solid var(--border);
  background:var(--surface);
}

.chat-composer textarea {
  flex:1;
  min-width:0;
  max-height:120px;
  min-height:45px;
  resize:none;
  padding:12px;
  border:1px solid var(--border);
  border-radius:14px;
  background:var(--bg);
  color:var(--text);
}

.toast {
  position:fixed;
  z-index:200;
  left:16px;
  right:16px;
  bottom:170px;
  display:none;
  padding:14px;
  border:1px solid var(--border);
  border-radius:14px;
  background:#202944;
  box-shadow:0 12px 35px #0006;
  color:white;
  font-size:13px;
}

.toast.show {
  display:block;
  animation:appear .2s ease;
}

.modal-backdrop {
  position:fixed;
  z-index:120;
  inset:0;
  display:none;
  align-items:center;
  justify-content:center;
  padding:16px;
  background:#030611c9;
}

.modal-backdrop.open {
  display:flex;
}

.modal {
  width:100%;
  max-width:470px;
  max-height:85dvh;
  overflow:auto;
  padding:20px;
  border:1px solid var(--border);
  border-radius:22px;
  background:var(--surface);
}

.modal-header {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:10px;
  margin-bottom:15px;
}

.modal-header h3 {
  margin:0;
}

.reminder-due {
  border-color:rgba(255,189,105,.5);
  background:rgba(255,189,105,.07);
}

.hidden {
  display:none !important;
}

@media(min-width:760px) {
  #app {
    padding-left:225px;
    padding-bottom:20px;
  }

  .desktop-sidebar {
    position:fixed;
    z-index:25;
    top:0;
    bottom:0;
    left:0;
    width:225px;
    display:flex;
    flex-direction:column;
    gap:8px;
    padding:20px 13px;
    border-right:1px solid var(--border);
    background:var(--surface);
  }

  .desktop-sidebar .brand {
    padding:0 5px 18px;
    margin-bottom:12px;
    border-bottom:1px solid var(--border);
  }

  .desktop-sidebar .side-nav {
    display:flex;
    flex-direction:column;
    gap:5px;
  }

  .side-nav button {
    display:flex;
    align-items:center;
    gap:11px;
    min-height:44px;
    padding:10px;
    border:0;
    border-radius:12px;
    background:transparent;
    color:var(--muted);
    text-align:left;
    font-size:12px;
  }

  .side-nav button.active {
    background:var(--card2);
    color:var(--text);
  }

  .bottom-nav {
    display:none;
  }

  .floating-ai {
    bottom:24px;
  }

  .toast {
    bottom:25px;
    left:auto;
    right:24px;
    width:min(360px,calc(100% - 48px));
  }

  #main {
    padding:25px;
  }
}

@media(max-width:759px) {
  .desktop-sidebar {
    display:none;
  }

  .status-pill {
    display:none;
  }

  .hero {
    padding:21px 17px;
  }

  .hero h2 {
    font-size:27px;
  }

  .stats-grid {
    gap:7px;
  }

  .stat-card {
    padding:11px 9px;
  }

  .stat-number {
    font-size:20px;
  }

  .feature-list {
    grid-template-columns:1fr;
  }
}

@media(max-width:360px) {
  #main {
    padding:14px 11px;
  }

  .category-grid {
    gap:8px;
  }

  .category-card {
    padding:12px;
  }

  .nav-btn span:last-child {
    font-size:8px;
  }

  .form-grid {
    grid-template-columns:1fr;
  }
}
</style>
</head>

<body>

<aside class="desktop-sidebar">
  <div class="brand">
    <div class="brand-icon">✦</div>
    <div>
      <h1>Local AI Studio</h1>
      <p>Create your AI world</p>
    </div>
  </div>

  <nav class="side-nav">
    <button class="active" data-nav="home">⌂ <span>Home</span></button>
    <button data-nav="mybots">◫ <span>My Bots</span></button>
    <button data-nav="categories">▦ <span>Categories</span></button>
    <button data-nav="studio">✦ <span>Bot Studio</span></button>
    <button data-nav="import">⇧ <span>Import Bots</span></button>
    <button data-nav="reminders">◷ <span>Reminders</span></button>
    <button data-nav="planner">▤ <span>Planner</span></button>
    <button data-nav="memory">◉ <span>AI Memory</span></button>
    <button data-nav="activity">↻ <span>Activity</span></button>
    <button data-nav="settings">⚙ <span>Settings</span></button>
  </nav>

  <div style="margin-top:auto;padding:13px;border:1px solid var(--border);border-radius:15px">
    <div class="eyebrow">CREATED BY</div>
    <strong style="display:block;margin-top:6px;font-size:13px">Praise Mutema</strong>
    <small class="muted">Version 1.0</small>
  </div>
</aside>

<div id="app">

  <header class="topbar">
    <div class="brand">
      <div class="brand-icon">✦</div>
      <div>
        <h1>Local AI Bot Studio</h1>
        <p>Create. Import. Launch.</p>
      </div>
    </div>

    <div class="top-actions">
      <span class="status-pill">● Local storage</span>
      <button class="icon-btn" id="openNotifications" aria-label="Notifications">♧</button>
      <button class="icon-btn" data-go="settings" aria-label="Settings">⚙</button>
    </div>
  </header>

  <main id="main">

    <!-- HOME -->
    <section class="view active" id="view-home">

      <div class="hero">
        <div class="eyebrow">YOUR PERSONAL AI WORKSPACE</div>
        <h2>Build something <span class="gradient-text">amazing.</span></h2>
        <p>
          Your bots, your ideas, your knowledge. Create and manage
          your own AI experiences in one place.
        </p>

        <div class="button-row">
          <button class="btn primary" data-go="studio">＋ Create a bot</button>
          <button class="btn secondary" data-go="mybots">Explore my bots →</button>
        </div>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon">🤖</div>
          <span class="stat-number" id="statBots">0</span>
          <span class="stat-label">My bots</span>
        </div>

        <div class="stat-card">
          <div class="stat-icon">◷</div>
          <span class="stat-number" id="statReminders">0</span>
          <span class="stat-label">Reminders</span>
        </div>

        <div class="stat-card">
          <div class="stat-icon">✦</div>
          <span class="stat-number" id="statMemories">0</span>
          <span class="stat-label">Memories</span>
        </div>
      </div>

      <div class="section">
        <div class="section-heading">
          <h3>Find anything</h3>
        </div>

        <label class="search-box">
          <span>⌕</span>
          <input id="globalSearch" placeholder="Search bots, tools and features..." autocomplete="off">
        </label>
      </div>

      <div class="section">
        <div class="section-heading">
          <h3>Quick actions</h3>
        </div>

        <div class="feature-list">
          <button class="feature-button" data-go="studio">
            <span class="feature-symbol">🛠️</span>
            <span><strong>Bot Studio</strong><small>Build your own bot</small></span>
          </button>

          <button class="feature-button" data-go="import">
            <span class="feature-symbol">📦</span>
            <span><strong>Import a bot</strong><small>Bring in existing bots</small></span>
          </button>

          <button class="feature-button" data-go="reminders">
            <span class="feature-symbol">⏰</span>
            <span><strong>Reminders</strong><small>Schedule important tasks</small></span>
          </button>

          <button class="feature-button" data-go="planner">
            <span class="feature-symbol">📅</span>
            <span><strong>My planner</strong><small>Organise your day</small></span>
          </button>

          <button class="feature-button" data-go="memory">
            <span class="feature-symbol">🧠</span>
            <span><strong>AI memory</strong><small>Manage saved information</small></span>
          </button>

          <button class="feature-button" data-go="settings">
            <span class="feature-symbol">💾</span>
            <span><strong>Backup & restore</strong><small>Protect your local data</small></span>
          </button>
        </div>
      </div>

      <div class="section">
        <div class="section-heading">
          <h3>Your categories</h3>
          <button class="text-btn" data-go="categories">View all 
<script>
/* =========================================
   LOCAL AI BOT STUDIO — PART 2
   Application logic and local storage
   ========================================= */

(() => {
  "use strict";

  const $ = id => document.getElementById(id);
  const STORAGE_KEY = "local_ai_bot_studio_v2";

  const state = {
    bots: [],
    reminders: [],
    memories: [],
    activity: [],
    notes: [],
    currentBot: null,
    currentView: "home",
    settings: {
      notifications: true,
      sound: false,
      theme: "dark",
      autoMemory: false
    }
  };

  function loadState() {
    try {
      const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || "{}");
      state.bots = Array.isArray(saved.bots) ? saved.bots : [];
      state.reminders = Array.isArray(saved.reminders) ? saved.reminders : [];
      state.memories = Array.isArray(saved.memories) ? saved.memories : [];
      state.activity = Array.isArray(saved.activity) ? saved.activity : [];
      state.notes = Array.isArray(saved.notes) ? saved.notes : [];
      state.settings = { ...state.settings, ...(saved.settings || {}) };
    } catch (error) {
      console.warn("Saved data could not be loaded.", error);
      toast("Some saved data could not be loaded.");
    }
  }

  function saveState() {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify({
        bots: state.bots,
        reminders: state.reminders,
        memories: state.memories,
        activity: state.activity.slice(0, 200),
        notes: state.notes,
        settings: state.settings
      }));
      updateStorageBadge();
      return true;
    } catch (error) {
      toast("Storage is full or unavailable. Export a backup.");
      return false;
    }
  }

  function makeId(prefix = "item") {
    return prefix + "_" + Date.now() + "_" +
      Math.random().toString(36).slice(2, 8);
  }

  function escapeHTML(value) {
    return String(value ?? "").replace(/[&<>"']/g, char => ({
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#39;"
    })[char]);
  }

  function toast(message) {
    let box = $("appToast");

    if (!box) {
      box = document.createElement("div");
      box.id = "appToast";
      box.setAttribute("role", "status");
      box.style.cssText = [
        "position:fixed",
        "bottom:85px",
        "left:50%",
        "transform:translateX(-50%)",
        "z-index:9999",
        "max-width:90%",
        "padding:12px 18px",
        "border-radius:14px",
        "background:#252b4d",
        "color:white",
        "border:1px solid #505b91",
        "box-shadow:0 8px 30px #0005",
        "font-size:14px",
        "display:none"
      ].join(";");

      document.body.appendChild(box);
    }

    box.textContent = message;
    box.style.display = "block";

    clearTimeout(box._timer);
    box._timer = setTimeout(() => {
      box.style.display = "none";
    }, 3200);
  }

  function recordActivity(action, detail = "") {
    state.activity.unshift({
      id: makeId("activity"),
      action,
      detail,
      time: Date.now()
    });

    state.activity = state.activity.slice(0, 200);
    saveState();
  }

  function formatDate(timestamp) {
    return new Date(timestamp).toLocaleString([], {
      dateStyle: "medium",
      timeStyle: "short"
    });
  }

  function updateStorageBadge() {
    const badge = $("storageBadge");
    if (!badge) return;

    try {
      const bytes = new Blob([
        localStorage.getItem(STORAGE_KEY) || ""
      ]).size;

      badge.textContent = bytes > 1024 * 1024
        ? (bytes / 1024 / 1024).toFixed(1) + " MB saved"
        : Math.max(1, Math.round(bytes / 1024)) + " KB saved";
    } catch {
      badge.textContent = "Local storage";
    }
  }

  /* ---------- NAVIGATION ---------- */

  function showView(viewName) {
    const target = $("view-" + viewName);

    if (!target) {
      toast("That screen is not available.");
      return;
    }

    document.querySelectorAll(".view").forEach(view => {
      view.classList.toggle("active", view === target);
    });

    document.querySelectorAll("[data-nav]").forEach(button => {
      button.classList.toggle(
        "active",
        button.dataset.nav === viewName
      );
    });

    state.currentView = viewName;

    try {
      localStorage.setItem("local_ai_last_view", viewName);
    } catch {}

    renderCurrentView();
  }

  function renderCurrentView() {
    if (state.currentView === "home") renderHome();
    if (state.currentView === "mybots") renderBots();
    if (state.currentView === "reminders") renderReminders();
    if (state.currentView === "planner") renderPlanner();
    if (state.currentView === "memory") renderMemories();
    if (state.currentView === "activity") renderActivity();
    if (state.currentView === "settings") renderSettings();
  }

  document.addEventListener("click", event => {
    const nav = event.target.closest("[data-nav]");
    if (nav) showView(nav.dataset.nav);

    const go = event.target.closest("[data-go]");
    if (go) showView(go.dataset.go);

    const close = event.target.closest("[data-close-modal]");
    if (close) closeModal();
  });

  /* ---------- HOME ---------- */

  function renderHome() {
    const total = $("statTotal");
    const recent = $("statRecent");
    const fav = $("statFav");

    if (total) total.textContent = state.bots.length;

    if (recent) {
      recent.textContent = state.bots.filter(bot => bot.lastOpened).length;
    }

    if (fav) {
      fav.textContent = state.bots.filter(bot => bot.favourite).length;
    }

    const list = $("recentList");
    if (!list) return;

    const items = [...state.bots]
      .filter(bot => bot.lastOpened)
      .sort((a, b) => b.lastOpened - a.lastOpened)
      .slice(0, 4);

    list.innerHTML = items.length
      ? items.map(botCardHTML).join("")
      : '<p style="color:var(--muted)">Your recently opened bots will appear here.</p>';

    attachBotCardEvents(list);
  }

  /* ---------- BOT LIBRARY ---------- */

  function botCardHTML(bot) {
    return `
      <article class="card bot-card" data-id="${escapeHTML(bot.id)}">
        <div class="icon">${escapeHTML(bot.icon || "🤖")}</div>
        <h3>${escapeHTML(bot.name)}</h3>
        <p>${escapeHTML(bot.description || "Personal AI bot")}</p>
        <div style="display:flex;gap:6px;flex-wrap:wrap">
          <span class="chip">${escapeHTML(bot.category || "General")}</span>
          <span class="chip">${escapeHTML(bot.version || "1.0")}</span>
        </div>
        <div class="actions">
          <button type="button" class="launch">Open</button>
          <button type="button" class="fav">
            ${bot.favourite ? "★ Saved" : "☆ Save"}
          </button>
          <button type="button" class="del">Delete</button>
        </div>
      </article>`;
  }

  function renderBots() {
    const grid = $("botsGrid");
    if (!grid) return;

    const search = ($("searchBots")?.value || "").toLowerCase();
    const filter = $("filterBots")?.value || "all";

    let bots = [...state.bots];

    if (search) {
      bots = bots.filter(bot =>
        (bot.name + " " + bot.description + " " + bot.category)
          .toLowerCase().includes(search)
      );
    }

    if (filter === "fav") bots = bots.filter(bot => bot.favourite);
    if (filter === "recent") {
      bots = bots.filter(bot => bot.lastOpened)
        .sort((a, b) => b.lastOpened - a.lastOpened);
    }
    if (filter === "created") bots = bots.filter(bot => bot.source === "created");
    if (filter === "imported") bots = bots.filter(bot => bot.source === "imported");

    grid.innerHTML = bots.length
      ? bots.map(botCardHTML).join("")
      : '<p style="color:var(--muted)">No bots found. Create or import one to begin.</p>';

    attachBotCardEvents(grid);
  }

  function attachBotCardEvents(container) {
    container.querySelectorAll(".bot-card").forEach(card => {
      const bot = state.bots.find(item => item.id === card.dataset.id);
      if (!bot) return;

      card.querySelector(".launch")?.addEventListener("click", event => {
        event.stopPropagation();
        openBot(bot.id);
      });

      card.querySelector(".fav")?.addEventListener("click", event => {
        event.stopPropagation();
        bot.favourite = !bot.favourite;
        saveState();
        renderCurrentView();
      });

      card.querySelector(".del")?.addEventListener("click", event => {
        event.stopPropagation();

        if (!confirm("Delete " + bot.name + "?")) return;

        state.bots = state.bots.filter(item => item.id !== bot.id);
        recordActivity("Bot deleted", bot.name);
        renderCurrentView();
        toast("Bot deleted.");
      });

      card.addEventListener("dblclick", () => openBot(bot.id));
    });
  }

  function createBot(data = {}) {
    const name = String(data.name || "").trim();

    if (!name) {
      toast("Enter a name for your bot.");
      return null;
    }

    const bot = {
      id: makeId("bot"),
      name,
      description: String(data.description || "").trim(),
      category: String(data.category || "General"),
      icon: String(data.icon || "🤖"),
      version: String(data.version || "1.0"),
      source: "created",
      createdAt: Date.now(),
      lastOpened: 0,
      favourite: false,
      html: String(data.html || "")
    };

    state.bots.unshift(bot);
    saveState();
    recordActivity("Bot created", bot.name);
    renderCurrentView();
    toast("Bot created.");
    return bot;
  }

  function openBot(id) {
    const bot = state.bots.find(item => item.id === id);
    if (!bot) return;

    state.currentBot = bot;
    bot.lastOpened = Date.now();
    saveState();
    recordActivity("Bot opened", bot.name);

    const overlay = $("runtimeOverlay");
    const title = $("runtimeTitle");
    const description = $("runtimeDesc");
    const frame = $("botFrame");

    if (title) title.textContent = bot.name;
    if (description) description.textContent = bot.description;

    if (overlay) overlay.classList.add("open");

    if (frame) {
      if (bot.html) {
        const safeHTML = bot.html;
        frame.srcdoc = safeHTML;
      } else {
        frame.srcdoc = `
          <!DOCTYPE html>
          <html><head><meta name="viewport" content="width=device-width,initial-scale=1">
          <style>
          body{font-family:system-ui;padding:24px;background:#0a0e1f;color:#e6e9ff}
          input,button{padding:12px;border-radius:10px;margin-top:8px}
          input{width:95%;border:1px solid #555;background:#171c36;color:white}
          button{background:#7c5cff;color:white;border:0}
          </style></head><body>
          <h2>${escapeHTML(bot.icon)} ${escapeHTML(bot.name)}</h2>
          <p>${escapeHTML(bot.description || "Your new bot is ready to configure.")}</p>
          <p>This bot has no HTML program yet. Add code in Bot Studio to give it functionality.</p>
          </body></html>`;
      }
    }

    renderHome();
  }

  function closeBot() {
    $("runtimeOverlay")?.classList.remove("open");

    const frame = $("botFrame");
    if (frame) frame.srcdoc = "";

    state.currentBot = null;
  }

  $("btnCloseBot")?.addEventListener("click", closeBot);
  $("btnRestartBot")?.addEventListener("click", () => {
    if (state.currentBot) openBot(state.currentBot.id);
  });

  $("searchBots")?.addEventListener("input", renderBots);
  $("filterBots")?.addEventListener("change", renderBots);

  /* ---------- BOT STUDIO ---------- */

  $("btnSaveStudio")?.addEventListener("click", () => {
    createBot({
      name: $("studioName")?.value,
      description: $("studioDesc")?.value,
      icon: $("studioIcon")?.value,
      version: $("studioVersion")?.value,
      html: $("studioCode")?.value
    });
  });

  $("btnClearStudio")?.addEventListener("click", () => {
    if (!confirm("Clear the editor?")) return;

    ["studioName", "studioDesc", "studioCode"].forEach(id => {
      if ($(id)) $(id).value = "";
    });

    if ($("studioIcon")) $("studioIcon").value = "🤖";
    if ($("studioVersion")) $("studioVersion").value = "1.0";
  });

  $("btnPreviewStudio")?.addEventListener("click", () => {
    const html = $("studioCode")?.value || "";

    if (!html.trim()) {
      toast("Paste or write some HTML first.");
      return;
    }

    const preview = window.open("", "_blank");
    if (!preview) {
      toast("Allow pop-ups to preview this code.");
      return;
    }

    preview.document.open();
    preview.document.write(html);
    preview.document.close();
  });

  $("btnExportHtml")?.addEventListener("click", () => {
    const html = $("studioCode")?.value || "";
    if (!html.trim()) return toast("There is no HTML to export.");
    downloadText(($("studioName")?.value || "my-bot") + ".html", html);
  });

  /* ---------- IMPORT HTML ---------- */

  $("fileHtml")?.addEventListener("change", async event => {
    const file = event.target.files?.[0];
    if (!file) return;

    if (file.size > 10 * 1024 * 1024) {
      toast("HTML file is too large. Maximum 10 MB.");
      return;
    }

    try {
      const html = await file.text();

      createBot({
        name: file.name.replace(/\.html?$/i, ""),
        description: "Imported HTML bot",
        icon: "🌐",
        html,
        version: "1.0"
      });

      toast("HTML imported into your local library.");
    } catch {
      toast("Could not read that HTML file.");
    }

    event.target.value = "";
  });

  /* ---------- REMINDERS ---------- */

  function addReminder(data) {
    const title = String(data.title || "").trim();
    const time = new Date(data.time).getTime();

    if (!title) {
      toast("Enter a reminder title.");
      return;
    }

    if (!Number.isFinite(time) || time <= Date.now()) {
      toast("Choose a future date and time.");
      return;
    }

    const reminder = {
      id: makeId("reminder"),
      title,
      notes: String(data.notes || "").trim(),
      time,
      repeat: data.repeat || "none",
      priority: data.priority || "normal",
      completed: false,
      notified: false,
      createdAt: Date.now()
    };

    state.reminders.push(reminder);
    state.reminders.sort((a, b) => a.time - b.time);
    saveState();
    recordActivity("Reminder created", title);
    renderReminders();
    renderPlanner();
    toast("Reminder saved on this device.");
  }

  function renderReminders() {
    const list = $("reminderList");
    if (!list) return;

    const reminders = [...state.reminders]
      .filter(item => !item.completed)
      .sort((a, b) => a.time - b.time);

    list.innerHTML = reminders.length
      ? reminders.map(item => `
        <article class="card" style="margin-bottom:10px">
          <h3>${escapeHTML(item.title)}</h3>
          <p>${escapeHTML(formatDate(item.time))}</p>
          <p>${escapeHTML(item.notes)}</p>
          <span class="chip">${escapeHTML(item.priority)} priority</span>
          <span class="chip">${escapeHTML(item.repeat)} repeat</span>
          <div class="actions">
            <button type="button" data-reminder-done="${escapeHTML(item.id)}">Done</button>
            <button type="button" data-reminder-delete="${escapeHTML(item.id)}">Delete</button>
          </div>
        </article>`).join("")
      : '<p style="color:var(--muted)">No upcoming reminders. Add one below.</p>';

    list.querySelectorAll("[data-reminder-done]").forEach(button => {
      button.addEventListener("click", () => {
        const item = state.reminders.find(r => r.id === button.dataset.reminderDone);
        if (!item) return;
        item.completed = true;
        saveState();
        renderReminders();
        renderPlanner();
        toast("Reminder completed.");
      });
    });

    list.querySelectorAll("[data-reminder-delete]").forEach(button => {
      button.addEventListener("click", () => {
        state.reminders = state.reminders.filter(
          r => r.id !== button.dataset.reminderDelete
        );
        saveState();
        renderReminders();
        renderPlanner();
        toast("Reminder deleted.");
      });
    });
  }

  $("btnAddReminder")?.addEventListener("click", () => {
    const title = $("reminderTitle")?.value || "";
    const date = $("reminderDate")?.value || "";
    const time = $("reminderTime")?.value || "";

    if (!date || !time) return toast("Choose the reminder date and time.");

    addReminder({
      title,
      time: date + "T" + time,
      notes: $("reminderNotes")?.value,
      repeat: $("reminderRepeat")?.value || "none",
      priority: $("reminderPriority")?.value || "normal"
    });

    if ($("reminderTitle")) $("reminderTitle").value = "";
    if ($("reminderNotes")) $("reminderNotes").value = "";
  });

  $("btnEnableNotifications")?.addEventListener("click", async () => {
    if (!("Notification" in window)) {
      toast("This browser does not support notifications.");
      return;
    }

    try {
      const permission = await Notification.requestPermission();

      if (permission === "granted") {
        toast("Notifications allowed while browser support is available.");
      } else {
        toast("Notifications were not enabled.");
      }
    } catch {
      toast("Notification permission is unavailable in this context.");
    }
  });

  function checkReminders() {
    const now = Date.now();
    let changed = false;

    state.reminders.forEach(item => {
      if (item.completed || item.notified || item.time > now) return;

      item.notified = true;
      changed = true;

      toast("Reminder: " + item.title);

      if ("Notification" in window &&
          Notification.permission === "granted") {
        try {
          new Notification("Local AI Bot Studio", {
            body: item.title
          });
        } catch {}
      }

      recordActivity("Reminder triggered", item.title);

      if (item.repeat !== "none") {
        const next = new Date(item.time);

        if (item.repeat === "daily") next.setDate(next.getDate() + 1);
        if (item.repeat === "weekly") next.setDate(next.getDate() + 7);
        if (item.repeat === "monthly") next.setMonth(next.getMonth() + 1);

        if (next.getTime() > now) {
          item.time = next.getTime();
          item.notified = false;
          item.completed = false;
        } else {
          item.completed = true;
        }
      } else {
        item.completed = true;
      }
    });

    if (changed) {
      saveState();
      renderReminders();
      renderPlanner();
    }
  }

  /* Browser timers run only while this page is active.
     Native Android alarm integration is required for dependable
     reminders when the app is closed or the device restarts. */
  setInterval(checkReminders, 15000);

  /* ---------- PLANNER ---------- */

  function renderPlanner() {
    const list = $("plannerList");
    if (!list) return;

    const items = state.reminders
      .filter(item => !item.completed)
      .sort((a, b) => a.time - b.time);

    list.innerHTML = items.length
      ? items.map(item => `
        <div class="card" style="margin-bottom:8px">
          <b>${escapeHTML(item.title)}</b>
          <p>${escapeHTML(formatDate(item.time))}</p>
        </div>`).join("")
      : '<p style="color:var(--muted)">Your upcoming plan will appear here.</p>';
  }

  /* ---------- LOCAL MEMORY ---------- */

  function renderMemories() {
    const list = $("memoryList");
    if (!list) return;

    list.innerHTML = state.memories.length
      ? state.memories.map(item => `
        <article class="card" style="margin-bottom:8px">
          <p>${escapeHTML(item.text)}</p>
          <small>${escapeHTML(formatDate(item.time))}</small>
          <button type="button" data-memory-delete="${escapeHTML(item.id)}">Forget</button>
        </article>`).join("")
      : '<p style="color:var(--muted)">No saved memories yet.</p>';

    list.querySelectorAll("[data-memory-delete]").forEach(button => {
      button.addEventListener
