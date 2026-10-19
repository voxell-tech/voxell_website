// The roadmaps page: one tab per project, each listing that repo's
// open GitHub issues as cards, with a modal for the full issue.
//
// Loaded by the kit's demo-bootstrap.js through the page's
// `data-demo-src`, once per page load; `init` runs again on each
// `tola:navigate` so the page works however it was reached.
//
// Issue titles and bodies are written by anyone with a GitHub
// account, so every piece of rendered Markdown goes through
// DOMPurify before it reaches the page.

import { marked } from "https://cdn.jsdelivr.net/npm/marked@12.0.2/lib/marked.esm.js";
import DOMPurify from "https://cdn.jsdelivr.net/npm/dompurify@3.1.6/dist/purify.es.mjs";

const CACHE_TTL = 60 * 60 * 1000;

const monokaiPro = {
  name: "monokai-pro",
  type: "dark",
  colors: { "editor.background": "#2d2a2e", "editor.foreground": "#fcfcfa" },
  tokenColors: [
    { scope: ["comment", "punctuation.definition.comment"], settings: { foreground: "#939293", fontStyle: "italic" } },
    { scope: ["string", "string.quoted", "string.template"], settings: { foreground: "#ffd866" } },
    { scope: ["constant.numeric", "constant.language"], settings: { foreground: "#ab9df2" } },
    { scope: ["keyword", "storage.type", "storage.modifier"], settings: { foreground: "#ff6188" } },
    { scope: ["entity.name.function", "support.function"], settings: { foreground: "#a9dc76" } },
    { scope: ["entity.name.type", "entity.name.class", "support.class", "entity.other.inherited-class"], settings: { foreground: "#78dce8" } },
    { scope: ["variable", "variable.other"], settings: { foreground: "#fcfcfa" } },
    { scope: ["keyword.operator", "entity.name.tag"], settings: { foreground: "#ff6188" } },
    { scope: ["support.type", "support.other.namespace"], settings: { foreground: "#78dce8" } },
    { scope: ["constant.other.color", "support.constant"], settings: { foreground: "#ab9df2" } },
  ],
};

// Shiki is big, so it loads once something needs highlighting.
let highlighter = null;
const highlighterReady = import("https://esm.sh/shiki@1.10.3")
  .then(({ createHighlighter }) =>
    createHighlighter({
      themes: [monokaiPro, "github-light"],
      langs: ["typst", "rust", "toml", "bash", "javascript", "typescript", "python", "json", "css", "html", "markdown"],
    }),
  )
  .then((h) => {
    highlighter = h;
  })
  .catch(() => {});

const safe = (html) => DOMPurify.sanitize(html);
const inline = (text) => safe(marked.parseInline(text || ""));

function renderMarkdown(text, container) {
  container.innerHTML = safe(marked.parse(text || ""));
  highlight(container);
}

// Colours the code blocks under `container`, once Shiki has loaded.
function highlight(container) {
  if (!highlighter) return;
  container.querySelectorAll("pre code").forEach((el) => {
    const lang = (el.className.match(/language-(\w+)/) || [])[1] || "text";
    try {
      // Shiki escapes the code it is given, so its output is safe.
      el.closest("pre").outerHTML = highlighter.codeToHtml(el.textContent, {
        lang,
        themes: { dark: "monokai-pro", light: "github-light" },
        defaultColor: false,
      });
    } catch {}
  });
}

function labelClass(name) {
  if (name === "blocked") return "roadmap-label roadmap-label-red";
  if (name === "breaking") return "roadmap-label roadmap-label-orange";
  if (name === "good first issue") return "roadmap-label roadmap-label-green";
  return "roadmap-label";
}

function badges(labels) {
  const row = document.createElement("div");
  row.className = "flex flex-wrap gap-2";
  for (const label of labels) {
    const badge = document.createElement("span");
    badge.className = labelClass(label.name);
    badge.textContent = label.name;
    row.appendChild(badge);
  }
  return row;
}

// The modal lives in the page body, which Tola's navigation replaces,
// so it is made again whenever it has gone.
function modal() {
  let el = document.getElementById("roadmap-modal");
  if (el) return el;
  el = document.createElement("div");
  el.id = "roadmap-modal";
  el.className = "roadmap-modal";
  el.hidden = true;
  el.innerHTML = `
    <div class="roadmap-modal-backdrop"></div>
    <div class="roadmap-modal-panel" role="dialog" aria-modal="true" aria-labelledby="roadmap-modal-title">
      <div class="roadmap-modal-head">
        <div class="min-w-0">
          <div class="roadmap-modal-badges"></div>
          <h2 id="roadmap-modal-title" class="roadmap-modal-title"></h2>
        </div>
        <div class="flex items-center gap-3 shrink-0">
          <a class="roadmap-modal-link" target="_blank" rel="noopener noreferrer">View on GitHub ↗</a>
          <button type="button" class="roadmap-modal-close" aria-label="Close">✕</button>
        </div>
      </div>
      <div class="roadmap-modal-body markdown-body"></div>
    </div>`;
  document.body.appendChild(el);
  const close = () => {
    el.hidden = true;
  };
  el.querySelector(".roadmap-modal-backdrop").addEventListener("click", close);
  el.querySelector(".roadmap-modal-close").addEventListener("click", close);
  return el;
}

document.addEventListener("keydown", (event) => {
  const el = document.getElementById("roadmap-modal");
  if (event.key === "Escape" && el) el.hidden = true;
});

function openIssue(issue) {
  const el = modal();
  el.querySelector(".roadmap-modal-title").innerHTML = inline(issue.title);
  el.querySelector(".roadmap-modal-badges").replaceChildren(badges(issue.labels));
  el.querySelector(".roadmap-modal-link").href = issue.html_url;
  renderMarkdown(issue.body || "*No description provided.*", el.querySelector(".roadmap-modal-body"));
  el.hidden = false;
  el.querySelector(".roadmap-modal-close").focus();
}

function card(issue) {
  const el = document.createElement("button");
  el.type = "button";
  el.className = "roadmap-card group";
  el.appendChild(badges(issue.labels));
  const title = document.createElement("h4");
  title.className = "roadmap-card-title";
  title.innerHTML = inline(issue.title);
  el.appendChild(title);
  const preview = document.createElement("div");
  preview.className = "roadmap-card-preview markdown-body";
  renderMarkdown(issue.body, preview);
  el.appendChild(preview);
  el.addEventListener("click", () => openIssue(issue));
  return el;
}

async function cachedFetch(url, key) {
  try {
    const { data, ts } = JSON.parse(localStorage.getItem(key));
    if (Date.now() - ts < CACHE_TTL) return data;
  } catch {}
  const response = await fetch(url);
  if (!response.ok) throw new Error(`HTTP ${response.status}`);
  const data = await response.json();
  try {
    localStorage.setItem(key, JSON.stringify({ data, ts: Date.now() }));
  } catch {}
  return data;
}

function note(grid, text) {
  const p = document.createElement("p");
  p.className = "text-muted text-sm md:col-span-2";
  p.textContent = text;
  grid.replaceChildren(p);
}

async function loadIssues(grid) {
  const repo = grid.dataset.repo;
  note(grid, "Loading issues…");
  try {
    const issues = await cachedFetch(
      `https://api.github.com/repos/voxell-tech/${repo}/issues?state=open&per_page=50`,
      `gh-issues-${repo}`,
    );
    const open = issues.filter((i) => !i.pull_request);
    const count = document.querySelector(`[data-issue-count="${repo}"]`);
    if (count) count.textContent = String(open.length);
    if (!open.length) return note(grid, "No open issues right now.");
    grid.replaceChildren(...open.map(card));
    // The cards show at once; their code blocks colour in when Shiki
    // is ready.
    highlighterReady.then(() => highlight(grid));
  } catch {
    note(grid, "Couldn't reach GitHub. Try again in a minute.");
  }
}

// Tabs: the hash picks the project, the first one by default.
function show(id) {
  const pages = [...document.querySelectorAll(".roadmap-page")];
  if (!pages.length) return;
  const target = pages.find((p) => p.id === id) ?? pages[0];
  for (const page of pages) page.hidden = page !== target;
  document.querySelectorAll(".roadmap-tab").forEach((tab) => {
    tab.toggleAttribute("data-active", tab.getAttribute("href") === `#${target.id}`);
  });
  const grid = target.querySelector(".issues-grid");
  if (grid && !grid.dataset.loaded) {
    grid.dataset.loaded = "true";
    loadIssues(grid);
  }
}

document.addEventListener("click", (event) => {
  const tab = event.target.closest(".roadmap-tab");
  if (!tab) return;
  event.preventDefault();
  const id = tab.getAttribute("href").slice(1);
  history.pushState(null, "", `#${id}`);
  show(id);
});

window.addEventListener("popstate", () => show(location.hash.slice(1)));

function init() {
  if (document.querySelector(".roadmap-page")) show(location.hash.slice(1));
}

init();
document.addEventListener("tola:navigate", init);
