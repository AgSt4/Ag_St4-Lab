// templates/doc_template.typ

#let article(
  title: "",
  authors: (), // <--- CAMBIO 1: Quarto envía una lista (array)
  date: none,  // <--- CAMBIO 2: El default debe ser none
  brand: "uc",
  logo_file: none,
  body
) = {
  
  // 1. TRANSFORMACIÓN DE DATOS (Para evitar errores)
  // Convertimos la lista de autores en un solo texto separado por comas
  let author_str = if type(authors) == array { 
    authors.join(", ") 
  } else { 
    str(authors) 
  }

  // 2. DEFINICIÓN DE COLORES
  let color_uc_blue = rgb("#0076C0")
  let color_uc_yellow = rgb("#FFD100")
  let color_personal_navy = rgb("#0A2846") 
  let color_personal_gray = rgb("#E5E5E5") 

  // 3. LÓGICA DE SELECCIÓN DE ESTILO
  let primary_color = if brand == "personal" { color_personal_navy } else { color_uc_blue }
  let secondary_color = if brand == "personal" { color_personal_gray } else { color_uc_yellow }
  
  let institution_text = if brand == "personal" { "AgSt4 Lab" } else { "Pontificia Universidad Católica de Chile" }
  let faculty_text = if brand == "personal" { "Portafolio Personal" } else { "Facultad de Economía y Administración" }

  // 4. LOGOS
  // Nota: Las rutas en Typst son relativas al archivo .qmd que se compila
  let logo_path = if logo_file != none {
      logo_file
  } else if brand == "personal" {
      "logo.png"
  } else {
      "Logo UC.png"
  }
  

  // 5. CONFIGURACIÓN DE PÁGINA
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
        // Image usa la ruta calculada arriba
        image(logo_path, height: 1.5cm, fit: "contain")
      )
      #v(0.2cm)
      #line(length: 100%, stroke: 1.5pt + primary_color)
    ],
    footer: [
      #align(center)[
        #text(size: 8pt, fill: gray)[
           #title | #author_str | Pág. #counter(page).display()
        ]
      ]
    ]
  )

  // 6. ESTILOS DE TEXTO
  // Si GitHub no tiene Lato, Typst usará una fuente default sin romper
  set text(font: "Lato", size: 11pt, lang: "es") 
  set par(justify: true)
  set heading(numbering: "1.1")

  show heading: it => [
    #v(0.5em)
    #text(fill: primary_color)[#it]
    #v(0.2em)
  ]
  
  // Estilo para enlaces (que hagan juego con la marca)
  show link: it => text(fill: primary_color, it)

  // 7. TÍTULO DEL DOCUMENTO
  align(center)[
    #text(size: 22pt, weight: "bold", fill: primary_color)[#title] \
    #v(0.5em)
    #text(size: 12pt, style: "italic")[#author_str] \
    
    // Solo mostramos la fecha si existe (distinto de none)
    #if date != none [
      #v(0.2em)
      #text(size: 10pt, fill: gray)[#date]
    ]
  ]
  
  v(1cm)
  
  // 8. CUERPO DEL CONTENIDO
  body
}

