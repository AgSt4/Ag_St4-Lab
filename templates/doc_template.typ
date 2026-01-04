#let article(
  title: "",
  authors: (),
  date: none,
  doc-brand: "personal",
  logo_file: none, 
  body
) = {
  
  // 1. Procesamiento de Autores
  let author_str = if type(authors) == array { 
    authors.map(a => {
      if type(a) == dictionary { a.name } else { str(a) }
    }).join(", ") 
  } else { 
    str(authors) 
  }

  // 2. Lógica de Marca (Personal vs UC)
  let (primary, secondary, institution, faculty, default_logo) = if doc-brand == "uc" {
    (
      rgb("#0076C0"), // Azul UC
      rgb("#FFD100"), // Amarillo UC
      "Pontificia Universidad Católica de Chile",
      "Facultad de Economía y Administración",
      "/templates/UC COLOR-01.png"
    )
  } else {
    (
      rgb("#0A2846"), // Tu Azul Oscuro
      rgb("#E5E5E5"), // Gris Claro
      "AgSt4 Lab",
      "Portafolio Personal",
      "/templates/logo.png"
    )
  }

  // 3. Selección de Logo (Prioriza el enviado desde el YAML si existe)
  let final_logo = if logo_file != none { logo_file } else { default_logo }

  // 4. Configuración de Página
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
        // Usamos la ruta final calculada
        image(final_logo, height: 1.5cm, fit: "contain")
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

  // 5. Configuración de Texto y Títulos
  set text(font: "New Computer Modern", size: 11pt, lang: "es")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")

  show heading: it => [
    #v(0.5em)
    #text(fill: primary)[#it]
    #v(0.2em)
  ]
  
  show link: it => text(fill: primary, it)

  // 6. Bloque de Título Principal
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
  
  // 7. Renderizar contenido
  body
}