#import "@tola/source:0.0.0": tola-meta

// GitHub Pages serves /404.html for any URL that doesn't exist, so
// this page is published at exactly that path.
#tola-meta((
  title: "Page Not Found",
  permalink: "/404.html",
  noindex: true,
))

#html.section(class: "section text-center py-32")[
  #html.p(class: "section-label")[404]
  #html.h1(class: "text-5xl font-black tracking-tight mb-4")[
    Page Not Found
  ]
  #html.p(class: "text-muted text-lg mb-8")[
    This page doesn't exist, or it moved.
  ]
  #html.div(class: "flex flex-wrap justify-center gap-3", {
    html.a(class: "hero-button hero-button-primary", href: "/")[Go Home]
    html.a(class: "hero-button", href: "/projects/")[See Projects]
  })
]
