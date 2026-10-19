// Building blocks for voxell.dev's pages.
// Import: #import "/components/visuals.typ" as vis

#import "/shared/site/utils.typ": cls

// Opens in a new tab, for links that leave the site.
#let external = (target: "_blank", rel: ("noopener", "noreferrer"))

/// MotionGfx's "It's Just Code" bars, in CSS: the heights are the
/// demo's own `HEIGHTS` (js_motiongfx/src/demos/bars.rs, out of a
/// 160 baseline), rising 60 ms apart over 600 ms, as it does.
#let motion-bars = {
  let heights = (60, 110, 40, 130, 80, 150, 100, 55, 120, 70)
  html.elem("div", attrs: (class: "mgfx-bars", aria-hidden: "true"))[
    #for (i, h) in heights.enumerate() {
      html.elem("span", attrs: (
        style: "--i: " + str(i) + "; --h: " + str(calc.round(h / 160 * 100)) + "%",
      ))[]
    }
  ]
}

/// A star count that assets/js/stars.js keeps live. `stars` is the
/// snapshot shown until then.
#let stars(repo, stars) = html.span(class: "inline-flex items-center gap-1")[
  #html.span(class: "text-yellow")[★]
  #html.elem("span", attrs: (data-stars: repo))[#str(stars)]
]

/// A small rounded label.
#let chip(body) = html.span(class: "tile-chip")[#body]

/// One project as a picture-first tile. `size` is its classes in the
/// bento grid. The tile links to the project's site when it has one,
/// else its repository.
#let tile(project, size: "") = {
  let href = if project.site != none { project.site } else {
    "https://github.com/" + project.repo
  }
  html.a(
    class: cls("project-tile group", size),
    href: href,
    ..external,
  )[
    #html.div(class: "project-tile-media")[
      #if project.id == "motiongfx" {
        motion-bars
      } else if project.image != none {
        html.elem("img", attrs: (
          src: "/images/projects/" + project.image,
          alt: project.title + " screenshot",
          loading: "lazy",
          style: "object-position: " + project.at("focus", default: "top"),
        ))
      } else {
        html.div(class: "voxel-pattern")[]
      }
    ]
    #html.div(class: "project-tile-scrim")[]
    #html.div(class: "project-tile-body")[
      #html.div(class: "flex items-center gap-2 mb-1")[
        #html.h3(class: "text-2xl font-bold text-text")[#project.title]
        #html.span(class: "project-tile-arrow")[↗]
      ]
      #html.p(class: "text-subtle text-sm sm:text-base mb-3 max-w-md")[
        #project.blurb
      ]
      #html.div(class: "flex flex-wrap items-center gap-2 text-xs", {
        chip(stars(project.repo, project.stars))
        for t in project.tags { chip(t) }
        if project.site != none {
          html.span(class: "tile-chip tile-chip-accent")[Website]
        }
      })
    ]
  ]
}

/// A small crate, as a row of name and one line.
#let crate-chip(c) = html.a(
  class: "crate-chip group",
  href: "https://github.com/" + c.repo,
  ..external,
)[
  #html.span(class: "font-mono font-semibold text-text group-hover:text-accent transition-colors")[#c.id]
  #html.span(class: "text-muted text-sm")[#c.blurb]
]

/// A section's heading block: a small label above a large title,
/// with an optional line under it.
#let heading(label, title, body: none) = html.div(
  class: "mb-10 max-w-2xl",
)[
  #html.p(class: "section-label")[#label]
  #html.h2(class: "text-4xl sm:text-5xl font-black tracking-tight mb-3")[#title]
  #if body != none { html.p(class: "text-muted text-lg")[#body] }
]
