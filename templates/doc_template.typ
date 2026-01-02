// templates/doc_template.typ

#let article(
  title: "",
  author: "",
  date: "",
  brand: "uc",      // "uc" o "personal"
  logo_file: none,  // <--- NUEVO: Recibe el nombre del archivo desde el YAML
  body
) = {
  // 1. DEFINICIÓN DE COLORES
  let color_uc_blue = rgb("#0076C0")
  let color_uc_yellow = rgb("#FFD100")
  
  let color_personal_navy = rgb("#0A2846") 
  let color_personal_gray = rgb("#E5E5E5") 

  // 2. LÓGICA DE SELECCIÓN DE ESTILO
  
  // Colores según marca
  let primary_color = if brand == "personal" { color_personal_navy } else { color_uc_blue }
  let secondary_color = if brand == "personal" { color_personal_gray } else { color_uc_yellow }
  
  // Textos Institucionales
  let institution_text = if brand == "personal" { "AgSt4 Lab" } else { "Pontificia Universidad Católica de Chile" }
  let faculty_text = if brand == "personal" { "Portafolio Personal" } else { "Facultad de Economía y Administración" }

  // LOGOS (Lógica Corregida)
  // Prioridad 1: Si el YAML define 'logo_file', usamos ese.
  // Prioridad 2: Si no, usamos el logo por defecto según la marca.
  let logo_path = if logo_file != none {
      logo_file
  } else if brand == "personal" {
      "assets/logo.svg"
  } else {
      "Logo UC.png" // Default correcto para documentos UC
  }

  // 3. CONFIGURACIÓN DE PÁGINA
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 2.5cm),
    header: [
      #grid(
        columns: (1fr, auto),
        align(left + horizon)[
          #text(fill: primary_color, weight: "bold", size: 10pt)[#institution_text] \
          #text(fill: black.lighten(40%), size: 9pt, style: "italic")[#faculty_text]
        ],
        // Ajustamos la imagen con 'fit: "contain"' para que no se deforme
        image(logo_path, height: 1.5cm, fit: "contain")
      )
      #v(0.2cm)
      #line(length: 100%, stroke: 1.5pt + primary_color)
    ],
    footer: [
      #align(center)[
        #text(size: 8pt, fill: gray)[
           #title | #author | Pág. #counter(page).display()
        ]
      ]
    ]
  )

  // 4. ESTILOS DE TEXTO
  set text(font: "Lato", size: 11pt, lang: "es")
  set par(justify: true)
  set heading(numbering: "1.1")

  // Los títulos se colorean automáticamente
  show heading: it => [
    #v(0.5em)
    #text(fill: primary_color)[#it]
    #v(0.2em)
  ]

  // 5. TÍTULO DEL DOCUMENTO (Portada)
  align(center)[
    #text(size: 22pt, weight: "bold", fill: primary_color)[#title] \
    #v(0.5em)
    #text(size: 12pt, style: "italic")[#author] \
    #if date != "" [
      #v(0.2em)
      #text(size: 10pt, fill: gray)[#date]
    ]
  ]
  
  v(1cm)
  
  // 6. RENDERIZADO DEL CUERPO
  body
}