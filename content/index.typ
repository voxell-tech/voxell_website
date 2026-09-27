#import "/templates/page.typ": page
#import "/components/ui.typ" as ui
#import "/components/layout.typ" as layout

#show: page.with(title: none)

// Hero
#html.div(class: "text-center py-20 px-5")[
  #html.a(class: "inline-block mb-1", href: "/")[
    #html.elem("img", attrs: (src: "/icons/voxell.svg", style: "height: 5rem; display: inline-block;"))
  ]

  #html.h1(class: "text-4xl font-bold mb-2")[Voxell]

  #html.p(class: "text-muted text-lg mb-8")[
    Building tools to solve *real*, *challenging* problems.
  ]

  #let social-icon(href, icon) = html.a(
    class: "social-link",
    href: href,
    target: "_blank",
    rel: ("noopener", "noreferrer"),
  )[#html.elem("span", attrs: (class: "social-icon", style: "--icon: url('/icons/" + icon + "'); width: 2rem; height: 2rem"))]

  #html.div(class: "flex flex-wrap justify-center gap-4")[
    #social-icon("https://opencollective.com/voxell", "opencollective.svg")
    #social-icon("https://github.com/voxell-tech", "github.svg")
    #social-icon("https://discord.gg/Mhnyp6VYEQ", "discord.svg")
    #social-icon("https://youtube.com/@voxelltech", "youtube.svg")
    #social-icon("https://www.linkedin.com/company/voxelltech", "linkedin.svg")
    #social-icon("https://reddit.com/r/voxell", "reddit.svg")
    #social-icon("https://instagram.com/voxelltech", "instagram.svg")
    #social-icon("mailto:voxell.technologies@gmail.com", "gmail.svg")
  ]
]

#layout.hr

// Featured Projects
#html.section(class: "py-12")[
  #html.h2(class: "text-2xl font-bold mb-8 text-center")[Featured Projects]
  #html.div(class: "grid grid-cols-1 sm:grid-cols-2 gap-4")[
    #for p in (
      ("motiongfx", "voxell-tech/motiongfx", "Backend agnostic motion graphics creation framework. Free and open-source forever.", ("Rust",)),
      (
        "velyst",
        "voxell-tech/velyst",
        "Interactive Typst content creator using Vello and Bevy.",
        ("Rust", "Bevy", "Typst"),
      ),
    ) { ui.project-card(p.at(0), "https://github.com/" + p.at(1), p.at(1), p.at(2)) }
  ]
  #html.div(class: "text-center mt-6")[
    #html.a(
      class: "text-accent hover:underline underline-offset-4",
      href: "/projects",
    )[
      View all projects →
    ]
  ]
]

// #layout.hr

// // About
// #html.section(class: "py-12")[
//   #html.h2(class: "text-2xl font-bold mb-4")[About]
//   #html.p(class: "text-muted leading-relaxed")[
//     Voxell is an open-source organization building tools for game developers and creative coders.
//     Our work centers on the Rust and Bevy ecosystem — from motion graphics and UI frameworks to
//     animation systems and modeling software. Everything we build is open-source and made for makers.
//   ]
// ]

// #layout.hr

// // Blog
// #html.section(class: "py-12")[
//   #html.h2(class: "text-2xl font-bold mb-4")[Blog]
//   #html.p(class: "text-muted mb-4")[
//     Thoughts on Rust, game development, creative coding, and the projects we're building.
//   ]
//   #html.a(
//     class: "text-accent hover:underline underline-offset-4",
//     href: "https://blog.voxell.dev",
//     target: "_blank",
//     rel: ("noopener", "noreferrer"),
//   )[
//     Visit blog.voxell.dev →
//   ]
// ]
