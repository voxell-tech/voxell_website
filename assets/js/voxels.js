// The home page hero: an isometric field of voxel columns that rolls
// in slow waves and rises under the pointer. Plain Canvas 2D, no
// libraries.
//
// Loaded by the kit's demo-bootstrap.js through the hero's
// `data-demo-src`, once per page load. Tola's SPA navigation swaps the
// page body without re-running modules, so `mount` runs again on each
// `tola:navigate` and picks up a fresh canvas when the home page comes
// back.

function rgb(hex) {
  const n = parseInt(hex.slice(1), 16);
  return [(n >> 16) & 255, (n >> 8) & 255, n & 255];
}

// `c` mixed toward `to` by `t`, as a CSS colour.
function mix(c, to, t) {
  const m = c.map((v, i) => Math.round(v + (to[i] - v) * t));
  return `rgb(${m[0]}, ${m[1]}, ${m[2]})`;
}

// Monokai Pro, from low columns to high ones, in both themes.
const PALETTE = ["#78dce8", "#a9dc76", "#ffd866", "#fc9867", "#ff6188", "#ab9df2"].map(rgb);

// How each theme lights the field. A face is its column's colour,
// darkened toward `shadow` (sides more than tops, by up to `shade`),
// then faded into `bg` by depth and height: a column at the floor
// keeps `floor` of its colour, the tallest keep all of it.
//
// On the dark page the shadow is the page itself, so low columns sink
// into it. On the light page that would make sides paler than tops and
// the floor milky, so sides darken toward ink, and the floor keeps more
// colour.
const THEMES = {
  dark: {
    bg: rgb("#19181a"),
    shadow: rgb("#19181a"),
    shade: 1,
    floor: 0.32,
  },
  light: {
    bg: rgb("#f6f6f6"),
    shadow: rgb("#2d2a2e"),
    shade: 0.7,
    floor: 0.62,
  },
};

const N = 66;
const MAX = 6;

const reduced = window.matchMedia("(prefers-reduced-motion: reduce)");

function mount(canvas) {
  if (canvas.dataset.mounted) return;
  canvas.dataset.mounted = "true";

  const ctx = canvas.getContext("2d");
  const heights = new Float32Array(N * N).fill(1);
  const pointer = { i: -100, j: -100, strength: 0 };
  let width = 0;
  let height = 0;
  let tile = 0;
  let visible = true;
  let last = performance.now();
  let time = 0;
  let frame = 0;

  function resize() {
    const dpr = Math.min(window.devicePixelRatio || 1, 2);
    width = canvas.clientWidth;
    height = canvas.clientHeight;
    canvas.width = Math.round(width * dpr);
    canvas.height = Math.round(height * dpr);
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    // Wide enough that the field runs off both sides.
    tile = Math.max(26, width / 24);
  }

  // The field's centre: lower than the canvas centre, so the title
  // sits over the far, calmer side.
  function origin() {
    return [width / 2, height * 0.62 - (N * tile) / 4];
  }

  function target(i, j, t) {
    const wave =
      (0.5 + 0.5 * Math.sin(i * 0.33 + t * 0.7)) *
      (0.5 + 0.5 * Math.cos(j * 0.29 - t * 0.55));
    const ripple = 0.5 + 0.5 * Math.sin((i + j) * 0.18 - t * 0.9);
    const di = i - pointer.i;
    const dj = j - pointer.j;
    const bump = pointer.strength * 5 * Math.exp(-(di * di + dj * dj) / 14);
    // Whole numbers: columns step a voxel at a time. Squaring the
    // wave keeps most of the floor low, so the peaks stand out.
    return Math.min(
      MAX,
      Math.max(0, Math.round(wave * wave * 4.5 + ripple * 1.3 - 0.2 + bump)),
    );
  }

  function draw(dt) {
    const light = document.documentElement.dataset.theme === "light";
    const { bg, shadow, shade, floor } = light ? THEMES.light : THEMES.dark;
    const [cx, cy] = origin();
    const hw = tile / 2;
    const hh = tile / 4;
    const unit = tile * 0.36;
    const ease = 1 - Math.exp(-dt * 10);

    ctx.clearRect(0, 0, width, height);
    ctx.lineJoin = "round";

    // Back to front, so nearer columns cover farther ones.
    for (let s = 0; s < 2 * N - 1; s++) {
      for (let i = Math.max(0, s - N + 1); i <= Math.min(s, N - 1); i++) {
        const j = s - i;
        const k = i * N + j;
        const goal = target(i, j, time);
        heights[k] += (goal - heights[k]) * (reduced.matches ? 1 : ease);
        const h = heights[k];

        const x = cx + (i - j) * hw;
        const y = cy + (i + j) * hh - h * unit;
        if (x < -tile || x > width + tile || y > height + tile) continue;

        // Fade the far edge and the near rows into the page, and let
        // the taller columns light up.
        const depth = s / (2 * N - 2);
        const fade =
          Math.min(1, Math.max(0, depth * 2.4 - 0.2)) *
          Math.min(1, (1 - depth) * 6);
        const lit = floor + (1 - floor) * Math.min(1, h / (MAX - 1));
        const colour = PALETTE[Math.min(PALETTE.length - 1, Math.floor(h))];
        // A face shaded by `t` (0 for a lit top, more for the sides).
        const toward = (t) => {
          const shaded = colour.map(
            (v, n) => v + (shadow[n] - v) * t * shade,
          );
          return mix(shaded, bg, 1 - fade * lit);
        };

        const z = h * unit;
        // Left face.
        ctx.fillStyle = toward(0.45);
        ctx.beginPath();
        ctx.moveTo(x - hw, y + hh);
        ctx.lineTo(x, y + 2 * hh);
        ctx.lineTo(x, y + 2 * hh + z);
        ctx.lineTo(x - hw, y + hh + z);
        ctx.fill();
        // Right face.
        ctx.fillStyle = toward(0.62);
        ctx.beginPath();
        ctx.moveTo(x + hw, y + hh);
        ctx.lineTo(x, y + 2 * hh);
        ctx.lineTo(x, y + 2 * hh + z);
        ctx.lineTo(x + hw, y + hh + z);
        ctx.fill();
        // Top face.
        ctx.fillStyle = toward(0.08);
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x + hw, y + hh);
        ctx.lineTo(x, y + 2 * hh);
        ctx.lineTo(x - hw, y + hh);
        ctx.closePath();
        ctx.fill();
        // Grid lines: a touch of colour on the dark page, a darker
        // shade of the face on the light one.
        ctx.strokeStyle = light ? toward(0.3) : mix(bg, colour, 0.18 * fade);
        ctx.lineWidth = 1;
        ctx.stroke();
      }
    }
  }

  function tick(now) {
    frame = 0;
    if (!canvas.isConnected) return stop();
    const dt = Math.min(0.05, (now - last) / 1000);
    last = now;
    if (!reduced.matches) time += dt;
    pointer.strength += ((pointer.on ? 1 : 0) - pointer.strength) * Math.min(1, dt * 4);
    draw(dt);
    if (visible && !document.hidden && !reduced.matches) {
      frame = requestAnimationFrame(tick);
    }
  }

  function start() {
    if (frame) return;
    last = performance.now();
    frame = requestAnimationFrame(tick);
  }

  function stop() {
    if (frame) cancelAnimationFrame(frame);
    frame = 0;
    observer.disconnect();
    themeWatch.disconnect();
    sizeWatch.disconnect();
    document.removeEventListener("visibilitychange", start);
  }

  const observer = new IntersectionObserver((entries) => {
    visible = entries.some((e) => e.isIntersecting);
    if (visible) start();
  });
  observer.observe(canvas);

  // The pointer, projected back onto the grid.
  canvas.parentElement.addEventListener("pointermove", (event) => {
    const rect = canvas.getBoundingClientRect();
    const [cx, cy] = origin();
    const a = (event.clientX - rect.left - cx) / (tile / 2);
    const b = (event.clientY - rect.top - cy) / (tile / 4);
    pointer.i = (a + b) / 2;
    pointer.j = (b - a) / 2;
    pointer.on = true;
    if (reduced.matches) draw(1);
  });
  canvas.parentElement.addEventListener("pointerleave", () => {
    pointer.on = false;
  });

  document.addEventListener("visibilitychange", start);
  // The theme toggle repaints a paused field too.
  const themeWatch = new MutationObserver(() => draw(1));
  themeWatch.observe(document.documentElement, {
    attributes: true,
    attributeFilter: ["data-theme"],
  });

  // Settle on the first frame instead of growing from flat.
  for (let k = 0; k < N * N; k++) {
    heights[k] = target(Math.floor(k / N), k % N, 0);
  }
  // Sized from the canvas itself, not the window, so a layout that
  // settles after the script runs (late CSS, fonts) still fits.
  const sizeWatch = new ResizeObserver(() => {
    resize();
    draw(1);
    start();
  });
  sizeWatch.observe(canvas);
}

function mountAll() {
  document.querySelectorAll("canvas.voxel-field").forEach(mount);
}

mountAll();
document.addEventListener("tola:navigate", mountAll);
