#import "/components/@unsareport_general/solicitud-simple/lib.typ": project

#show: project.with(
  lema-anio: "“Año de la Paz, el Diálogo y el Desarrollo”",
  asunto: [Presentación de solicitud y documentación sustentatoria],
  asunto-corto: "Presentación de documentación",
  referencia: [Oficio N.° 001-2026-ENTIDAD],
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
