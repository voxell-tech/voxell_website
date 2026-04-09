#import "/templates/page.typ": page

#show: page.with(title: "Voxell")

#html.div(class: "flex flex-col justify-center items-center min-h-[calc(100vh-4rem)] text-center py-10 px-5")[
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
