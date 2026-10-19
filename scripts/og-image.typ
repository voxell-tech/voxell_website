// Social preview card (Open Graph / Twitter), 1200x630 at 1pt = 1px.
// Regenerate after editing:
//   typst compile --root . --ppi 72 scripts/og-image.typ assets/images/og.png
// Colors are the site's dark-theme tokens (shared/styles.css), and the
// voxels echo the home page's hero (assets/js/voxels.js).

#set page(width: 1200pt, height: 630pt, margin: 0pt, fill: rgb("#19181a"))
#set text(font: "Helvetica Neue", fill: rgb("#fcfcfa"))

#let palette = ("#78dce8", "#a9dc76", "#ffd866", "#fc9867", "#ff6188", "#ab9df2").map(rgb)
#let bg = rgb("#19181a")

// One isometric voxel column of `h` cubes at grid cell (i, j).
#let column(i, j, h, s) = {
  let hw = s / 2
  let hh = s / 4
  let x = (i - j) * hw
  let y = (i + j) * hh - h * s * 0.5
  let c = palette.at(calc.min(palette.len() - 1, h))
  let z = h * s * 0.5
  let face(points, shade) = place(top + left, polygon(
    fill: color.mix((c, 100% - shade), (bg, shade)),
    ..points.map(((px, py)) => (px * 1pt, py * 1pt)),
  ))
  face(((x - hw, y + hh), (x, y + 2 * hh), (x, y + 2 * hh + z), (x - hw, y + hh + z)), 45%)
  face(((x + hw, y + hh), (x, y + 2 * hh), (x, y + 2 * hh + z), (x + hw, y + hh + z)), 62%)
  face(((x, y), (x + hw, y + hh), (x, y + 2 * hh), (x - hw, y + hh)), 8%)
}

// A small cluster of voxels on the right, heights in reading order.
#let heights = (
  (1, 2, 1, 0, 1),
  (2, 4, 3, 1, 0),
  (1, 3, 5, 2, 1),
  (0, 1, 2, 3, 1),
  (1, 0, 1, 1, 2),
)
#place(top + left, dx: 930pt, dy: 175pt, {
  // Back to front, so nearer columns cover farther ones.
  for s in range(9) {
    for i in range(calc.max(0, s - 4), calc.min(s, 4) + 1) {
      column(i, s - i, heights.at(i).at(s - i), 64)
    }
  }
})

#place(left + horizon, dx: 90pt, stack(
  dir: ttb,
  spacing: 26pt,
  image("/shared/icons/voxell.svg", height: 72pt),
  text(size: 140pt, weight: "bold", tracking: -4pt, fill: gradient.linear(
    rgb("#fcfcfa"),
    rgb("#78dce8"),
    rgb("#ab9df2"),
    rgb("#ff6188"),
  ))[Voxell],
  text(size: 34pt, fill: rgb("#939293"))[
    Building tools to solve real, challenging problems.
  ],
))

#place(bottom + left, dx: 90pt, dy: -50pt)[
  #text(size: 24pt, fill: rgb("#78dce8"))[voxell.dev]
]
