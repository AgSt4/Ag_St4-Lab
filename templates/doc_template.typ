// templates/doc_template.typ

#let article(
  title: "",
  authors: (), 
  date: none, 
  brand: "uc",
  logo_file: none,
  body
) = {
  
  // 1. Convertir autores (Robustez)
  let author_str = if type(authors) == array { 
    authors.join(", ") 
  } else { 
    str(authors) 
  }

  // 2. Colores
  let color_primary = if brand == "personal" { rgb("#0A2846") } else { rgb("#0076C0") }
  
  // 3. Configuración de Página
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 2.5cm),
    header: [
      #grid(
        columns: (1fr, auto),
        align(left + horizon)[
           #text(fill: color_primary, weight: "bold")[Título: #title]
        ],
        // --- AQUÍ ESTABA EL ERROR POTENCIAL ---
        // Comentamos la imagen y ponemos un cuadro gris para probar
        // image(logo_path) 
        rect(width: 2cm, height: 1cm, fill: luma(200))
      )
      #line(length: 100%, stroke: 1pt + color_primary)
    ]
  )

  // 4. FUENTE SEGURA (Vital para Windows)
  // Usamos una fuente que seguro tienes. Si esto funciona, luego instalas Lato.
  set text(font: "Arial", size: 11pt, lang: "es") 
  
  set heading(numbering: "1.1")
  show heading: it => [
    #text(fill: color_primary)[#it]
    #v(0.5em)
  ]

  // 5. TÍTULO
  align(center)[
    #text(size: 18pt, weight: "bold", fill: color_primary)[#title] \
    #v(0.5em)
    #text(style: "italic")[#author_str]
  ]
  
  v(1cm)
  
  // 6. IMPRIMIR EL CONTENIDO
  body
}