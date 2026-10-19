// What the shared site kit (shared/site/) needs to know about
// voxell.dev. The site's title, description, and origin live in
// tola.toml's [site].

#import "/shared/links.typ": links

#let project = (
  // No `repo`: the home page describes Voxell as an organization.
  same-as: (
    links.github,
    links.youtube,
    links.linkedin,
    links.reddit,
    links.instagram,
  ),
  og-image: "/images/og.png?v=1",
  // The Voxell logo.
  brand: none,
  nav: parts => (
    (label: [Projects], href: "/projects/", match: "/projects"),
    (label: [Roadmaps], href: "/roadmaps/", match: "/roadmaps"),
    (label: [Blog ↗], href: links.blog, external: true),
    (label: parts.discord-badge, href: links.discord, external: true),
    (
      label: parts.donate-button,
      href: links.opencollective,
      external: true,
    ),
  ),
  // Sections pad themselves, so the hero can span the window.
  main-class: "",
  chapters: (),
  scripts: ("/js/stars.js",),
)
