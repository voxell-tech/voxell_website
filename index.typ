#import "monokai_pro.typ": *

#set document(
  title: [Voxell],
)

#show link: it => html.elem("span", attrs: (style: "padding: 4pt"))[#it]

#html.elem("body", attrs: (
  style: "display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 0;
    margin: 0;
    background-color: "
    + base0.to-hex()
    + "; color: "
    + base7.to-hex(),
))[
  #html.elem("div", attrs: (
    style: "padding: 20pt; text-align: center; font-size: 18pt",
  ))[
    #link("./")[#image(
      "assets/icons/voxell.svg",
      height: 60pt,
    )]
    = Voxell

    Building the next generation of open-source ecosystem for makers.

    #link("https://github.com/voxell-tech")[#image(
      "assets/icons/github.svg",
      height: 20pt,
    )]
    #link("https://nixon-voxell.itch.io")[#image(
      "assets/icons/itchio.svg",
      height: 20pt,
    )]
    #link("https://youtube.com/@voxelltech")[#image(
      "assets/icons/youtube.svg",
      height: 20pt,
    )]
    #link("https://www.linkedin.com/company/voxelltech")[#image(
      "assets/icons/linkedin.svg",
      height: 20pt,
    )]
    #link("mailto:voxell.technologies@gmail.com")[#image(
      "assets/icons/mail.svg",
      height: 20pt,
    )]
  ]
]
