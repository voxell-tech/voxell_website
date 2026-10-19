#import "@tola/source:0.0.0": tola-meta
#import "/components/visuals.typ" as vis
#import "/data/projects.typ": projects

#tola-meta((
  title: "Roadmaps",
  summary: "What's next for each Voxell project, straight from its open GitHub issues.",
))

#let tracked = projects.filter(p => p.roadmap)

// assets/js/roadmaps.js fills each project's issues from GitHub and
// switches tabs; the kit's demo-bootstrap.js loads it through
// `data-demo-src`.
#html.elem("section", attrs: (
  class: "section pt-16",
  data-demo-src: "/js/roadmaps.js",
))[
  #vis.heading(
    [Roadmaps],
    [What's Next],
    body: [Straight from each project's open issues. Pick one up.],
  )

  #html.elem("nav", attrs: (class: "roadmap-tabs", aria-label: "Projects"))[
    #for p in tracked {
      html.a(class: "roadmap-tab", href: "#" + p.id)[
        #p.title
        #html.elem("span", attrs: (
          class: "roadmap-tab-count",
          data-issue-count: p.id,
        ))[]
      ]
    }
  ]

  #for p in tracked {
    html.elem("div", attrs: (
      id: p.id,
      class: "roadmap-page",
    ))[
      #html.div(
        class: "flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-8",
      )[
        #html.div[
          #html.h2(class: "text-3xl font-black tracking-tight mb-1")[#p.title]
          #html.p(class: "text-muted")[#p.blurb]
        ]
        #html.a(
          class: "hero-button text-sm",
          href: "https://github.com/" + p.repo + "/issues",
          ..vis.external,
        )[All Issues on GitHub ↗]
      ]
      #html.elem("div", attrs: (
        class: "issues-grid",
        data-repo: p.id,
      ))[]
    ]
  }
]
