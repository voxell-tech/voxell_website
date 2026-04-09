#import "/templates/page.typ": page
#import "/components/ui.typ" as ui

#show: page.with(title: "Projects")

#let projects = (
  (
    name: "motiongfx",
    url: "https://github.com/voxell-tech/motiongfx",
    stars: 313,
    desc: "Backend agnostic motion graphics creation framework.",
    tags: ("Rust",),
  ),
  (
    name: "velyst",
    url: "https://github.com/voxell-tech/velyst",
    stars: 167,
    desc: "Interactive Typst content creator using Vello and Bevy.",
    tags: ("Rust", "Bevy", "Typst"),
  ),
  (
    name: "bevy_motion_matching",
    url: "https://github.com/voxell-tech/bevy_motion_matching",
    stars: 51,
    desc: "Motion matching enables characters to smoothly transition between animations without hand-crafted state machines.",
    tags: ("Rust", "Bevy"),
  ),
  (
    name: "xad",
    url: "https://github.com/voxell-tech/xad",
    stars: 8,
    desc: "A modern precision modeling software.",
    tags: ("Rust",),
  ),
  (
    name: "field_path",
    url: "https://github.com/voxell-tech/field_path",
    stars: 7,
    desc: "Type-safe, no-std field access and reflection utilities.",
    tags: ("Rust",),
  ),
  (
    name: "rectree",
    url: "https://github.com/voxell-tech/rectree",
    stars: 5,
    desc: "Representing user interfaces using a rectangle tree.",
    tags: ("Rust",),
  ),
  (
    name: "fynix",
    url: "https://github.com/voxell-tech/fynix",
    stars: 4,
    desc: "A composable, declarative UI framework.",
    tags: ("Rust",),
  ),
  (
    name: "sparse_map",
    url: "https://github.com/voxell-tech/sparse_map",
    stars: 2,
    desc: "A sparse map with stable generational keys.",
    tags: ("Rust",),
  ),
)

= Projects

#html.p(class: "text-muted mb-8")[
  Open-source tools and libraries built with Rust for game development and creative coding.
]

#html.div(class: "grid grid-cols-1 sm:grid-cols-2 gap-4")[
  #for p in projects {
    ui.project-card(p.name, p.url, p.stars, p.desc, tags: p.tags)
  }
]
