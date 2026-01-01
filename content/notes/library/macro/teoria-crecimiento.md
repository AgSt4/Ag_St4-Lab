---
title: "Teoría del Crecimiento"
description: "Crecimiento Económico en Economía Cerrada."
date: 2025-12-29
author: "Agustín Sandoval Tapia"
categories: [Macroeconomía, Economía del Crecimiento]

# --- VARIABLES PARA TUS PLANTILLAS ---
# Definimos aquí los datos que usarán tus archivos .tex
include-before-body:
  text: |
    \newcommand{\myCourse}{EAE2210: Macroeconomía 1 (Economía Real Cerrada)}
    \newcommand{\mySemester}{Primer Semestre 2026}
    \newcommand{\myEmail}{a.sandovaltapia@uc.cl}

format:
  # 1. SALIDA WEB (HTML)
  html: 
    theme: cosmo
    toc: true
  
  # 2. SALIDA DOCUMENTO (Paper/Apunte)
  pdf:
    output-file: "apunte_solow.pdf" # Nombre específico para que no sobrescriba al otro
    include-in-header: templates/notes_style.tex
    keep-tex: true
    pdf-engine: xelatex
    geometry:
      - top=0.85in
      - bottom=1in
      - left=0.7in
      - right=0.7in
  
  # 3. SALIDA PRESENTACIÓN (Slides)
  beamer:
    output-file: "slides_solow.pdf" # Nombre específico
    include-in-header: templates/slides_style.tex
    aspectratio: 169
    theme: metropolis
    classoption: "allowframebreaks"
    latex-clean: true # Limpia archivos temporales basura
---

\maketitle

# Introducción al Modelo de Solow

Notas sobre el modelo de Solow. Necesito seguir probando algunas otras configuraciones.

## Supuestos Fundamentales

Si sigo escribiendo mis notas en este lugar, pasará lo siguiente:

1.  **En la Web:** Se verá como un post de blog normal, scrolleable.
2.  **En el Apunte:** Se verá como un documento A4 formal con tu encabezado UC.
3.  **En las Slides:** Cada título `##` creará una diapositiva nueva.

---

## La Función de Producción

$$ Y_t = F(K_t, A_t L_t) $$

\begin{respuesta}
    Este cuadro de respuesta se renderiza en los 3 formatos (en HTML será un borde simple, en PDF y Beamer tendrá tus colores definidos).
\end{respuesta}