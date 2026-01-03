#let article(
  title: "",
  authors: (),
  date: none,
  doc-brand: "personal",  // Cambiado
  body
) = {
  
  let author_str = if type(authors) == array { 
    authors.map(a => {
      if type(a) == dictionary { a.name } else { str(a) }
    }).join(", ") 
  } else { 
    str(authors) 
  }

  // Configuración por marca (usando doc-brand)
  let (primary, secondary, institution, faculty, logo) = if doc-brand == "uc" {
    (
      rgb("#0076C0"),
      rgb("#FFD100"),
      "Pontificia Universidad Católica de Chile",
      "Facultad de Economía y Administración",
      "templates/UC COLOR-01.png"
    )
  } else {
    (
      rgb("#0A2846"),
      rgb("#E5E5E5"),
      "AgSt4 Lab",
      "Portafolio Personal",
      "templates/logo.png"
    )
  }

  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 2.5cm),
    header: [
      #grid(
        columns: (1fr, auto),
        align: left + horizon,
        [
          #text(fill: primary, weight: "bold", size: 10pt)[#institution] \
          #text(fill: gray, size: 9pt, style: "italic")[#faculty]
        ],
        image(logo, height: 1.5cm, fit: "contain")
      )
      #v(0.2cm)
      #line(length: 100%, stroke: 1.5pt + primary)
    ],
    footer: align(center)[
      #text(size: 8pt, fill: gray)[
        #title | #author_str | Pág. #counter(page).display()
      ]
    ]
  )

  set text(font: "New Computer Modern", size: 11pt, lang: "es")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")

  show heading: it => [
    #v(0.5em)
    #text(fill: primary)[#it]
    #v(0.2em)
  ]
  
  show link: it => text(fill: primary, it)

  align(center)[
    #text(size: 22pt, weight: "bold", fill: primary)[#title] \
    #v(0.5em)
    #text(size: 12pt, style: "italic")[#author_str] \
    #if date != none [
      #v(0.2em)
      #text(size: 10pt, fill: gray)[#date]
    ]
  ]
  
  v(1.5cm)
  body
}