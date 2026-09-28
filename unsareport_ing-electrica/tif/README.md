# @unsareport_ing-electrica/tif

Plantilla oficial para el Perfil de Trabajo de Investigación Formativa (TIF) de la Escuela Profesional de Ingeniería Eléctrica (UNSA). Incluye portada institucional normalizada, índice formal automatizado, sangría jerárquica contextual y renombrado post-compilación.

## Uso

```typst
#import "/components/@unsareport_ing-electrica/tif/lib.typ": tif, no-indent-block, force-indent-block

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
```

## Parámetros de `tif`

- `title`: Título oficial del plan TIF en mayúsculas.
- `title_short`: Título abreviado del trabajo (utilizado para el renombrado del archivo).
- `year_motto`: Lema oficial del año en curso.
- `course`: Nombre de la asignatura.
- `group`: Número identificador del equipo de trabajo.
- `advisor`: Grado y nombres completos del docente asesor.
- `authors`: Lista con los nombres de los integrantes (admite formato `"Nombre / CUI"` o `(name: "...", cui: "...")`).
- `authors_short`: Identificador compacto de autores (utilizado para el renombrado del archivo).
- `year`: Año lectivo (por defecto: año actual).
- `custom_variables`: Diccionario con variables adicionales para el renombrado del archivo vía `@unsareport/define`.

## Funciones adicionales

- `no-indent-block(body)`: Desactiva la sangría automática en el bloque indicado.
- `force-indent-block(body)`: Fuerza la sangría automática en el bloque indicado.

## Configuración de renombrado

El paquete renombra automáticamente el PDF compilado según el formato configurado en `unsareport.toml`:

```toml
[config-schema.filename_format]
default = "TIF Equipo {group} - {title_short}.pdf"
```

Variables disponibles: `{title}`, `{title_short}`, `{year_motto}`, `{course}`, `{group}`, `{advisor}`, `{authors_short}`, `{year}`, `{university}`, `{faculty}`, `{school}`, `{city_country}`.
