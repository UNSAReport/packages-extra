# `@ing-electrica/tif`

Plantilla institucional y formato oficial para la elaboración del **Perfil de Trabajo de Investigación Formativa (TIF)** de la **Escuela Profesional de Ingeniería Eléctrica** de la Universidad Nacional de San Agustín de Arequipa (UNSA).

Este paquete implementa con precisión las directrices del _Manual para la elaboración, estructuración y redacción de plan del trabajo de investigación formativo (Perfil TIF)_.

## Características

- **Carátula Institucional UNSA**: Escudo oficial de la universidad, membrete reglamentario de la Facultad de Ingeniería de Producción y Servicios y Escuela Profesional de Ingeniería Eléctrica, metadatos de autores, asesor, número de equipo y año.
- **Índice Formal Automatizado**: Generación automática de tabla de contenidos (`ÍNDICE`) con numeración jerárquica contextual (`1.`, `1.1`, `1.1.1`).
- **Márgenes Académicos Reglamentarios**: Margen izquierdo de 3.0 cm para empastado/encuadernación, márgenes superior, inferior y derecho de 2.5 cm.
- **Estructura Completa del Manual TIF**:
  1. *Introducción* (con guía de redacción y conectores textuales).
  2. *Planteamiento del Problema* (descripción, formulación, objetivos generales/específicos, tabla de verbos infinitivos clasificados por nivel investigativo, justificaciones e hipótesis).
  3. *Marco Teórico* (antecedentes, bases teóricas y términos básicos).
  4. *Metodología* (nivel, diseño, análisis y validación de datos, y cronograma / diagrama de Gantt).
  5. *Referencias Bibliográficas* (formato IEEE / APA).
- **Integración con UNSAReport**: Exportación automática de metadatos (`title`, `authors`, `advisor`, `group`, `year`) y soporte para hook post-build de renombrado automático (`filename_format`).

## Uso Básico

```typst
#import "/components/@ing-electrica/tif/lib.typ": tif, no-indent-block, force-indent-block

#show: tif.with(
  title: [DISEÑO Y ANÁLISIS DE ESTABILIDAD DE UN SISTEMA ELÉCTRICO DE POTENCIA],
  title_short: "Estabilidad-SEP",
  group: "01",
  authors: (
    "Nombres y Apellidos del Estudiante 1",
    "Nombres y Apellidos del Estudiante 2",
  ),
  advisor: "Dr. Ing. Asesor del Proyecto",
  year: none, // Detecta automáticamente el año en curso
)

#include "sections/1-introduccion.typ"
#include "sections/2-planteamiento.typ"
#include "sections/3-marco-teorico.typ"
#include "sections/4-metodologia.typ"
#include "sections/5-referencias.typ"
```

## Parámetros de Configuración

| Parámetro | Tipo | Por defecto | Descripción |
|---|---|---|---|
| `title` | `content` \| `str` | Requerido | Título oficial del plan TIF en mayúsculas |
| `title_short` | `str` | `none` | Título abreviado para nombres de archivo |
| `group` | `str` \| `int` | `"01"` | Número de equipo de trabajo |
| `authors` | `array` \| `str` | `()` | Lista completa de integrantes del equipo |
| `authors_short` | `str` | `none` | Cadena corta de autores para renombrado |
| `advisor` | `str` | `"xxxxxxxxxxxxxxxx."` | Nombre y grado académico del docente asesor |
| `year` | `str` \| `int` | `none` | Año de presentación (por defecto año actual) |
| `university` | `str` | `"UNIVERSIDAD NACIONAL DE SAN AGUSTÍN"` | Nombre institucional |
| `faculty` | `str` | `"FACULTAD DE INGENIERÍA DE PRODUCCIÓN Y SERVICIOS"` | Facultad |
| `school` | `str` | `"ESCUELA PROFESIONAL DE INGENIERÍA ELÉCTRICA"` | Escuela profesional |
| `city_country` | `str` | `"AREQUIPA, PERÚ"` | Lugar institucional |
| `include_outline` | `bool` | `true` | Incluye página de índice automatizado |
| `outline_title` | `str` \| `content` | `"ÍNDICE"` | Título de la tabla de contenidos |
