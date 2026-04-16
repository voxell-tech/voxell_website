#import "/templates/page.typ": page
#import "/components/ui.typ" as ui
#import "/components/layout.typ" as layout

#show: page.with(title: "Roadmap")

// Forge Roadmap
#html.section(
  class: "py-12",
)[
  #html.p(class: "text-xs uppercase tracking-widest text-muted text-center mb-2")[What we're building]
  #html.h2(class: "text-2xl font-bold text-center mb-2")[Forge Roadmap]
  #html.p(class: "text-muted text-center mb-10 max-w-2xl mx-auto")[
    An end-to-end product creation platform, from concept to prototype to product.
  ]
  #html.p(
    class: "text-sm text-muted text-left max-w-2xl mx-auto",
  )[
    This roadmap is a living plan for Forge. What ships may change based on issues, feedback and the team’s capacity.
  ]

  #let milestones = (
    (
      "01",
      "Fynix — UI Framework",
      "active",
      "Q3 2026",
      "https://github.com/voxell-tech/fynix",
      "A composable, declarative UI framework powering the entire Forge ecosystem.",
      ("Software", "UI"),
    ),
    (
      "02",
      "Xad — CAD & Modeling",
      "active",
      "Q4 2026",
      "https://github.com/voxell-tech/xad",
      "Precision 2D/ 3D modeling with SDF-based approach, constraints and direct slicer integration.",
      ("Graphics", "WGPU"),
    ),
    (
      "03",
      "Xlicer — 3D Printing",
      "planned",
      "TBA",
      none,
      "High-quality slicing engine with direct CAD preview, material presets and machine profiles.",
      ("Manufacturing",),
    ),
    (
      "04",
      "Schematix — Electronics & PCB",
      "planned",
      "TBA",
      none,
      "Schematic editor and PCB layout with real-time ERC/DRC validation and integration with CAD toolchain.",
      ("Hardware", "EDA"),
    ),
    (
      "05",
      "Cornix — Embedded Development Suite",
      "planned",
      "TBA",
      none,
      "A complete firmware development environment built on Embassy, offering seamless editing, live-data debugging and optional Bevy-powered digital twin visualization.",
      ("Firmware", "Embedded"),
    ),
    (
      "06",
      "Simulation & Digital Twin",
      "planned",
      "TBA",
      none,
      "A unified cross-domain simulation environment that visualizes mechanical, electronic and firmware behaviors to predict interactions before fabrication.",
      ("Simulation", "Digital Twin"),
    ),
  )

  // Vertical Timeline
  #html.div(
    class: "relative border-l-2 border-text/10 ml-4 md:ml-8 mt-12 mb-8",
  )[
    #for m in milestones {
      let (num, title, status, date, link, desc, tags) = m

      // Dot styling
      let dot-class = if status == "done" {
        "bg-green ring-4 ring-green/10"
      } else if status == "active" {
        "bg-accent ring-4 ring-accent/20"
      } else {
        "bg-surface border-2 border-text/20"
      }

      // Status Badge styling
      let badge-class = if status == "done" {
        "text-green text-xs px-2 py-0.5 rounded-full bg-green/10 font-medium"
      } else if status == "active" { "text-accent text-xs px-2 py-0.5 rounded-full bg-accent/10 font-medium" } else {
        "text-muted text-xs px-2 py-0.5 rounded-full bg-surface border border-text/10 font-medium"
      }
      let label = if status == "done" { "Completed" } else if status == "active" { "In progress" } else { "Planned" }

      let hover-class = if link != none { " group cursor-pointer" } else { "" }
      let title-class = (
        "text-lg font-bold" + if link != none { " transition-colors group-hover:text-accent" } else { "" }
      )
      let desc-class = (
        "text-muted leading-relaxed max-w-2xl mt-2"
          + if link != none { " transition-colors group-hover:text-text" } else { "" }
      )
      let dot-hover = if link != none {
        " transition-all duration-300 group-hover:scale-125 group-hover:ring-accent/40"
      } else { "" }

      let content = html.div(class: "relative pl-6 md:pl-10 pb-12 " + hover-class)[
        #html.div(class: "absolute w-3 h-3 rounded-full -left-[7px] top-1.5 " + dot-class + dot-hover)[]

        // Header row
        #html.div(class: "flex flex-col sm:flex-row sm:items-baseline gap-2 sm:gap-4")[
          #html.div(class: "flex items-center gap-3")[
            #html.span(class: "font-mono text-sm text-muted/50")[#num]
            #html.h3(class: title-class)[#title]
          ]
          #html.div(class: "flex flex-wrap items-center gap-2 mt-1 sm:mt-0")[
            #html.span(class: badge-class)[#label]
            #html.span(class: "text-xs font-mono text-muted bg-surface/50 px-2 py-0.5 rounded")[#date]
          ]
        ]

        // Description
        #html.p(class: desc-class)[#desc]

        // Tags
        #html.div(class: "flex flex-wrap pt-3 -mb-2")[
          #for tag in tags {
            html.span(
              class: "text-[10px] uppercase tracking-wider text-muted/70 px-2 py-0.5 rounded border border-text/10 bg-text/5 font-bold mr-2 mb-2",
            )[#tag]
          }
        ]
      ]

      if link != none {
        html.a(
          href: link,
          target: "_blank",
          rel: ("noopener", "noreferrer"),
          class: "block no-underline text-inherit",
        )[#content]
      } else {
        content
      }
    }
  ]
]

#layout.hr

// Call to Action Section
#html.section(
  class: "py-12 text-center",
)[
  #html.h2(class: "text-xl font-bold mb-4")[Help us build the Forge]
  #html.p(
    class: "text-muted mb-6 max-w-lg mx-auto",
  )[
    Voxell is open-source. Whether you're a Rustacean, a UI designer or an engineer, there's a place for you to contribute.
  ]
  #html.div(
    class: "flex flex-wrap justify-center gap-4",
  )[
    #html.a(
      class: "px-4 py-2 bg-accent text-surface font-semibold rounded hover:opacity-90 transition-opacity",
      href: "https://github.com/voxell-tech",
      target: "_blank",
    )[
      Contribute on GitHub
    ]
    #html.a(
      class: "px-4 py-2 border border-text/20 text-text font-semibold rounded hover:bg-surface/50 transition-colors",
      href: "https://discord.gg/Mhnyp6VYEQ",
      target: "_blank",
    )[
      Join the Discord
    ]
  ]
]
