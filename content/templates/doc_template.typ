#let article(
  // Argumentos básicos
  title: "Documento",
  authors: none,
  date: none,
  
  // Sumidero de basura (atrapa metadatos extra de Quarto para que no den error)
  ..args,
  
  // El contenido
  body
) = {
  
  // --- Procesamiento de Autores ---
  let safe_authors = if authors == none {
    ""
  } else if type(authors) == array {
    authors.map(a => {
      if type(a) == dictionary { a.at("name", default: "") } else { str(a) }
    }).join(", ")
  } else {
    str(authors)
  }

  // --- Configuración de Página ---
  set page(
    paper: "us-letter",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: "1",
    header: align(right)[
      #text(size: 8pt, fill: gray)[#title]
      #line(length: 100%, stroke: 0.5pt + gray)
    ]
  )

  // --- Tipografía y Párrafos ---
  set text(font: "Linux Libertine", size: 11pt, lang: "es")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.")

  // --- Renderizado del Título ---
  align(center)[
    #v(2em)
    #text(size: 18pt, weight: "bold")[#title]
    #v(1em)
    #if safe_authors != "" [
      #text(size: 12pt, style: "italic")[#safe_authors] \
    ]
    #if date != none [
      #v(0.5em)
      #text(size: 10pt)[#date]
    ]
    #v(2em)
  ]

  // --- Renderizado del Cuerpo (CRÍTICO) ---
  body
}