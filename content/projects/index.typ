#import "@tola/source:0.0.0": tola-meta
#import "/components/visuals.typ" as vis
#import "/data/projects.typ": foundations, projects

#tola-meta((
  title: "Projects",
  summary: "Every Voxell project: MotionGfx, Fynix, Velyst, Moxie, Motion Matching, Xad, Cornix, and the small crates they're built on.",
))

#html.section(class: "section pt-16")[
  #vis.heading(
    [Projects],
    [Everything We Make],
    body: [All free and open source, mostly Rust, often Bevy.],
  )
  #html.div(class: "bento")[
    #for (i, p) in projects.enumerate() {
      // Alternate wide and narrow, so rows don't line up in a grid.
      // A last tile on its own row takes all of it.
      let wide = calc.rem(calc.quo(i, 2) + i, 2) == 0
      let alone = i == projects.len() - 1 and calc.odd(projects.len())
      vis.tile(p, size: if alone { "md:col-span-12" } else if wide {
        "md:col-span-7"
      } else { "md:col-span-5" })
    }
  ]
]

#html.section(class: "section")[
  #vis.heading(
    [Foundations],
    [The Small Crates Underneath],
    body: [Building blocks the projects above use, each usable on its own.],
  )
  #html.div(class: "grid gap-3 sm:grid-cols-2")[
    #for c in foundations { vis.crate-chip(c) }
  ]
]
