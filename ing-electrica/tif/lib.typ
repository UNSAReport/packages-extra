#import "/components/@ing-electrica/tif-theming/lib.typ": *
#import "/components/@unsareport/define/lib.typ": define, get-var, get-all-vars
#import "/components/@unsareport/autoindent/lib.typ": (
  autoindent,
  auto-indent,
  indent-heading,
  no-indent-block,
  force-indent-block,
  heading-num-width,
  in-table,
  FORCE-INDENT-DEFAULT-LEVEL,
  INDENT-LEVEL-OFFSET,
  INITIAL-HEADING-NUM-WIDTH,
)

#let VAR-TITLE = "title"
#let VAR-TITLE-SHORT = "title_short"
#let VAR-COURSE = "course"
#let VAR-GROUP = "group"
#let VAR-ADVISOR = "advisor"
#let VAR-YEAR-MOTTO = "year_motto"
#let VAR-AUTHORS = "authors"
#let VAR-AUTHORS-SHORT = "authors_short"
#let VAR-YEAR = "year"
#let VAR-UNIVERSITY = "university"
#let VAR-FACULTY = "faculty"
#let VAR-SCHOOL = "school"
#let VAR-CITY-COUNTRY = "city_country"

#let INSTITUTION-UNIVERSITY = "UNIVERSIDAD NACIONAL DE SAN AGUSTÍN DE AREQUIPA"
#let INSTITUTION-FACULTY = "FACULTAD DE INGENIERÍA DE PRODUCCIÓN Y SERVICIOS"
#let INSTITUTION-SCHOOL = "ESCUELA PROFESIONAL DE INGENIERÍA ELÉCTRICA"
#let INSTITUTION-CITY-COUNTRY = "AREQUIPA - PERÚ"
#let DEFAULT-LOGO-PATH = "img/escudo-unsa.png"

#let COVER-LABEL-COURSE = "CURSO:"
#let COVER-LABEL-ADVISOR = "DOCENTE:"
#let COVER-LABEL-AUTHORS = "PRESENTADO POR:"
#let COVER-LABEL-TEAM-PREFIX = "Plan del trabajo de investigación formativo del equipo de trabajo N.º "
#let COVER-CUI-PREFIX = "/ "
#let COVER-CUI-DELIMITER = " / "

#let PLACEHOLDER-TITLE = "INGRESE TITULO DEL PLAN DE INVESTIGACION FORMATIVA"
#let PLACEHOLDER-TITLE-SHORT = "TIF"
#let PLACEHOLDER-YEAR-MOTTO = "INGRESE LEMA DEL AÑO"
#let PLACEHOLDER-COURSE = "INGRESE CURSO"
#let PLACEHOLDER-GROUP = "INGRESE GRUPO"
#let PLACEHOLDER-ADVISOR = "INGRESE DOCENTE ASESOR"
#let PLACEHOLDER-AUTHORS = ("INGRESE AUTORES",)
#let PLACEHOLDER-AUTHORS-SHORT = "AUTORES"

#let OUTLINE-TITLE = "ÍNDICE"
#let OUTLINE-DEPTH = 3
#let FIGURE-SPACE-BELOW = 1.5em
#let TABLE-HEADER-ROW-INDEX = 0
#let ZERO-COUNT = 0

#let COVER-MOTTO-SIZE = cover-motto-size
#let COVER-UNIVERSITY-SIZE = cover-university-size
#let COVER-FACULTY-SIZE = cover-faculty-size
#let COVER-SCHOOL-SIZE = cover-school-size
#let COVER-TITLE-SIZE = cover-title-size
#let COVER-TEAM-SIZE = cover-team-size
#let COVER-METADATA-SIZE = cover-metadata-size
#let COVER-LOCATION-SIZE = cover-location-size
#let COVER-YEAR-SIZE = cover-year-size

#let COVER-SPACING-MOTTO = 0.8fr
#let COVER-SPACING-INSTITUTION = 0.3cm
#let COVER-SPACING-TITLE-TEAM = 0.45cm
#let COVER-SPACING-AUTHORS-LIST = 0.5em
#let COVER-SPACING-LOCATION = 0.25cm
#let COVER-SPACING-BOTTOM = 0.1cm
#let COVER-CUI-SPACING = 0.15cm
#let COVER-METADATA-LEFT-INSET = cover-metadata-left-inset

#let COVER-FLEX-HEADER-TO-LOGO = 1fr
#let COVER-FLEX-LOGO-TO-TITLE = 1fr
#let COVER-FLEX-TITLE-TO-METADATA = 1.2fr
#let COVER-FLEX-METADATA-TO-FOOTER = 1.5fr

#let COVER-METADATA-LABEL-GUTTER = 0.5cm
#let COVER-METADATA-SECTION-GUTTER = 1.0em
#let COVER-METADATA-ROW-GUTTER = 0.55em
#let COVER-METADATA-PAR-LEADING = 0.65em
#let COVER-METADATA-PAR-SPACING = 0.65em
#let COVER-TITLE-PAR-LEADING = 0.75em
#let COVER-INSTITUTION-PAR-LEADING = 0.5em

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) == content {
    let f = it.fields()
    if "text" in f {
      f.text
    } else if "children" in f {
      f.children.map(to-string).join("")
    } else if "body" in f {
      to-string(f.body)
    } else if it.func() == [ ].func() {
      " "
    } else {
      ""
    }
  } else {
    ""
  }
}

#let is-empty-value(val) = {
  if val == none {
    true
  } else if type(val) == str {
    val.trim() == ""
  } else if type(val) == array {
    val.len() == ZERO-COUNT
  } else if type(val) == content {
    to-string(val).trim() == ""
  } else {
    false
  }
}

#let resolve-authors(authors) = {
  if is-empty-value(authors) {
    PLACEHOLDER-AUTHORS
  } else if type(authors) == array {
    authors
  } else if type(authors) == str {
    (authors,)
  } else {
    (to-string(authors),)
  }
}

#let parse-author-entry(entry) = {
  if type(entry) == dictionary {
    let name = entry.at("name", default: "")
    let cui = entry.at("cui", default: none)
    (name: name, cui: cui)
  } else if type(entry) == str {
    if entry.contains(COVER-CUI-DELIMITER) {
      let parts = entry.split(COVER-CUI-DELIMITER)
      (name: parts.at(0).trim(), cui: parts.slice(1).join(COVER-CUI-DELIMITER).trim())
    } else {
      (name: entry.trim(), cui: none)
    }
  } else {
    (name: to-string(entry).trim(), cui: none)
  }
}

#let apply-typography-rules(doc) = {
  set text(
    font: font-family,
    size: font-size,
    hyphenate: font-hyphenate,
    lang: font-lang,
  )
  set par(
    justify: par-justify,
    first-line-indent: par-first-line-indent,
    spacing: par-spacing,
    leading: par-leading,
  )
  doc
}

#let apply-heading-rules(doc) = {
  set heading(numbering: (..nums) => {
    let vals = nums.pos()
    let pattern = range(vals.len()).map(_ => "1").join(".") + if vals.len() == 1 { "." } else { "" }
    numbering(pattern, ..vals)
  })

  show heading: it => {
    let sz = if it.level == 1 {
      heading-font-size-l1
    } else if it.level == 2 {
      heading-font-size-l2
    } else if it.level == 3 {
      heading-font-size-l3
    } else {
      heading-font-size-l4
    }

    let num-content = if it.numbering != none {
      counter(heading).display(it.numbering)
    } else {
      none
    }
    let current-num-width = if num-content != none {
      measure(num-content).width + num-gutter
    } else {
      INITIAL-HEADING-NUM-WIDTH
    }
    heading-num-width.update(current-num-width)

    set text(size: sz, weight: heading-weight)
    block(
      above: heading-space-above,
      below: heading-space-below,
      inset: (left: indent-width * (it.level - INDENT-LEVEL-OFFSET)),
    )[
      #if num-content != none {
        grid(
          columns: (current-num-width, 1fr),
          num-content,
          if it.level == 1 { upper(it.body) } else { it.body },
        )
      } else {
        if it.level == 1 { upper(it.body) } else { it.body }
      }
    ]
  }

  doc
}

#let apply-indentation-rules(doc) = autoindent(
  doc,
  indent-width: indent-width,
  num-gutter: num-gutter,
  indent-level-offset: INDENT-LEVEL-OFFSET,
  force-level: FORCE-INDENT-DEFAULT-LEVEL,
  include-heading: false,
)

#let apply-table-figure-rules(doc) = {
  show figure: it => block(below: FIGURE-SPACE-BELOW)[#it]
  show figure.caption: it => [
    #it.supplement #context it.counter.display(it.numbering). #it.body
  ]
  show figure.where(kind: table): set block(breakable: true)
  set table.cell(breakable: false)
  show figure.where(kind: table): set text(size: table-text-size)
  show table.cell.where(y: TABLE-HEADER-ROW-INDEX): set text(weight: table-header-weight)
  set table(
    fill: (col, row) => if row == TABLE-HEADER-ROW-INDEX { table-header-fill } else { none },
    stroke: (x, y) => table-cell-stroke,
  )

  doc
}

#let register-document-metadata(
  title: "",
  title-short: "",
  year-motto: "",
  course: "",
  group: "",
  advisor: "",
  authors: (),
  authors-short: "",
  year: "",
  custom-variables: (:),
) = {
  define(VAR-TITLE, title)
  define(VAR-TITLE-SHORT, title-short)
  define(VAR-YEAR-MOTTO, year-motto)
  define(VAR-COURSE, course)
  define(VAR-GROUP, group)
  define(VAR-ADVISOR, advisor)
  define(VAR-AUTHORS, authors)
  define(VAR-AUTHORS-SHORT, authors-short)
  define(VAR-YEAR, year)
  define(VAR-UNIVERSITY, INSTITUTION-UNIVERSITY)
  define(VAR-FACULTY, INSTITUTION-FACULTY)
  define(VAR-SCHOOL, INSTITUTION-SCHOOL)
  define(VAR-CITY-COUNTRY, INSTITUTION-CITY-COUNTRY)

  for (name, val) in custom-variables {
    define(name, val)
  }
}

#let render-authors-block(authors) = {
  let parsed = authors.map(parse-author-entry)
  let has-cui = parsed.any(a => a.cui != none)

  if has-cui {
    let cells = ()
    for a in parsed {
      cells.push(a.name)
      if a.cui != none {
        cells.push([#COVER-CUI-PREFIX#h(COVER-CUI-SPACING)#a.cui])
      } else {
        cells.push([])
      }
    }
    grid(
      columns: (auto, auto),
      column-gutter: cover-author-cui-gutter,
      row-gutter: COVER-METADATA-ROW-GUTTER,
      ..cells,
    )
  } else {
    for a in parsed [
      #a.name\
    ]
  }
}

#let render-cover-page(
  year-motto: "",
  title: "",
  group: "",
  course: "",
  advisor: "",
  authors: (),
  year: "",
) = {
  if not is-empty-value(year-motto) [
    #align(center)[#text(size: COVER-MOTTO-SIZE, weight: "bold")[#year-motto]]
    #v(COVER-SPACING-MOTTO)
  ]

  align(center)[
    #set par(leading: COVER-INSTITUTION-PAR-LEADING)
    #text(size: COVER-UNIVERSITY-SIZE, weight: "bold")[#upper(INSTITUTION-UNIVERSITY)]\
    #v(COVER-SPACING-INSTITUTION)
    #text(size: COVER-FACULTY-SIZE, weight: "bold")[#upper(INSTITUTION-FACULTY)]\
    #v(COVER-SPACING-INSTITUTION)
    #text(size: COVER-SCHOOL-SIZE, weight: "bold")[#upper(INSTITUTION-SCHOOL)]
  ]

  v(COVER-FLEX-HEADER-TO-LOGO)

  align(center)[
    #image(DEFAULT-LOGO-PATH, width: cover-logo-width)
  ]

  v(COVER-FLEX-LOGO-TO-TITLE)

  align(center)[
    #set par(leading: COVER-TITLE-PAR-LEADING)
    #text(size: COVER-TITLE-SIZE, weight: "bold")[#upper(title)]
    #if not is-empty-value(group) [
      #v(COVER-SPACING-TITLE-TEAM)
      #text(size: COVER-TEAM-SIZE)[#COVER-LABEL-TEAM-PREFIX#group.]
    ]
  ]

  v(COVER-FLEX-TITLE-TO-METADATA)

  align(cover-metadata-align)[
    #block(
      width: 100%,
      inset: (left: if cover-metadata-align == left { COVER-METADATA-LEFT-INSET } else { 0pt }),
    )[
      #set text(size: COVER-METADATA-SIZE)
      #set par(leading: COVER-METADATA-PAR-LEADING, spacing: COVER-METADATA-PAR-SPACING)

      #let meta-rows = ()
      #if not is-empty-value(course) {
        meta-rows.push([#strong[#COVER-LABEL-COURSE]])
        meta-rows.push([#course])
      }
      #if not is-empty-value(advisor) {
        meta-rows.push([#strong[#COVER-LABEL-ADVISOR]])
        meta-rows.push([#advisor])
      }

      #if meta-rows.len() > ZERO-COUNT {
        grid(
          columns: (auto, 1fr),
          column-gutter: COVER-METADATA-LABEL-GUTTER,
          row-gutter: COVER-METADATA-SECTION-GUTTER,
          ..meta-rows,
        )
        v(COVER-METADATA-SECTION-GUTTER)
      }

      #strong[#COVER-LABEL-AUTHORS]
      #v(COVER-SPACING-AUTHORS-LIST)

      #render-authors-block(authors)
    ]
  ]

  v(COVER-FLEX-METADATA-TO-FOOTER)

  align(center)[
    #text(size: COVER-LOCATION-SIZE, weight: "bold")[#upper(INSTITUTION-CITY-COUNTRY)]\
    #v(COVER-SPACING-LOCATION)
    #text(size: COVER-YEAR-SIZE, weight: "bold")[#year]
    #v(COVER-SPACING-BOTTOM)
  ]
}

#let render-outline-page() = {
  pagebreak()
  set page(
    paper: page-paper,
    margin: body-margin,
    numbering: none,
  )

  set par(leading: par-leading, spacing: par-spacing)
  show heading: set text(size: heading-font-size-l1, weight: heading-weight)
  show heading: set block(above: heading-space-above, below: heading-space-below)
  outline(title: OUTLINE-TITLE, depth: OUTLINE-DEPTH, indent: auto)
}

#let tif(
  title: none,
  title_short: none,
  year_motto: none,
  course: none,
  group: none,
  advisor: none,
  authors: none,
  authors_short: none,
  year: none,
  custom_variables: (:),
  doc,
) = {
  let resolved-title = if is-empty-value(title) { PLACEHOLDER-TITLE } else { title }
  let resolved-title-short = if is-empty-value(title_short) { PLACEHOLDER-TITLE-SHORT } else { title_short }
  let resolved-year-motto = if is-empty-value(year_motto) { PLACEHOLDER-YEAR-MOTTO } else { year_motto }
  let resolved-course = if is-empty-value(course) { PLACEHOLDER-COURSE } else { course }
  let resolved-group = if is-empty-value(group) { PLACEHOLDER-GROUP } else { str(group) }
  let resolved-advisor = if is-empty-value(advisor) { PLACEHOLDER-ADVISOR } else { advisor }
  let resolved-authors = resolve-authors(authors)
  let resolved-authors-short = if is-empty-value(authors_short) { PLACEHOLDER-AUTHORS-SHORT } else { authors_short }
  let resolved-year = if is-empty-value(year) { str(datetime.today().year()) } else { str(year) }

  register-document-metadata(
    title: to-string(resolved-title),
    title-short: to-string(resolved-title-short),
    year-motto: to-string(resolved-year-motto),
    course: to-string(resolved-course),
    group: to-string(resolved-group),
    advisor: to-string(resolved-advisor),
    authors: resolved-authors,
    authors-short: to-string(resolved-authors-short),
    year: resolved-year,
    custom-variables: custom_variables,
  )

  show: apply-typography-rules
  show: apply-heading-rules
  show: apply-indentation-rules
  show: apply-table-figure-rules

  set page(
    paper: page-paper,
    margin: cover-margin,
    header: none,
    footer: none,
  )

  render-cover-page(
    year-motto: resolved-year-motto,
    title: resolved-title,
    group: resolved-group,
    course: resolved-course,
    advisor: resolved-advisor,
    authors: resolved-authors,
    year: resolved-year,
  )

  render-outline-page()

  pagebreak()
  set page(
    paper: page-paper,
    margin: body-margin,
    numbering: page-numbering,
    number-align: page-number-align,
    header: none,
    footer: auto,
  )
  counter(page).update(1)

  set par(
    justify: par-justify,
    leading: par-leading,
    spacing: par-spacing,
    first-line-indent: par-first-line-indent,
  )

  doc
}

#let project = tif
