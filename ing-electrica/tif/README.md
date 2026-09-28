# @ing-electrica/tif

Plantilla institucional y formato oficial para la elaboración del **Perfil de Trabajo de Investigación Formativa (TIF)** de la **Escuela Profesional de Ingeniería Eléctrica** de la Universidad Nacional de San Agustín de Arequipa (UNSA).

Este paquete implementa con precisión las directrices del _Manual para la elaboración, estructuración y redacción de plan del trabajo de investigación formativo (Perfil TIF)_.

## Arquitectura

El diseño sigue una estricta separación de responsabilidades en tres niveles:

1. **Valores Fijos (Fixed Constants)**:
   - Constantes institucionales y departamentales (`INSTITUTION-UNIVERSITY`, `INSTITUTION-FACULTY`, `INSTITUTION-SCHOOL`, `INSTITUTION-CITY-COUNTRY`, `DEFAULT-LOGO-PATH`).
   - Etiquetas reglamentarias de carátula (`COVER-LABEL-COURSE`, `COVER-LABEL-ADVISOR`, `COVER-LABEL-AUTHORS`, `COVER-LABEL-TEAM-PREFIX`).
   - Estructura formal obligatoria de la plantilla (índice formal automatizado de nivel 3 con título `ÍNDICE`).
   - Marcas y reglas internas del motor de sangría jerárquica contextual y tablas.
   - Nombres normalizados de metadatos exportados (`VAR-*`).

2. **Configuración Global (Global Theming)**:
   - Centralizado en `@ing-electrica/tif-theming`.
   - Variables de diseño visual: tipografía, geometría de página, margen izquierdo de encuadernación (3.0 cm), espaciado de párrafos, jerarquía de tamaños de títulos, colores y trazos de tablas.

3. **Parámetros por Informe (Per-Report Settings)**:
   - Únicamente los datos específicos de cada trabajo de investigación.
   - **Cero fallbacks**: sin cadenas de sinónimos (`docente`/`asesor`/`teacher` unificados estrictamente en `advisor`; `curso` unificado en `course`), sin adivinación especulativa de cadenas cortas (`title_short`, `authors_short`), y sin sobreescritura local de valores institucionales o de tema.

## Uso Básico

```typst
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
```

## Parámetros de `tif`

| Parámetro | Tipo | Descripción |
|---|---|---|
| `title` | `content` \| `str` | Título oficial del plan TIF en mayúsculas |
| `title_short` | `str` | Título abreviado del trabajo para nombrado de archivos |
| `year_motto` | `str` | Lema oficial del año en curso |
| `course` | `str` | Nombre de la asignatura |
| `group` | `str` \| `int` | Número identificador del equipo de trabajo |
| `advisor` | `str` | Grado y nombres completos del docente asesor |
| `authors` | `array` \| `str` | Integrantes del equipo (admite formato `"Nombre / CUI"` o `(name: "...", cui: "...")`) |
| `authors_short` | `str` | Identificador compacto de autores para nombrado de archivos |
| `year` | `str` \| `int` | Año lectivo (opcional, por defecto año calendario actual) |
| `custom_variables` | `dictionary` | Metadatos adicionales para exportar vía `@unsareport/define` |

## Renombrado Post-Build

El hook `copy-report` toma los metadatos exportados y renombra el PDF resultante según el patrón configurado en `unsareport.toml`:

```toml
[config-schema.filename_format]
default = "TIF Equipo {group} - {title_short}.pdf"
```

Tokens disponibles: `{title}`, `{title_short}`, `{year_motto}`, `{course}`, `{group}`, `{advisor}`, `{authors_short}`, `{year}`, `{university}`, `{faculty}`, `{school}`, `{city_country}`.
