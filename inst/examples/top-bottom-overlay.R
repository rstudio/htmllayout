library(htmltools)
library(htmllayout)
browsable(
  attachDependencies(
    tagList(
      tags$head(
        gssStyle(c(
          gssMatrix('x1'),
          gssMatrix('x2'),
          gssHeight(x2 ~ 80)
        )),
        tags$style(type = 'text/css', paste(sprintf(
          '#x%s {background-color: %s;}',
          c(1, 2), c('rgb(50, 200, 50)', 'rgba(255, 255, 0, .8)')
        ), collapse = '\n'))
      ),
      div(id = 'x1', paste(rep('top', 1000), collapse = ' '), style = 'color: white; overflow-y: auto;'),
      div(id = 'x2', tags$button('Bottom'))
    ),
    gssDependency()
  )
)
