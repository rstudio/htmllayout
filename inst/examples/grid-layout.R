library(htmltools)
library(htmllayout)
browsable(
  attachDependencies(
    tagList(
      tags$head(
        gssStyle(c(
          gssMatrix(matrix(c(
            'x1', 'x1', 'x1',
            'x2', 'x3', 'x4',
            'x5', 'x5', 'x5'
          ), nrow = 3, byrow = TRUE)),
          gssWidth(x2 ~ 100, x3 ~ 2 * x4),
          gssHeight(x1 ~ 200, x5 ~ 50)
        )),
        tags$style(type = 'text/css', paste(sprintf(
          '#x%s {background-color: %s;}',
          c(1, 2, 3, 4, 5), c('red', 'purple', 'green', 'blue', 'yellow')
        ), collapse = '\n'))
      ),

      div(id = 'x1', 'top'),
      div(id = 'x2','left'),
      div(id = 'x3', 'right1'),
      div(id = 'x4', 'right2'),
      div(id = 'x5', 'bottom')
    ),
    gssDependency()
  )
)
