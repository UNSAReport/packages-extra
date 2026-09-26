#import "/components/@ing-electrica/tif/lib.typ": tif, no-indent-block, force-indent-block

#show: tif.with(
  title: [TÍTULO DEL PLAN DE TRABAJO DE INVESTIGACIÓN PARA SU REVISIÓN Y REGISTRO EN LA UNIDAD DE INVESTIGACIÓN],
  title_short: "TIF",
  year_motto: "“Año de la Esperanza y el Fortalecimiento de la Democracia”",
  course: "ANÁLISIS DE SISTEMAS DE POTENCIA 1",
  group: "01",
  advisor: "Mg. / Dr. Nombres y Apellidos del Asesor",
  authors: (
    "Nombres y Apellidos Completos - Integrante 1 / 20201234",
    "Nombres y Apellidos Completos - Integrante 2 / 20215678",
  ),
  authors_short: "Integrante1-Integrante2",
)

#include "sections/1-introduccion.typ"
#include "sections/2-planteamiento.typ"
#include "sections/3-marco-teorico.typ"
#include "sections/4-metodologia.typ"
#include "sections/5-referencias.typ"
