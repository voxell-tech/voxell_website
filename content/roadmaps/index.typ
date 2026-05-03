#import "/templates/page.typ": page
#import "/components/ui.typ" as ui
#import "/components/layout.typ" as layout
#import "/data/projects.typ": projects

#show: page.with(title: "Roadmaps")

// Project Navigation Bar
#html.div(
  class: "sticky top-0 z-50 bg-background/90 backdrop-blur border-b border-text/10 mb-16 pt-4",
)[
  #html.div(
    class: "flex overflow-x-auto max-w-6xl mx-auto px-4 py-4 gap-8 items-center",
  )[
    #for project in projects {
      html.a(
        href: "#" + project.id,
        class: "roadmap-tab text-sm font-bold text-muted hover:text-accent whitespace-nowrap transition-colors tracking-wide px-2 py-1 rounded hover:bg-surface/50",
      )[#project.title]
    }
  ]
]

// Project Sections
#html.section(class: "pb-24 max-w-5xl mx-auto px-4")[
  #for project in projects {
    html.elem(
      "div",
      attrs: (
        id: project.id,
        class: "roadmap-page scroll-mt-24 mb-24",
        style: "display:none",
      ),
    )[
      // Project Header Block
      #html.div(class: "mb-10")[
        #html.div(
          class: "flex flex-col sm:flex-row sm:items-baseline justify-between gap-4 mb-4",
        )[
          #html.h2(
            class: "text-3xl md:text-4xl font-extrabold text-text",
          )[#project.title]
          #html.a(
            href: project.link,
            target: "_blank",
            class: "text-sm font-mono text-text hover:text-accent underline underline-offset-4 transition-colors",
          )[Repository ->]
        ]

        #html.elem("p", attrs: (class: "text-muted text-lg leading-relaxed", "data-repo-desc": project.id))[]
      ]

      // Issues Grid (populated client-side from GitHub API)
      #html.elem(
        "div",
        attrs: (
          class: "issues-grid grid grid-cols-1 md:grid-cols-2 gap-6 mt-8",
          "data-repo": project.id,
        ),
      )[]

      #html.div(
        class: "h-px w-full bg-gradient-to-r from-text/10 via-text/5 to-transparent mt-16",
      )[]
    ]
  }
]

// // Call To Action
// #html.section(class: "py-16 px-4 max-w-4xl mx-auto")[
//   #html.div(class: "bg-surface border border-text/10 rounded-2xl p-10 md:p-16 text-center relative overflow-hidden")[
//     #html.div(
//       class: "absolute top-0 left-1/2 -translate-x-1/2 w-3/4 h-32 bg-accent/5 blur-[100px] rounded-full pointer-events-none",
//     )[]

//     #html.h2(class: "text-2xl md:text-3xl font-extrabold mb-4 text-text relative z-10")[Help us to grow Voxell]
//     #html.p(class: "text-muted mb-10 max-w-lg mx-auto leading-relaxed relative z-10")[
//       Voxell is open-source. Whether you're a Rustacean, a UI designer or an engineer, there's a place for you to contribute.
//     ]
//     #html.div(class: "flex flex-col sm:flex-row justify-center items-center gap-4 relative z-10")[
//       #html.a(
//         class: "w-full sm:w-auto px-8 py-3 bg-text text-surface font-semibold rounded-lg hover:bg-text/90 hover:-translate-y-0.5 transition-all shadow-sm",
//         href: "https://github.com/voxell-tech",
//         target: "_blank",
//       )[Contribute on GitHub]
//       #html.a(
//         class: "w-full sm:w-auto px-8 py-3 border border-text/20 text-text font-semibold rounded-lg hover:bg-background/50 hover:-translate-y-0.5 transition-all",
//         href: "https://discord.gg/Mhnyp6VYEQ",
//         target: "_blank",
//       )[Join the Discord]
//     ]
//   ]
// ]

// Tab routing script
#html.script(read("../.././assets/js/roadmap_tabs.js"))
// Syntax highlighting (Shiki + Monokai Pro)
#html.script(read("../.././assets/js/syntax.js"))
// GitHub issues fetcher
#html.script(read("../.././assets/js/roadmap_issues.js"))
