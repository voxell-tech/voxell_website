#import "/templates/page.typ": page
#import "/components/ui.typ" as ui

#show: page.with(title: "Projects")

#let projects = (
  (
    name: "motiongfx",
    repo: "voxell-tech/motiongfx",
    desc: "Backend agnostic motion graphics creation framework.",
  ),
  (
    name: "velyst",
    repo: "voxell-tech/velyst",
    desc: "Interactive Typst content creator using Vello and Bevy.",
  ),
  (
    name: "bevy_motion_matching",
    repo: "voxell-tech/bevy_motion_matching",
    desc: "Motion matching enables characters to smoothly transition between animations without hand-crafted state machines.",
  ),
  (
    name: "xad",
    repo: "voxell-tech/xad",
    desc: "A modern precision modeling software.",
  ),
  (
    name: "fynix",
    repo: "voxell-tech/fynix",
    desc: "A composable, declarative UI framework.",
  ),
  (
    name: "cornix",
    repo: "voxell-tech/cornix",
    desc: "Matter over Thread + Bevy ECS.",
  ),
)

#let foundational = (
  (
    name: "field_path",
    repo: "voxell-tech/field_path",
    desc: "Type-safe, no-std field access and reflection utilities.",
  ),
  (
    name: "rectree",
    repo: "voxell-tech/rectree",
    desc: "Representing user interfaces using a rectangle tree.",
  ),
  (
    name: "sparse_map",
    repo: "voxell-tech/sparse_map",
    desc: "A sparse map with stable generational keys.",
  ),
  (
    name: "typeslot",
    repo: "voxell-tech/typeslot",
    desc: "Statically assigned slot indices for types, grouped by a marker type.",
  ),
)

= Projects

#html.div(class: "grid grid-cols-1 sm:grid-cols-2 gap-4")[
  #for p in projects {
    ui.project-card(p.name, "https://github.com/" + p.repo, p.repo, p.desc)
  }
]

== Foundational

#html.p(class: "text-muted mb-8")[
  Low-level building blocks and utilities that power the projects above.
]

#html.div(class: "grid grid-cols-1 sm:grid-cols-2 gap-4")[
  #for p in foundational {
    ui.project-card(p.name, "https://github.com/" + p.repo, p.repo, p.desc)
  }
]
