# @unsareport_ing-electrica/tif-theming

Tokens de diseño y variables de estilo para el Perfil de Trabajo de Investigación Formativa (TIF) de Ingeniería Eléctrica (UNSA). Define la tipografía, geometría de página, espaciado de párrafos, encabezados y estilos de tablas.

## Uso

```typst
#import "/components/@unsareport_ing-electrica/tif-theming/lib.typ": *

// Sobrescribir variables de estilo si es necesario
#let font-size = 11pt
```

## Variables disponibles

- **Tipografía**: `font-family`, `font-size`, `font-lang`, `font-hyphenate`.
- **Geometría de página**: `page-paper`, `cover-margin`, `body-margin`, `page-numbering`, `page-number-align`.
- **Espaciado y párrafos**: `par-justify`, `par-first-line-indent`, `par-spacing`, `par-leading`, `cover-par-leading`.
- **Encabezados y título**: `heading-font-size-l1`, `heading-font-size-l2`, `heading-font-size-l3`, `heading-font-size-l4`, `heading-font-size`, `heading-weight`, `heading-space-above`, `heading-space-below`, `title-text-size`, `title-weight`, `title-space-below`.
- **Sangría jerárquica**: `indent-width`, `num-gutter`.
- **Tablas**: `table-header-fill`, `table-cell-stroke`, `table-text-size`, `table-header-weight`.
- **Portada institucional**: `cover-logo-width`, `cover-metadata-align`, `cover-metadata-left-inset`, `cover-author-cui-gutter`, `cover-motto-size`, `cover-university-size`, `cover-faculty-size`, `cover-school-size`, `cover-title-size`, `cover-team-size`, `cover-metadata-size`, `cover-location-size`, `cover-year-size`.
