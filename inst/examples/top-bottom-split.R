library(htmltools)
library(htmllayout)
browsable(
  attachDependencies(
    tagList(
      tags$head(
        gssStyle(c(
          gssMatrix(matrix(c('x1', 'x2'))),
          gssHeight(x2 ~ .1 * x1)
        )),
        tags$style(type = 'text/css', paste(sprintf(
          '#x%s {background-color: %s;}',
          c(1, 2), c('red', 'yellow')
        ), collapse = '\n'))
      ),
      div(id = 'x1', 'top'),
      div(id = 'x2', tags$button('OK'), 'bottom')
    ),
    gssDependency()
  )
)
