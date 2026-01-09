#let article(
  // --- 1. Argumentos Explícitos (con defaults seguros) ---
  title: "Documento Sin Título",
  authors: none,
  date: none,

  // --- 2. EL SALVAVIDAS (Universal Sink) ---
  // Captura doc-brand, logo_file, y cualquier metadata extra de Quarto
  // para que no rompa la función por argumentos desconocidos.
  ..args,

  // --- 3. Contenido ---
  body
) = {
  
  // --- Lógica Defensiva para Autores ---
  // Convierte lo que llegue (array, dict, string o none) a algo imprimible sin romper.
  let safe_authors = if authors == none {
    []
  } else if type(authors) == array {
    authors.map(a => {
      if type(a) == dictionary { a.at("name", default: "Autor") } else { str(a) }
    }).join(", ")
  } else {
    str(authors)
  }

  // --- Configuración de Página (Sin imágenes externas) ---
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 2cm),
    header: [
      #set text(size: 9pt, fill: rgb("#0A2846"))
      #grid(
        columns: (1fr, auto),
        align(left)[*AgSt4 Lab* | Knowledge Vault], 
        align(right)[#date]
      )
      #line(length: 100%, stroke: 0.5pt + gray)
    ],
    numbering: "1"
  )

  // --- Tipografía Segura (Linux Libertine viene preinstalada en Typst) ---
  set text(font: "Linux Libertine", size: 11pt, lang: "es")
  set par(justify: true)
  
  // --- Encabezados ---
  set heading(numbering: "1.")
  show heading: it => block[
    #v(0.5em)
    #text(fill: rgb("#0A2846"), weight: "bold")[#it]
    #v(0.3em)
  ]

  // --- Bloque de Título ---
  align(center)[
    #v(1em)
    #text(size: 1.5em, weight: "bold", fill: rgb("#0A2846"))[#title] 
    #v(0.5em)
    #text(style: "italic")[#safe_authors]
    #v(1em)
  ]

  // --- Renderizado del Cuerpo ---
  body
}