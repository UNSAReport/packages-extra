= Metodología

El presente capítulo es la parte más importante en la evaluación del documento; aquí se redacta y se explica la metodología que se ha planteado para lograr el objetivo general. Es decir, aquí los objetivos específicos se convierten en etapas o fases que se necesita desarrollar para llegar y lograr el objetivo principal del trabajo de investigación.

Se debe describir cada método, etapa, fase o cada problema específico que aplicará el autor para el desarrollo de la investigación. Se debe exponer a detalle todos los procedimientos (etapas o secuencia de operaciones) que se seguirán para lograr la meta del objetivo principal y los objetivos específicos formulados; y que al final permitirá verificar el cumplimiento o no de la hipótesis planteada.

Se debe incluir la descripción del tipo o tipos de investigación, las técnicas y los instrumentos que serán utilizados para llevar a cabo la indagación. Es el "cómo" se realizará el estudio, los procedimientos y los pasos para responder al problema planteado [4].

== Nivel de la investigación

En esta sección se expone el tipo de investigación que se pretende realizar según el nivel o grado de profundidad con el que se realizará el estudio. En este sentido, el proyecto de trabajo o la investigación podrá ser aplicativa, exploratoria, descriptiva o explicativa. En cualquiera de los casos es recomendable justificar el nivel de investigación adoptado por el autor.

== Diseño del trabajo de investigación

Este punto del documento es el más importante, por qué: aquí se explican las estrategias, las etapas o las fases que adopta el autor para responder al problema de investigación planteado y lograr el objetivo principal.

La redacción especificando todos los procedimientos (etapas o secuencia de operaciones) que se seguirán para obtener la meta de objetivo principal son en realidad la exposición del desarrollo de los objetivos específicos, que permitirán verificar el cumplimiento o no de la hipótesis planteada.

Aquí se plantea y se describe brevemente todos los capítulos principales que conformará el trabajo de investigación. El autor puede atreverse a describir los subapartados que tendrá cada capítulo. Incluir el capítulo de conclusiones y observaciones en el diseño del trabajo de investigación.

== Análisis de datos y validación

En la presente sección se redacta describiendo las distintas operaciones a las que serán sometidos los datos que se obtengan: clasificación, registro, tabulación y codificación si fuere el caso.

En lo referente al análisis de datos, se definirán las técnicas lógicas (inducción, deducción, análisis-síntesis), o estadísticas (descriptivas o inferenciales), que serán empleadas para descifrar y dar resultados que revelan los datos recolectados.

También, se deben describir las técnicas y los instrumentos que se utilizarán para la obtención de la información, así como los procedimientos de comprobación para la validación de los resultados de la investigación.

== Cronograma de actividades o diagrama de Gantt

Se expresa mediante un gráfico en el cual se especifican todas las actividades de investigación en función del tiempo de ejecución. De preferencia, en ingenierías debe representarse mediante un diagrama de Gantt.

#figure(
  table(
    columns: (4.5fr, ..(1fr,) * 8),
    align: (left + horizon, ..(center + horizon,) * 8),
    table.header([*Actividades / Semanas*], [*S1*], [*S2*], [*S3*], [*S4*], [*S5*], [*S6*], [*S7*], [*S8*]),
    [Revisión bibliográfica y estado del arte], [X], [X], [], [], [], [], [], [],
    [Definición de objetivos y alcance], [], [X], [X], [], [], [], [], [],
    [Diseño metodológico y modelado], [], [], [X], [X], [], [], [], [],
    [Recolección y análisis de datos], [], [], [], [X], [X], [X], [], [],
    [Simulación / Pruebas experimentales], [], [], [], [], [X], [X], [X], [],
    [Validación de resultados], [], [], [], [], [], [X], [X], [X],
    [Redacción del informe final TIF], [], [], [], [], [], [], [X], [X],
  ),
  caption: [Cronograma de actividades preliminar para el desarrollo del TIF.],
)

== Matriz de Consistencia

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: (left + top, left + top, left + top, left + top),
    table.header([*Problemas*], [*Objetivos*], [*Hipótesis*], [*Variables e Indicadores*]),
    [
      *General:*\
      Formulación del problema principal de investigación.\ \
      *Específicos:*\
      1. Problema específico 1.\
      2. Problema específico 2.
    ],
    [
      *General:*\
      Meta global y respuesta al problema principal.\ \
      *Específicos:*\
      1. Objetivo específico 1.\
      2. Objetivo específico 2.
    ],
    [
      *General:*\
      Respuesta tentativa general sustentada teóricamente.\ \
      *Específicos:*\
      1. Hipótesis derivada 1.\
      2. Hipótesis derivada 2.
    ],
    [
      *Independientes:*\
      Factores causales, parámetros del sistema o algoritmos aplicados.\ \
      *Dependientes:*\
      Indicadores de precisión (MAPE, RMSE), tiempos de convergencia o estabilidad.
    ],
  ),
  caption: [Matriz de consistencia metodológica del perfil de investigación.],
)
