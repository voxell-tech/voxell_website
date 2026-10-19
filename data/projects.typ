// Voxell's projects, in the order the site shows them. The home
// page's bento grid, the projects page and the roadmaps read this.
//
// `image` is under assets/images/projects/, cropped to its tile from
// `focus` (a CSS object-position, "top" when unset). `stars` is a
// snapshot from GitHub, shown until assets/js/stars.js fetches live
// counts.
// `roadmap` puts the project on /roadmaps/.

#let projects = (
  (
    id: "motiongfx",
    title: "MotionGfx",
    repo: "voxell-tech/motiongfx",
    site: "https://motiongfx.voxell.dev",
    blurb: "Motion graphics in plain Rust, on any renderer.",
    tags: ("Rust", "Animation"),
    image: none,
    stars: 408,
    roadmap: true,
  ),
  (
    id: "fynix",
    title: "Fynix",
    repo: "voxell-tech/fynix",
    site: "https://fynix.voxell.dev",
    blurb: "A reactive view tree, styled like a Typst document.",
    tags: ("Rust", "UI"),
    image: "fynix.webp",
    // The gallery's content sits in its top-left corner.
    focus: "left top",
    stars: 18,
    roadmap: true,
  ),
  (
    id: "velyst",
    title: "Velyst",
    repo: "voxell-tech/velyst",
    site: none,
    blurb: "Interactive Typst content in Bevy, drawn with Vello.",
    tags: ("Rust", "Bevy", "Typst"),
    image: "velyst.webp",
    stars: 273,
    roadmap: true,
  ),
  (
    id: "moxie",
    title: "Moxie",
    repo: "voxell-tech/moxie",
    site: none,
    blurb: "LEGO for animation: a visual editor for MotionGfx.",
    tags: ("Rust", "Bevy", "Editor"),
    image: "moxie.webp",
    stars: 18,
    roadmap: false,
  ),
  (
    id: "bevy_motion_matching",
    title: "Motion Matching",
    repo: "voxell-tech/bevy_motion_matching",
    site: none,
    blurb: "Characters pick the next pose by matching trajectory, with no state machine.",
    tags: ("Rust", "Bevy", "Animation"),
    image: "motion-matching.webp",
    stars: 61,
    roadmap: false,
  ),
  (
    id: "xad",
    title: "Xad",
    repo: "voxell-tech/xad",
    site: none,
    blurb: "An implicit precision modeling engine.",
    tags: ("Rust", "CAD"),
    image: "xad.webp",
    focus: "center",
    stars: 11,
    roadmap: true,
  ),
  (
    id: "cornix",
    title: "Cornix",
    repo: "voxell-tech/cornix",
    site: none,
    blurb: "Matter over Thread, with Bevy ECS.",
    tags: ("Rust", "IoT"),
    image: none,
    stars: 1,
    roadmap: false,
  ),
)

// Small crates the projects above are built on.
#let foundations = (
  (
    id: "field_path",
    repo: "nixonyh/field_path",
    blurb: "Type-safe, no-std field access and reflection.",
  ),
  (
    id: "rectree",
    repo: "voxell-tech/rectree",
    blurb: "User interfaces as a tree of rectangles.",
  ),
  (
    id: "sparse_map",
    repo: "nixonyh/sparse_map",
    blurb: "A sparse map with stable generational keys.",
  ),
  (
    id: "typeslot",
    repo: "nixonyh/typeslot",
    blurb: "Static slot indices for types, grouped by a marker.",
  ),
)
