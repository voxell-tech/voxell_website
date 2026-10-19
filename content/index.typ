#import "@tola/source:0.0.0": tola-meta
#import "/components/visuals.typ" as vis
#import "/data/projects.typ": foundations, projects
#import "/shared/links.typ": links

#tola-meta((
  title: none,
  summary: "Voxell builds open-source Rust tools for makers: MotionGfx for motion graphics, Fynix for UI, Velyst for interactive Typst, and more.",
))

#let by-id = projects.map(p => (p.id, p)).to-dict()

// Hero: assets/js/voxels.js draws the voxel field into the canvas;
// the kit's demo-bootstrap.js loads it through `data-demo-src`.
#html.elem("section", attrs: (
  class: "hero",
  data-demo-src: "/js/voxels.js",
))[
  #html.elem("canvas", attrs: (
    class: "voxel-field",
    aria-hidden: "true",
  ))[]
  #html.div(class: "hero-scrim")[]
  #html.div(class: "hero-content")[
    #html.elem("img", attrs: (
      src: "/icons/voxell.svg",
      alt: "",
      class: "h-16 sm:h-20 w-auto mb-6 drop-shadow-xl",
    ))
    #html.h1(class: "hero-title")[Voxell]
    #html.p(class: "text-subtle text-lg sm:text-2xl max-w-2xl mb-8")[
      Building tools to solve #html.span(class: "text-text font-semibold")[real], #html.span(class: "text-text font-semibold")[challenging] problems.
    ]
    #html.div(class: "flex flex-wrap justify-center gap-3 mb-8", {
      html.a(class: "hero-button hero-button-primary", href: "#projects")[
        See What We Build ↓
      ]
      html.a(
        class: "hero-button",
        href: links.discord,
        ..vis.external,
      )[Join the Discord ↗]
    })
    #html.p(class: "text-subtle text-sm")[
      #html.span(class: "text-yellow")[★]
      #html.elem("span", attrs: (
        class: "font-semibold text-text",
        data-stars-total: "",
      ))[817]
      stars across
      #html.elem("span", attrs: (
        class: "font-semibold text-text",
        data-repo-count: "",
      ))[20]
      open-source repos
    ]
  ]
]

// Projects, picture first.
#html.elem("section", attrs: (
  id: "projects",
  class: "section scroll-mt-20",
))[
  #vis.heading(
    [Projects],
    [What We're Building],
    body: [Every one of these is free and open source.],
  )
  // Built in code, not markup: whitespace between markup lines
  // becomes elements, and each would take a cell of the grid.
  #html.div(class: "bento", {
    vis.tile(by-id.motiongfx, size: "md:col-span-7")
    vis.tile(by-id.fynix, size: "md:col-span-5")
    vis.tile(by-id.velyst, size: "md:col-span-5")
    vis.tile(by-id.moxie, size: "md:col-span-7")
    vis.tile(by-id.bevy_motion_matching, size: "md:col-span-6")
    vis.tile(by-id.xad, size: "md:col-span-6")
  })
  #html.div(class: "mt-8 text-center")[
    #html.a(class: "hero-button", href: "/projects/")[All Projects →]
  ]
]

// The small crates underneath.
#html.section(class: "section")[
  #vis.heading(
    [Foundations],
    [The Small Crates Underneath],
    body: [Pieces the projects above are built from, each usable on its own.],
  )
  #html.div(class: "grid gap-3 sm:grid-cols-2")[
    #for c in foundations { vis.crate-chip(c) }
  ]
]

// Community.
#html.section(class: "section")[
  #html.div(class: "community")[
    #html.div(class: "community-glow")[]
    #html.div(class: "relative")[
      #html.p(class: "section-label")[Community]
      #html.h2(class: "text-4xl sm:text-5xl font-black tracking-tight mb-4")[
        Build It With Us
      ]
      #html.p(class: "text-subtle text-lg max-w-xl mx-auto mb-8")[
        Pick an issue from the roadmaps, or come say hi on Discord.
        Donations on Open Collective keep the work going.
      ]
      #html.div(class: "flex flex-wrap justify-center gap-3", {
        html.a(
          class: "hero-button hero-button-primary",
          href: links.discord,
          ..vis.external,
        )[Join the Discord ↗]
        html.a(class: "hero-button", href: "/roadmaps/")[Roadmaps →]
        html.a(
          class: "hero-button",
          href: links.opencollective,
          ..vis.external,
        )[Open Collective ↗]
        html.a(
          class: "hero-button",
          href: links.blog,
          ..vis.external,
        )[Read the Blog ↗]
      })
    ]
  ]
]
