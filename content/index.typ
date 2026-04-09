#import "/templates/page.typ": page
#import "/components/ui.typ" as ui
#import "/components/layout.typ" as layout

#show: page.with(title: none)

// Hero
#html.div(class: "text-center py-20 px-5")[
  #html.a(class: "inline-block mb-1", href: "/")[
    #image("/assets/icons/voxell.svg", height: 60pt)
  ]

  #html.h1(class: "text-4xl font-bold mb-2")[Voxell]

  #html.p(class: "text-muted text-lg mb-8")[
    Building the next generation of open-source ecosystem for makers.
  ]

  #html.div(class: "flex flex-wrap justify-center gap-4")[
    #html.a(
      class: "opacity-75 hover:opacity-100 transition-opacity",
      href: "https://github.com/voxell-tech",
      target: "_blank",
      rel: ("noopener", "noreferrer"),
    )[#image("/assets/icons/github.svg", height: 20pt)]

    #html.a(
      class: "opacity-75 hover:opacity-100 transition-opacity",
      href: "https://youtube.com/@voxelltech",
      target: "_blank",
      rel: ("noopener", "noreferrer"),
    )[#image("/assets/icons/youtube.svg", height: 20pt)]

    #html.a(
      class: "opacity-75 hover:opacity-100 transition-opacity",
      href: "https://www.linkedin.com/company/voxelltech",
      target: "_blank",
      rel: ("noopener", "noreferrer"),
    )[#image("/assets/icons/linkedin.svg", height: 20pt)]

    #html.a(
      class: "opacity-75 hover:opacity-100 transition-opacity",
      href: "mailto:voxell.technologies@gmail.com",
      target: "_blank",
      rel: ("noopener", "noreferrer"),
    )[#image("/assets/icons/mail.svg", height: 20pt)]

    #html.a(
      class: "opacity-75 hover:opacity-100 transition-opacity",
      href: "https://nixon-voxell.itch.io",
      target: "_blank",
      rel: ("noopener", "noreferrer"),
    )[#image("/assets/icons/itchio.svg", height: 20pt)]
  ]
]

#layout.hr

// Featured Projects
#html.section(class: "py-12")[
  #html.h2(class: "text-2xl font-bold mb-8 text-center")[Featured Projects]
  #html.div(class: "grid grid-cols-1 sm:grid-cols-2 gap-4")[
    #for p in (
      (
        "motiongfx",
        "https://github.com/voxell-tech/motiongfx",
        313,
        "Backend agnostic motion graphics creation framework.",
        ("Rust",),
      ),
      (
        "velyst",
        "https://github.com/voxell-tech/velyst",
        167,
        "Interactive Typst content creator using Vello and Bevy.",
        ("Rust", "Bevy", "Typst"),
      ),
    ) { ui.project-card(p.at(0), p.at(1), p.at(2), p.at(3), tags: p.at(4)) }
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
