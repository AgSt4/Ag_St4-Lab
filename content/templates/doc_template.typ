#let article(
  title: "",
  authors: (),
  date: none,
  logo_file: none,
  
  // --- FIX TÉCNICO ---
  // 1. Aceptamos explícitamente doc-brand para ignorarlo sin dar error
  doc-brand: none,
  
  // 2. EL SALVAVIDAS: "..args" captura cualquier otro parámetro extra 
  // que Quarto envíe (abstract, toc, etc.) y evita que la compilación falle.
  ..args,
  
  body
) = {
  
  // --- 1. Definiciones de Estilo (AgSt4 Lab) ---
  let primary = rgb("#0A2846") // Tu Azul Oscuro
  let institution = "AgSt4 Lab"
  let subtitle = "Knowledge Vault"
  
  // Ruta por defecto
  let default_logo = "/templates/logo.png" 

  // --- 2. Procesamiento de Autores ---
  let author_str = if type(authors) == array { 
    authors.map(a => {
      if type(a) == dictionary { a.name } else { str(a) }
    }).join(", ") 
  } else { 
    str(authors) 
  }

  // --- 3. Lógica del Logo ---
  let final_logo = if logo_file != none { logo_file } else { default_logo }

  // --- 4. Configuración de Página ---
  set page(
    paper: "us-letter",
    margin: (x: 1.5cm, y: 1.75cm), 
    
    header: [
      #grid(
        columns: (1fr, auto),
        align: left + horizon,
        [
          #text(fill: primary, weight: "bold", size: 10pt)[#institution] \
          #text(fill: gray, size: 8pt, style: "italic")[#subtitle]
        ],
        if final_logo != none { image(final_logo, height: 1.0cm, fit: "contain") }
      )
      #v(0.3em)
      #line(length: 100%, stroke: 0.5pt + primary)
    ],
    
    footer: align(center)[
      #text(size: 8pt, fill: gray)[
        #title #h(1fr) #counter(page).display()
      ]
    ]
  )

  // --- 5. Tipografía Profesional ---
  set text(font: "New Computer Modern", size: 11pt, lang: "es")
  set par(justify: true, leading: 0.65em)
  
  set heading(numbering: "1.1")
  show heading: it => [
    #v(0.5em)
    #text(fill: primary, weight: "bold")[#it]
    #v(0.2em)
  ]
  
  show link: it => text(fill: primary, it)

  // --- 6. Bloque de Título Principal ---
  align(center)[
    #v(0.5cm)
    #text(size: 18pt, weight: "bold", fill: primary)[#title] \
    #v(0.5em)
    #text(size: 11pt, style: "italic")[#author_str] 
    #if date != none [
       | #text(size: 11pt, fill: gray)[#date]
    ]
    #v(0.8cm)
  ]
  
  // --- 7. Renderizar contenido ---
  body
}