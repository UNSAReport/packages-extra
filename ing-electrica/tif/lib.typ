#import "/components/@ing-electrica/tif-theming/lib.typ": *
#import "/components/@unsareport/define/lib.typ": define, get-var, get-all-vars

#let INDENT-OPEN-MARK = "__indent-open"
#let INDENT-CLOSE-MARK = "__indent-close"
#let NO-INDENT-OPEN-MARK = "__no-indent-open"
#let NO-INDENT-CLOSE-MARK = "__no-indent-close"
#let FORCE-INDENT-OPEN-MARK = "__force-indent-open"
#let FORCE-INDENT-CLOSE-MARK = "__force-indent-close"
#let FORCE-INDENT-DEFAULT-LEVEL = 1

#let heading-num-width = state("heading-num-width", 0pt)
#let tif-indent-width = state("tif-indent-width", indent-width)
#let in-table = state("in-table", false)

#let no-indent-block(body) = [#metadata(NO-INDENT-OPEN-MARK)#body#metadata(NO-INDENT-CLOSE-MARK)]
#let force-indent-block(body) = [#metadata(FORCE-INDENT-OPEN-MARK)#body#metadata(FORCE-INDENT-CLOSE-MARK)]

#let auto-indent(it) = context {
  let marks = query(selector(metadata).before(here(), inclusive: false))
  let nest-depth = marks.filter(m => m.value == INDENT-OPEN-MARK).len() - marks.filter(m => m.value == INDENT-CLOSE-MARK).len()
  let plain-depth = marks.filter(m => m.value == NO-INDENT-OPEN-MARK).len() - marks.filter(m => m.value == NO-INDENT-CLOSE-MARK).len()
  let force-depth = marks.filter(m => m.value == FORCE-INDENT-OPEN-MARK).len() - marks.filter(m => m.value == FORCE-INDENT-CLOSE-MARK).len()
  let h = query(selector(heading).before(here())).at(-1, default: none)
  let current-indent-width = tif-indent-width.get()

  if force-depth > 0 {
    if h == none {
      block(inset: (left: current-indent-width * (FORCE-INDENT-DEFAULT-LEVEL - 1)))[#it]
    } else {
      let current-num-width = heading-num-width.get()
      block(inset: (left: current-indent-width * (h.level - 1) + current-num-width))[#it]
    }
  } else if plain-depth > 0 {
    it
  } else if in-table.get() {
    it
  } else if nest-depth > 0 {
    it
  } else if h == none {
    it
  } else {
    let current-num-width = heading-num-width.get()
    block(inset: (left: current-indent-width * (h.level - 1) + current-num-width))[#it]
  }
}

#let default-logo = image("img/escudo-unsa.png", width: cover-logo-width)
#let default-banner = image("img/logo-unsa.png", width: 12cm)

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

#let tif(
  title: [TÍTULO DEL PLAN DE TRABAJO DE INVESTIGACIÓN PARA SU REVISIÓN Y REGISTRO EN LA UNIDAD DE INVESTIGACIÓN EN MAYÚSCULAS Y SIN COMILLAS],
  title_short: none,
  group: none,
  authors: (),
  authors_short: none,
  advisor: none,
  asesor: none,
  teacher: none,
  docente: none,
  course: none,
  curso: none,
  year_motto: none,
  lema_anio: none,
  motto: none,
  year: none,
  university: default-university,
  faculty: default-faculty,
  school: default-school,
  city_country: default-city-country,
  logo: auto,
  include_outline: true,
  outline_title: "ÍNDICE",
  page_number_align: page-number-align,
  metadata_align: cover-metadata-align,
  indent_width: indent-width,
  custom_variables: (:),
  doc,
) = {
  tif-indent-width.update(indent_width)
  let gen-time = datetime.today()
  let resolved-year = if year != none { str(year) } else { str(gen-time.year()) }

  let resolved-advisor = if advisor != none {
    advisor
  } else if asesor != none {
    asesor
  } else if docente != none {
    docente
  } else if teacher != none {
    teacher
  } else {
    ""
  }

  let resolved-course = if course != none {
    course
  } else if curso != none {
    curso
  } else {
    ""
  }

  let resolved-year-motto = if year_motto != none {
    year_motto
  } else if lema_anio != none {
    lema_anio
  } else if motto != none {
    motto
  } else {
    none
  }

  let resolved-group = if group != none { str(group) } else { "" }

  let resolved-authors-short = if authors_short != none {
    authors_short
  } else if resolved-group != "" {
    "Equipo" + resolved-group
  } else if authors.len() > 0 {
    authors.map(a => {
      let raw = if type(a) == dictionary { a.at("name", default: "") } else { str(a) }
      let clean = raw.split(" / ").at(0).split(",").at(0).trim()
      clean.split(" ").at(0)
    }).join("-")
  } else {
    "TIF"
  }

  let resolved-title-str = to-string(title)
  let resolved-title-short = if title_short != none {
    title_short
  } else {
    let words = resolved-title-str.split(" ")
    if words.len() > 5 {
      words.slice(0, 5).join("-")
    } else {
      resolved-title-str
    }
  }

  define("title", resolved-title-str)
  define("title_short", resolved-title-short)
  if resolved-group != "" {
    define("group", resolved-group)
  }
  define("authors", authors)
  define("authors_short", resolved-authors-short)
  if resolved-advisor != "" {
    define("advisor", resolved-advisor)
    define("docente", resolved-advisor)
  }
  if resolved-course != "" {
    define("course", resolved-course)
  }
  if resolved-year-motto != none {
    define("year_motto", resolved-year-motto)
  }
  define("year", resolved-year)
  define("university", university)
  define("faculty", faculty)
  define("school", school)
  define("city_country", city_country)

  for (name, val) in custom_variables {
    define(name, val)
  }

  set text(
    font: font-family,
    size: font-size,
    hyphenate: font-hyphenate,
    lang: font-lang,
  )

  set page(
    paper: page-paper,
    margin: cover-margin,
    header: none,
    footer: none,
  )

  let resolved-logo = if logo == auto {
    default-logo
  } else {
    logo
  }

  align(center)[
    #set par(leading: cover-par-leading)

    #if resolved-year-motto != none and resolved-year-motto != "" [
      #text(size: 10pt, weight: "bold")[#resolved-year-motto]
      #v(0.3cm)
    ]

    #text(size: 13.5pt, weight: "bold")[#upper(university)]\
    #v(0.15cm)
    #text(size: 12pt, weight: "bold")[#upper(faculty)]\
    #v(0.1cm)
    #text(size: 12.5pt, weight: "bold")[#upper(school)]\

    #v(0.6cm)
    #if resolved-logo != none {
      resolved-logo
    }
    #v(0.6cm)

    #text(size: 13pt, weight: "bold")[#title]\

    #if resolved-group != "" [
      #v(0.3cm)
      #text(size: 11pt)[Plan del trabajo de investigación formativo del equipo de trabajo N.º #resolved-group.]
    ]
  ]

  v(0.5cm)

  align(metadata_align)[
    #block(width: 100%, inset: (left: if metadata_align == left { 0.8cm } else { 0pt }))[
      #set text(size: 10.5pt)
      #set par(leading: 0.65em, spacing: 0.65em)

      #if resolved-course != "" [
        #strong[CURSO:] #h(0.3cm) #resolved-course\
      ]

      #if resolved-advisor != "" [
        #strong[DOCENTE:] #h(0.2cm) #resolved-advisor\
      ]

      #v(0.2cm)
      #strong[PRESENTADO POR:]\
      #v(0.1cm)

      #let author-list = if type(authors) == array {
        authors
      } else {
        (authors,)
      }

      #let author-cells = ()
      #let has-any-cui = false
      #for a in author-list {
        if type(a) == dictionary {
          let name = a.at("name", default: a.at("nombre", default: ""))
          let cui = a.at("cui", default: a.at("code", default: a.at("codigo", default: none)))
          author-cells.push(name)
          if cui != none {
            has-any-cui = true
            author-cells.push([\/ #h(0.15cm) #cui])
          } else {
            author-cells.push([])
          }
        } else if type(a) == str {
          if a.contains(" / ") {
            let parts = a.split(" / ")
            has-any-cui = true
            author-cells.push(parts.at(0).trim())
            author-cells.push([\/ #h(0.15cm) #parts.slice(1).join(" / ").trim()])
          } else if a.contains("/") {
            let parts = a.split("/")
            has-any-cui = true
            author-cells.push(parts.at(0).trim())
            author-cells.push([\/ #h(0.15cm) #parts.slice(1).join("/").trim()])
          } else {
            author-cells.push(a)
            author-cells.push([])
          }
        } else {
          author-cells.push(str(a))
          author-cells.push([])
        }
      }

      #if has-any-cui {
        grid(
          columns: (auto, auto),
          column-gutter: cover-author-cui-gutter,
          row-gutter: 0.65em,
          ..author-cells,
        )
      } else {
        for a in author-list [
          #if type(a) == dictionary { a.at("name", default: a.at("nombre", default: "")) } else { a }\
        ]
      }
    ]
  ]

  v(1fr)

  align(center)[
    #text(size: 11pt, weight: "bold")[#upper(city_country)]\
    #v(0.08cm)
    #text(size: 11pt, weight: "bold")[#resolved-year]
    #v(0.2cm)
  ]

  if include_outline {
    pagebreak()
    set page(
      paper: page-paper,
      margin: body-margin,
      numbering: none,
    )

    {
      set par(leading: par-leading, spacing: par-spacing)
      show heading: set text(size: heading-font-size-l1, weight: heading-weight)
      show heading: set block(above: heading-space-above, below: heading-space-below)
      outline(title: outline_title, indent: auto, depth: 3)
    }
  }

  pagebreak()
  set page(
    paper: page-paper,
    margin: body-margin,
    numbering: page-numbering,
    number-align: page_number_align,
    footer: auto,
  )
  counter(page).update(1)

  set par(
    justify: par-justify,
    leading: par-leading,
    spacing: par-spacing,
    first-line-indent: par-first-line-indent,
  )

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
      0pt
    }
    heading-num-width.update(current-num-width)

    let current-indent-width = tif-indent-width.get()
    set text(size: sz, weight: heading-weight)
    block(
      above: heading-space-above,
      below: heading-space-below,
      inset: (left: current-indent-width * (it.level - 1)),
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

  show figure.where(kind: table): set block(breakable: true)
  set table.cell(breakable: false)

  show list.item: it => {
    let kids = it.body.at("children", default: none)
    if kids != none and kids.len() > 0 and kids.at(0).func() == metadata and kids.at(0).at("value", default: "") == INDENT-OPEN-MARK {
      it
    } else {
      list.item[#metadata(INDENT-OPEN-MARK)#it.body#metadata(INDENT-CLOSE-MARK)]
    }
  }
  show enum.item: it => {
    let kids = it.body.at("children", default: none)
    if kids != none and kids.len() > 0 and kids.at(0).func() == metadata and kids.at(0).at("value", default: "") == INDENT-OPEN-MARK {
      it
    } else {
      enum.item[#metadata(INDENT-OPEN-MARK)#it.body#metadata(INDENT-CLOSE-MARK)]
    }
  }

  show par: auto-indent
  show enum: auto-indent
  show list: auto-indent
  show bibliography: auto-indent
  show figure: auto-indent
  show raw.where(block: true): auto-indent

  show figure.where(kind: table): set text(size: table-text-size)
  show table.cell.where(y: 0): set text(weight: table-header-weight)
  set table(
    fill: (col, row) => if row == 0 { table-header-fill } else { none },
    stroke: (x, y) => table-cell-stroke,
  )
  show table: it => {
    in-table.update(true)
    it
    in-table.update(false)
  }

  show figure.caption: it => [
    #it.supplement #context it.counter.display(it.numbering). #it.body
  ]

  doc
}

#let project = tif
