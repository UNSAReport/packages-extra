# @unsareport_general/solicitud-simple

Plantilla formal de solicitud simple y administrativa para trámites institucionales, académicos y generales. Diseñada para solicitudes, peticiones y trámites formales.

Incluye encabezado oficial con el lema del año, bloque de asunto y referencia alineado, sección de destinatario formal, presentación estructurada del solicitante, petitorio, anexos/adjuntos y sección de firma y huella (con soporte opcional para visto bueno o firma de autoridad receptora).

> [!NOTE]
> Todos los campos son opcionales y condicionales: si un parámetro no tiene información o se omite, no se renderiza en el documento generado (a excepción del lema oficial del año que mantiene su valor predeterminado).
> Todos los nombres de parámetros y metadatos utilizan de forma consistente la convención `kebab-case`.

## Uso

```typst
#import "/components/@unsareport_general/solicitud-simple/lib.typ": project

#show: project.with(
  lema-anio: "“Año de la Paz, el Diálogo y el Desarrollo”",
  asunto: [Presentación de solicitud y documentación sustentatoria],
  asunto-corto: "Presentación de documentación",
  referencia: [Oficio N.° 001-2026-ENTIDAD], // Opcional
  destinatario: (
    encabezado: "SEÑOR(A):",
    cargo: "Director(a) / Jefe(a) de la Dependencia",
    institucion: "[Nombre de la Institución o Dependencia]",
    atencion: "Nombres y Apellidos de la Autoridad",
    cierre: "PRESENTE.",
  ),
  solicitante: (
    nombre: "NOMBRES Y APELLIDOS DEL SOLICITANTE",
    condicion: [administrado(a) / solicitante],
    dni: "00000000",
    email: "solicitante@ejemplo.com",
    telefono: "999999999",
  ),
  fecha: auto,
  lugar: "Ciudad",
  peticion: [Por lo expuesto, solicito a usted acceder a mi petición por ser de justicia y conforme al procedimiento correspondiente.],
  firma-solicitante: (
    titulo: "Solicitante",
    nombre: "Nombres y Apellidos del Solicitante",
    detalles: (
      "DNI N.° 00000000",
      "Correo: solicitante@ejemplo.com",
    ),
    mostrar-huella: true,
    etiqueta-huella: "Huella Dactilar",
  ),
  firma-destinatario: (
    titulo: "Visto Bueno / Autoridad",
    nombre: "Nombres y Apellidos de la Autoridad",
    detalles: (
      "Director(a) / Jefe(a)",
      "[Nombre de la Entidad o Dependencia]",
    ),
    mostrar-huella: true,
    etiqueta-huella: "Huella / Sello",
  ),
  adjuntos: (
    "Documento de sustento 1",
    "Documento de sustento 2",
  ),
)

Que, por medio del presente documento, expongo ante su despacho las razones y fundamentos que motivan la presente solicitud, para lo cual adjunto los requisitos y documentación requerida conforme a las normas vigentes.

Que, los documentos presentados acreditan fehacientemente los hechos expuestos, por lo que solicito su oportuna revisión y evaluación administrativa por parte de su digno despacho.
```

## Parámetros de `solicitud-simple` / `project`

- `asunto`: Descripción del asunto formal (`ASUNTO:`). Si es `none` o vacío, no se renderiza.
- `asunto-corto`: Asunto abreviado utilizado para el token `{asunto-corto}` en el renombrado de archivo.
- `lema-anio`: Lema oficial del año entre comillas (por defecto el lema oficial vigente). Si se pasa `none` o vacío, no se renderiza.
- `referencia`: Documento de referencia u oficio precedente (`REFERENCIA:`). Si es `none` o vacío, no se renderiza.
- `destinatario`: Diccionario con la información del destinatario (o contenido/texto directo). Si es `none` o vacío, no se renderiza:
  - `encabezado`: Encabezado de cortesía (`"SEÑOR(A):"`, `"SEÑORES:"`, etc.).
  - `cargo`: Cargo formal de la autoridad o funcionario.
  - `institucion`: Entidad o dependencia a quien se dirige.
  - `atencion`: Nombre de la persona a cuya atención se remite.
  - `cierre`: Cierre de cortesía (`"PRESENTE."`).
- `solicitante`: Diccionario con la información del solicitante (o texto directo). Si es `none` o vacío, no se renderiza presentación ni firma automática:
  - `nombre`: Nombre completo del solicitante.
  - `condicion`: Condición o calidad del administrado (p. ej. solicitante, docente, estudiante, etc.).
  - `dni`: Número de DNI.
  - `documento` / `tipo-documento`: Documento de identidad alternativo (Carné de Extranjería, pasaporte, etc.).
  - `codigo` / `cui`: Código de identificación o matrícula.
  - `direccion` / `domicilio`: Dirección domiciliaria.
  - `email`: Correo electrónico.
  - `telefono`: Número de teléfono o celular.
- `presentacion`: Contenido del párrafo inicial ("Yo, ..."). Por defecto (`auto`) se construye automáticamente a partir de los datos no vacíos de `solicitante`. Si `solicitante` no tiene datos, no se renderiza.
- `peticion`: Párrafo de cierre o petitorio ("Por lo expuesto, solicito..."). Por defecto `none` (no se renderiza si no se proporciona).
- `fecha`: Fecha del documento. Admite formato `auto` (para la fecha actual), `datetime`, texto, o `none` (no se renderiza).
- `lugar`: Ciudad o localidad de emisión (por defecto `none`, no se antepone ciudad a menos que se especifique).
- `firma-solicitante`: Configuración de la sección de firma y huella del solicitante:
  - Por defecto (`auto`), se genera automáticamente a partir de `solicitante` (si cuenta con datos).
  - Puede recibir un diccionario con: `titulo`, `nombre`, `detalles`, `mostrar-huella`, `etiqueta-huella`, `imagen-firma`, `imagen-huella`.
  - Si es `none`, no se renderiza.
- `firma-destinatario`: Configuración de la sección de firma y sello de la autoridad / destinatario:
  - Por defecto `none` (no se renderiza a menos que se configure).
  - Puede recibir un diccionario o configurarse en `auto` para generarse a partir de `destinatario`.
- `adjuntos`: Lista o texto con los documentos adjuntos (`Adjuntos:` / `Anexos:`). Si es `none` o vacío, no se renderiza.
- `prefijo-adjuntos`: Prefijo de los adjuntos (por defecto `"Adjuntos:"`).
- `logo`: Imagen institucional o logotipo superior (opcional, por defecto `none`).
- `custom-variables`: Diccionario `(:)` de variables adicionales para registro en metadatos y renombrado de archivo.
- `paper`: Tamaño de página (por defecto `"a4"`).
- `margin`: Márgenes de página (por defecto `(top: 2.2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm)`).
- `font-family`: Familia tipográfica (por defecto `("Arial", "Liberation Sans", "DejaVu Sans")`).
- `font-size`: Tamaño base del texto (por defecto `10pt`).

## Configuración de Renombrado Automático

El paquete permite renombrar automáticamente el PDF compilado según el formato configurado en `unsareport.toml`:

```toml
[config-schema.filename_format]
default = "Solicitud - {asunto}.pdf"
```

Variables disponibles: `{asunto}`, `{asunto-cap}`, `{asunto-corto}`, `{solicitante}`, `{fecha}`, `{lugar}`, `{referencia}`, `{destinatario}`, `{lema-anio}`, `{peticion}`.
