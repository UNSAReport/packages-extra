# @ing-electrica/tif-theming

Theme variables, typography, geometry, paragraph spacing, heading sizes, and table styling for UNSA Electrical Engineering TIF reports.

## Overview

This package isolates all aesthetic and structural sizing tokens used by `@ing-electrica/tif`. It exposes pure `#let` bindings with zero logic or layout functions, making global theme customization clean and modular.

## Included Tokens

- **Typography**: `font-family`, `font-size`, `font-lang`, `font-hyphenate`
- **Geometry & Margins**: `page-paper`, `cover-margin`, `body-margin` (3.0 cm left margin for binding), `page-numbering`, `page-number-align`
- **Paragraph Spacing**: `par-justify`, `par-first-line-indent`, `par-spacing`, `par-leading`, `cover-par-leading`
- **Headings & Title**: `heading-font-size-l1`, `heading-font-size-l2`, `heading-font-size-l3`, `heading-font-size-l4`, `heading-font-size`, `heading-weight`, `heading-space-above`, `heading-space-below`, `title-text-size`, `title-weight`, `title-space-below`
- **Indentation Engine**: `indent-width`, `num-gutter`
- **Tables & Figures**: `table-header-fill`, `table-cell-stroke`, `table-text-size`, `table-header-weight`
- **Cover Page Styling**: `cover-logo-width`, `cover-metadata-align`, `cover-metadata-left-inset`, `cover-author-cui-gutter`, `cover-motto-size`, `cover-university-size`, `cover-faculty-size`, `cover-school-size`, `cover-title-size`, `cover-team-size`, `cover-metadata-size`, `cover-location-size`, `cover-year-size`

## Usage

Consumed directly by `@ing-electrica/tif`:

```typst
#import "/components/@ing-electrica/tif-theming/lib.typ": *
```
