#import "/components/@unsareport/define/lib.typ": define, get-var, get-all-vars

#let VAR-ASUNTO = "asunto"
#let VAR-ASUNTO-CAP = "asunto-cap"
#let VAR-ASUNTO-CORTO = "asunto-corto"
#let VAR-SOLICITANTE = "solicitante"
#let VAR-FECHA = "fecha"
#let VAR-LUGAR = "lugar"
#let VAR-REFERENCIA = "referencia"
#let VAR-DESTINATARIO = "destinatario"
#let VAR-LEMA-ANIO = "lema-anio"
#let VAR-PETICION = "peticion"

#let DEFAULT-LEMA-ANIO = "“Año de la Esperanza y el Fortalecimiento de la Democracia”"
#let DEFAULT-DESTINATARIO-ENCABEZADO = "SEÑOR(A):"
#let DEFAULT-DESTINATARIO-CIERRE = "PRESENTE."
#let DEFAULT-HUELLA-ETIQUETA = "Huella Dactilar"
#let DEFAULT-HUELLA-ETIQUETA-SOLICITANTE = "Huella Dactilar"
#let DEFAULT-HUELLA-ETIQUETA-DESTINATARIO = "Huella / Sello"
#let DEFAULT-ADJUNTOS-PREFIJO = "Adjuntos:"
#let DEFAULT-PETICION = [Por lo expuesto, solicito acceder a lo solicitado por ser de justicia.]

#let to-string(it) = {
  if it == none {
    ""
  } else if type(it) == str {
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
    str(it)
  }
}

#let is-empty(val) = {
  if val == none {
    true
  } else if type(val) == str {
    val.trim() == ""
  } else if type(val) == array {
    val.len() == 0 or val.all(is-empty)
  } else if type(val) == dictionary {
    val.len() == 0 or val.values().all(is-empty)
  } else if type(val) == content {
    to-string(val).trim() == ""
  } else {
    false
  }
}

#let format-spanish-date(d, place: none) = {
  let months = (
    "enero", "febrero", "marzo", "abril", "mayo", "junio",
    "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"
  )
  let day-str = str(d.day())
  let day-padded = if day-str.len() == 1 { "0" + day-str } else { day-str }
  let month-name = months.at(d.month() - 1)
  let year-str = str(d.year())
  let date-str = day-padded + " de " + month-name + " de " + year-str

  if not is-empty(place) {
    to-string(place).trim() + ", " + date-str
  } else {
    date-str
  }
}

#let render-fingerprint-box(
  label: DEFAULT-HUELLA-ETIQUETA,
  image-content: none,
  width: 2.3cm,
  height: 3.1cm,
) = {
  align(center)[
    #box(
      width: width,
      height: height,
      stroke: 0.8pt + luma(50),
      radius: 1pt,
      clip: true,
      fill: none,
      align(center + horizon)[
        #if not is-empty(image-content) {
          if type(image-content) == str {
            image(image-content, width: 100%, height: 100%, fit: "contain")
          } else {
            image-content
          }
        }
      ]
    )
    #if not is-empty(label) {
      v(0.25em)
      text(size: 7.5pt, fill: luma(60), weight: "regular")[#label]
    }
  ]
}

#let render-signee-card(
  title-section: none,
  name: none,
  details: (),
  signature-image: none,
  show-fingerprint: true,
  fingerprint-label: DEFAULT-HUELLA-ETIQUETA,
  fingerprint-image: none,
  box-width: 2.2cm,
  box-height: 2.9cm,
  text-align: center,
) = {
  let has-name = not is-empty(name)
  let valid-details = if type(details) == array {
    details.filter(d => not is-empty(d))
  } else if not is-empty(details) {
    (details,)
  } else {
    ()
  }

  let has-content = has-name or valid-details.len() > 0 or not is-empty(title-section) or not is-empty(signature-image)

  if not has-content and not show-fingerprint {
    return none
  }

  grid(
    columns: if show-fingerprint { (1fr, auto) } else { (1fr,) },
    column-gutter: 0.45cm,
    align: (center + bottom, center + bottom),
    [
      #if not is-empty(title-section) {
        text(size: 8pt, weight: "bold", fill: luma(80))[#upper(to-string(title-section))]
        v(0.3em)
      }
      #box(
        height: 4.2em,
        width: 100%,
        align(center + bottom)[
          #if not is-empty(signature-image) {
            if type(signature-image) == str {
              image(signature-image, height: 3.8em, fit: "contain")
            } else {
              signature-image
            }
          }
        ]
      )
      #line(length: 100%, stroke: 0.8pt + black)
      #v(0.35em)
      #align(text-align)[
        #set text(hyphenate: false)
        #set par(justify: false)
        #if has-name {
          text(size: 8.5pt, weight: "bold")[#name]
          linebreak()
        }
        #for item in valid-details {
          text(size: 8pt)[#item]
          linebreak()
        }
      ]
    ],
    if show-fingerprint [
      #render-fingerprint-box(
        label: fingerprint-label,
        image-content: fingerprint-image,
        width: box-width,
        height: box-height,
      )
    ]
  )
}

#let build-solicitante-presentacion(sol) = {
  if is-empty(sol) {
    return none
  }

  if type(sol) != dictionary {
    return [Yo, *#sol*, ante usted me presento y con el debido respeto expongo:]
  }

  let nombre = sol.at("nombre", default: sol.at("name", default: none))
  if is-empty(nombre) {
    return none
  }

  let condicion = sol.at("condicion", default: sol.at("condition", default: sol.at("cargo", default: none)))
  let dni = sol.at("dni", default: none)
  let documento = sol.at("documento", default: sol.at("document-id", default: none))
  let tipo-doc = sol.at("tipo-documento", default: sol.at("document-type", default: "documento de identidad"))
  let cui = sol.at("cui", default: none)
  let codigo = sol.at("codigo", default: sol.at("code", default: none))
  let direccion = sol.at("direccion", default: sol.at("domicilio", default: sol.at("address", default: none)))
  let email = sol.at("email", default: sol.at("correo", default: none))
  let telefono = sol.at("telefono", default: sol.at("phone", default: sol.at("celular", default: none)))

  let out = [Yo, *#nombre*]
  if not is-empty(condicion) {
    out += [, #condicion]
  }
  if not is-empty(dni) {
    out += [, identificado(a) con DNI N.° #dni]
  } else if not is-empty(documento) {
    out += [, identificado(a) con #tipo-doc N.° #documento]
  }
  if not is-empty(cui) {
    out += [, con CUI N.° #cui]
  } else if not is-empty(codigo) {
    out += [, con código N.° #codigo]
  }
  if not is-empty(direccion) {
    out += [, con domicilio en #direccion]
  }
  if not is-empty(email) {
    out += [, con correo electrónico #email]
  }
  if not is-empty(telefono) {
    out += [, teléfono #telefono]
  }
  out += [, ante usted me presento y con el debido respeto expongo:]
  out
}

#let format-adjuntos(adjuntos, prefijo: DEFAULT-ADJUNTOS-PREFIJO) = {
  if is-empty(adjuntos) {
    none
  } else if type(adjuntos) == array {
    let valid = adjuntos.filter(a => not is-empty(a))
    if valid.len() == 0 {
      none
    } else {
      [*#prefijo* #valid.map(to-string).join("; ")]
    }
  } else if type(adjuntos) == str {
    [*#prefijo* #adjuntos.trim()]
  } else if type(adjuntos) == content {
    [*#prefijo* #adjuntos]
  } else {
    none
  }
}

#let build-solicitante-card-config(sol) = {
  if is-empty(sol) {
    return none
  }
  if type(sol) == dictionary {
    let nom = sol.at("nombre", default: sol.at("name", default: none))
    if is-empty(nom) {
      return none
    }
    let details = ()
    let dni-val = sol.at("dni", default: none)
    let doc-val = sol.at("documento", default: sol.at("document-id", default: none))
    let tipo-doc = sol.at("tipo-documento", default: sol.at("document-type", default: "DNI"))
    let cui-val = sol.at("cui", default: none)
    let cod-val = sol.at("codigo", default: sol.at("code", default: none))
    let email-val = sol.at("email", default: sol.at("correo", default: none))
    let tel-val = sol.at("telefono", default: sol.at("phone", default: sol.at("celular", default: none)))

    if not is-empty(dni-val) {
      details.push("DNI N.° " + str(dni-val))
    } else if not is-empty(doc-val) {
      details.push(str(tipo-doc) + " N.° " + str(doc-val))
    }
    if not is-empty(cui-val) {
      details.push("CUI N.° " + str(cui-val))
    } else if not is-empty(cod-val) {
      details.push("Código N.° " + str(cod-val))
    }
    if not is-empty(email-val) {
      details.push("Correo: " + str(email-val))
    }
    if not is-empty(tel-val) {
      details.push("Teléf.: " + str(tel-val))
    }

    (
      titulo: "Solicitante",
      nombre: nom,
      detalles: details,
      mostrar_huella: sol.at("mostrar-huella", default: sol.at("mostrar_huella", default: true)),
      etiqueta_huella: DEFAULT-HUELLA-ETIQUETA-SOLICITANTE,
      imagen_firma: sol.at("imagen-firma", default: sol.at("imagen_firma", default: none)),
      imagen_huella: sol.at("imagen-huella", default: sol.at("imagen_huella", default: none)),
    )
  } else {
    (
      titulo: "Solicitante",
      nombre: sol,
      detalles: (),
      mostrar_huella: true,
      etiqueta_huella: DEFAULT-HUELLA-ETIQUETA-SOLICITANTE,
      imagen_firma: none,
      imagen_huella: none,
    )
  }
}

#let build-destinatario-card-config(dest) = {
  if is-empty(dest) or type(dest) != dictionary {
    return none
  }
  let atencion-val = dest.at("atencion", default: dest.at("attention", default: none))
  let cargo-val = dest.at("cargo", default: dest.at("position", default: none))
  let inst-val = dest.at("institucion", default: dest.at("institution", default: none))

  if is-empty(atencion-val) and is-empty(cargo-val) {
    return none
  }

  let details = ()
  if not is-empty(cargo-val) and not is-empty(atencion-val) {
    details.push(to-string(cargo-val))
  }
  if not is-empty(inst-val) {
    details.push(to-string(inst-val))
  }

  (
    titulo: "Destinatario / Visto Bueno",
    nombre: if not is-empty(atencion-val) { atencion-val } else { cargo-val },
    detalles: details,
    mostrar_huella: true,
    etiqueta_huella: DEFAULT-HUELLA-ETIQUETA-DESTINATARIO,
    imagen_firma: none,
    imagen_huella: none,
  )
}

#let register-document-metadata(
  asunto: "",
  asunto-corto: "",
  referencia: "",
  destinatario: "",
  solicitante: "",
  fecha: "",
  lugar: "",
  lema-anio: "",
  peticion: "",
  custom-variables: (:),
) = {
  let asunto-str = to-string(asunto).trim()
  let asunto-token = if not is-empty(asunto-corto) {
    to-string(asunto-corto).trim()
  } else if asunto-str.len() > 35 {
    asunto-str.slice(0, 35).trim()
  } else if asunto-str.len() > 0 {
    asunto-str
  } else {
    "solicitud"
  }

  let asunto-cap = if asunto-token.len() > 0 {
    upper(asunto-token.slice(0, 1)) + asunto-token.slice(1)
  } else {
    ""
  }

  let dest-str = if type(destinatario) == dictionary {
    let p = ()
    let r-att = destinatario.at("atencion", default: none)
    let r-pos = destinatario.at("cargo", default: none)
    let r-inst = destinatario.at("institucion", default: none)
    if not is-empty(r-att) { p.push(to-string(r-att)) }
    if not is-empty(r-pos) { p.push(to-string(r-pos)) }
    if not is-empty(r-inst) { p.push(to-string(r-inst)) }
    p.join(" - ")
  } else {
    to-string(destinatario)
  }

  define(VAR-ASUNTO, asunto-token)
  define(VAR-ASUNTO-CAP, asunto-cap)
  define(VAR-ASUNTO-CORTO, asunto-token)
  define(VAR-SOLICITANTE, to-string(solicitante))
  define(VAR-FECHA, to-string(fecha))
  define(VAR-LUGAR, to-string(lugar))
  define(VAR-REFERENCIA, to-string(referencia))
  define(VAR-DESTINATARIO, dest-str)
  define(VAR-LEMA-ANIO, to-string(lema-anio))
  define(VAR-PETICION, to-string(peticion))

  for (name, val) in custom-variables {
    define(name, val)
  }
}

#let solicitud-simple(
  asunto: none,
  asunto-corto: none,
  lema-anio: DEFAULT-LEMA-ANIO,
  referencia: none,
  destinatario: none,
  solicitante: none,
  presentacion: auto,
  peticion: none,
  fecha: auto,
  lugar: none,
  firma-solicitante: auto,
  firma-destinatario: none,
  adjuntos: none,
  prefijo-adjuntos: DEFAULT-ADJUNTOS-PREFIJO,
  logo: none,
  custom-variables: (:),
  paper: "a4",
  margin: (top: 2.2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
  font-family: ("Arial", "Liberation Sans", "DejaVu Sans"),
  font-size: 10pt,
  leading: 0.65em,
  spacing: 0.9em,
  body,
) = {
  let asunto-str = if not is-empty(asunto) { to-string(asunto).trim() } else { "" }

  let sol-nombre = if type(solicitante) == dictionary {
    solicitante.at("nombre", default: solicitante.at("name", default: ""))
  } else if solicitante != none {
    to-string(solicitante)
  } else {
    ""
  }

  let fecha-formateada = if fecha == auto {
    format-spanish-date(datetime.today(), place: lugar)
  } else if is-empty(fecha) {
    none
  } else if type(fecha) == datetime {
    format-spanish-date(fecha, place: lugar)
  } else {
    let f-str = to-string(fecha).trim()
    if not is-empty(lugar) and not f-str.starts-with(to-string(lugar).trim()) {
      to-string(lugar).trim() + ", " + f-str
    } else {
      f-str
    }
  }

  register-document-metadata(
    asunto: asunto,
    asunto-corto: asunto-corto,
    referencia: referencia,
    destinatario: destinatario,
    solicitante: sol-nombre,
    fecha: if fecha-formateada != none { fecha-formateada } else { "" },
    lugar: if not is-empty(lugar) { to-string(lugar) } else { "" },
    lema-anio: if not is-empty(lema-anio) { to-string(lema-anio) } else { "" },
    peticion: if not is-empty(peticion) { to-string(peticion) } else { "" },
    custom-variables: custom-variables,
  )

  let doc-title = if asunto-str.len() > 0 { asunto-str } else { "Solicitud" }
  let doc-author = if not is-empty(sol-nombre) { to-string(sol-nombre) } else { () }

  set document(title: doc-title, author: doc-author)
  set page(paper: paper, margin: margin)
  set text(font: font-family, size: font-size, lang: "es")
  set par(justify: true, leading: leading, spacing: spacing)

  // 1. Logo (opcional) y Lema Oficial del Año
  if not is-empty(logo) {
    align(center)[
      #if type(logo) == str {
        image(logo, height: 2.5cm, fit: "contain")
      } else {
        logo
      }
    ]
    v(0.4em)
  }

  if not is-empty(lema-anio) {
    align(center)[
      #text(size: font-size * 0.95, weight: "bold")[#lema-anio]
    ]
    v(1.2em)
  }

  // 2. Encabezado de ASUNTO y REFERENCIA (Alineado a la derecha)
  let has-asunto = not is-empty(asunto)
  let has-referencia = not is-empty(referencia)

  if has-asunto or has-referencia {
    align(right)[
      #block(
        width: 58%,
        align(left)[
          #set par(justify: true, leading: leading * 0.95)
          #if has-asunto [
            #text(weight: "bold")[ASUNTO:] #h(0.3em) #asunto
          ]
          #if has-referencia [
            #if has-asunto { v(0.5em) }
            #text(weight: "bold")[REFERENCIA:] #h(0.3em) #referencia
          ]
        ]
      )
    ]
    v(1.4em)
  }

  // 3. Destinatario (Alineado a la izquierda)
  let dest-rendered = if is-empty(destinatario) {
    none
  } else if type(destinatario) == dictionary {
    let r-header = destinatario.at("encabezado", default: destinatario.at("header", default: none))
    let r-inst = destinatario.at("institucion", default: destinatario.at("institution", default: none))
    let r-pos = destinatario.at("cargo", default: destinatario.at("position", default: none))
    let r-att = destinatario.at("atencion", default: destinatario.at("attention", default: none))
    let r-close = destinatario.at("cierre", default: destinatario.at("closing", default: none))

    let parts = ()
    if not is-empty(r-header) {
      parts.push(text(weight: "bold")[#r-header])
    }
    if not is-empty(r-inst) {
      parts.push(text(weight: "bold")[#r-inst])
    }
    if not is-empty(r-pos) {
      parts.push([#r-pos])
    }
    if not is-empty(r-att) {
      parts.push([Atención: #r-att])
    }
    if not is-empty(r-close) {
      parts.push(text(weight: "bold")[#r-close])
    }

    if parts.len() == 0 {
      none
    } else {
      align(left)[
        #set par(leading: leading * 0.85, justify: false)
        #for (i, p) in parts.enumerate() {
          p
          if i + 1 < parts.len() {
            linebreak()
          }
        }
      ]
    }
  } else {
    align(left)[
      #set par(leading: leading * 0.85, justify: false)
      #destinatario
    ]
  }

  if dest-rendered != none {
    dest-rendered
    v(1.2em)
  }

  // 4. Párrafo de presentación (Yo, ...)
  let pres-rendered = if presentacion == auto {
    build-solicitante-presentacion(solicitante)
  } else if not is-empty(presentacion) {
    presentacion
  } else {
    none
  }

  if pres-rendered != none {
    pres-rendered
    v(0.8em)
  }

  // 5. Cuerpo de la solicitud
  body

  // 6. Petitorio final / Cierre
  if not is-empty(peticion) {
    v(0.8em)
    peticion
  }

  // 7. Lugar y Fecha
  if fecha-formateada != none and fecha-formateada.trim() != "" {
    v(1.2em)
    align(left)[#fecha-formateada]
  }

  // 8. Sección de Firmas y Huellas
  let req-sign-config = if firma-solicitante == auto {
    build-solicitante-card-config(solicitante)
  } else if type(firma-solicitante) == dictionary {
    if is-empty(firma-solicitante) {
      none
    } else {
      firma-solicitante
    }
  } else {
    none
  }

  let dest-sign-config = if firma-destinatario == auto {
    build-destinatario-card-config(destinatario)
  } else if type(firma-destinatario) == dictionary {
    if is-empty(firma-destinatario) {
      none
    } else {
      firma-destinatario
    }
  } else {
    none
  }

  if req-sign-config != none or dest-sign-config != none {
    v(1.5em)
    block(width: 100%, breakable: false)[
      #if req-sign-config != none and dest-sign-config != none {
        grid(
          columns: (1fr, 1fr),
          column-gutter: 0.8cm,
          render-signee-card(
            title-section: req-sign-config.at("titulo", default: req-sign-config.at("title", default: none)),
            name: req-sign-config.at("nombre", default: req-sign-config.at("name", default: none)),
            details: req-sign-config.at("detalles", default: req-sign-config.at("details", default: ())),
            signature-image: req-sign-config.at("imagen-firma", default: req-sign-config.at("signature-image", default: none)),
            show-fingerprint: req-sign-config.at("mostrar-huella", default: req-sign-config.at("show-fingerprint", default: true)),
            fingerprint-label: req-sign-config.at("etiqueta-huella", default: req-sign-config.at("fingerprint-label", default: DEFAULT-HUELLA-ETIQUETA-SOLICITANTE)),
            fingerprint-image: req-sign-config.at("imagen-huella", default: req-sign-config.at("fingerprint-image", default: none)),
            text-align: center,
          ),
          render-signee-card(
            title-section: dest-sign-config.at("titulo", default: dest-sign-config.at("title", default: none)),
            name: dest-sign-config.at("nombre", default: dest-sign-config.at("name", default: none)),
            details: dest-sign-config.at("detalles", default: dest-sign-config.at("details", default: ())),
            signature-image: dest-sign-config.at("imagen-firma", default: dest-sign-config.at("signature-image", default: none)),
            show-fingerprint: dest-sign-config.at("mostrar-huella", default: dest-sign-config.at("show-fingerprint", default: true)),
            fingerprint-label: dest-sign-config.at("etiqueta-huella", default: dest-sign-config.at("fingerprint-label", default: DEFAULT-HUELLA-ETIQUETA-DESTINATARIO)),
            fingerprint-image: dest-sign-config.at("imagen-huella", default: dest-sign-config.at("fingerprint-image", default: none)),
            text-align: center,
          )
        )
      } else if req-sign-config != none {
        align(center)[
          #block(width: 55%)[
            #render-signee-card(
              title-section: req-sign-config.at("titulo", default: req-sign-config.at("title", default: none)),
              name: req-sign-config.at("nombre", default: req-sign-config.at("name", default: none)),
              details: req-sign-config.at("detalles", default: req-sign-config.at("details", default: ())),
              signature-image: req-sign-config.at("imagen-firma", default: req-sign-config.at("signature-image", default: none)),
              show-fingerprint: req-sign-config.at("mostrar-huella", default: req-sign-config.at("show-fingerprint", default: true)),
              fingerprint-label: req-sign-config.at("etiqueta-huella", default: req-sign-config.at("fingerprint-label", default: DEFAULT-HUELLA-ETIQUETA-SOLICITANTE)),
              fingerprint-image: req-sign-config.at("imagen-huella", default: req-sign-config.at("fingerprint-image", default: none)),
              text-align: center,
            )
          ]
        ]
      } else {
        align(center)[
          #block(width: 55%)[
            #render-signee-card(
              title-section: dest-sign-config.at("titulo", default: dest-sign-config.at("title", default: none)),
              name: dest-sign-config.at("nombre", default: dest-sign-config.at("name", default: none)),
              details: dest-sign-config.at("detalles", default: dest-sign-config.at("details", default: ())),
              signature-image: dest-sign-config.at("imagen-firma", default: dest-sign-config.at("signature-image", default: none)),
              show-fingerprint: dest-sign-config.at("mostrar-huella", default: dest-sign-config.at("show-fingerprint", default: true)),
              fingerprint-label: dest-sign-config.at("etiqueta-huella", default: dest-sign-config.at("fingerprint-label", default: DEFAULT-HUELLA-ETIQUETA-DESTINATARIO)),
              fingerprint-image: dest-sign-config.at("imagen-huella", default: dest-sign-config.at("fingerprint-image", default: none)),
              text-align: center,
            )
          ]
        ]
      }
    ]
  }

  // 9. Anexos / Adjuntos (Al pie del documento)
  let att-content = format-adjuntos(adjuntos, prefijo: prefijo-adjuntos)
  if att-content != none {
    v(1.5em)
    align(left)[
      #text(size: font-size * 0.9)[#att-content]
    ]
  }
}

#let project = solicitud-simple
