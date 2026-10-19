// Live GitHub numbers. Every `[data-stars="owner/name"]` shows that
// repo's stars, `[data-stars-total]` the sum over voxell-tech, and
// `[data-repo-count]` how many public repos it has. The page ships
// with a snapshot, so this only refreshes it: one request to GitHub,
// cached for an hour, and nothing changes if it fails.

const KEY = "voxell-org-repos";
const TTL = 60 * 60 * 1000;

function cached() {
  try {
    const { data, ts } = JSON.parse(localStorage.getItem(KEY));
    if (Date.now() - ts < TTL) return data;
  } catch {}
  return null;
}

let repos = null;

async function load() {
  repos ??= cached();
  if (repos) return repos;
  const response = await fetch(
    "https://api.github.com/orgs/voxell-tech/repos?per_page=100&type=public",
  );
  if (!response.ok) throw new Error(`HTTP ${response.status}`);
  repos = (await response.json()).map((r) => ({
    name: r.full_name,
    stars: r.stargazers_count,
  }));
  try {
    localStorage.setItem(KEY, JSON.stringify({ data: repos, ts: Date.now() }));
  } catch {}
  return repos;
}

const format = (n) => n.toLocaleString("en");

async function refresh() {
  const targets = document.querySelectorAll(
    "[data-stars], [data-stars-total], [data-repo-count]",
  );
  if (!targets.length) return;
  let list;
  try {
    list = await load();
  } catch {
    return;
  }
  const byName = new Map(list.map((r) => [r.name, r.stars]));
  document.querySelectorAll("[data-stars]").forEach((el) => {
    const stars = byName.get(el.dataset.stars);
    if (stars != null) el.textContent = format(stars);
  });
  document.querySelectorAll("[data-stars-total]").forEach((el) => {
    el.textContent = format(list.reduce((sum, r) => sum + r.stars, 0));
  });
  document.querySelectorAll("[data-repo-count]").forEach((el) => {
    el.textContent = format(list.length);
  });
}

refresh();
document.addEventListener("tola:navigate", refresh);
