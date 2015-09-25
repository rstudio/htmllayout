#' @export
gssDependency = function() {
  htmltools::htmlDependency(
    'gss', '2.0.0', system.file('assets', 'gss', package = getPackageName()),
    script = 'gss.min.js',
    head = '<script type="text/javascript">window.engine = new GSS(document);</script>'
  )
}

#' @export
gssMatrix = function(mat, prefix = '') {
  mat = as.matrix(mat)
  n = nrow(mat); m = ncol(mat)
  s = list()
  mat = matrix(paste0(prefix, mat), nrow = n, ncol = m)
  for (i in seq_len(n)) {
    for (j in seq_len(m)) {
      if (i == 1) {
        s[[length(s) + 1]] = sprintf('#%s[top] == ::window[top];', mat[i, j])
      }
      if (j == 1) {
        s[[length(s) + 1]] = sprintf('#%s[left] == ::window[left];', mat[i, j])
      }
      if (i == n) {
        s[[length(s) + 1]] = sprintf('#%s[bottom] == ::window[bottom];', mat[i, j])
      }
      if (j == m) {
        s[[length(s) + 1]] = sprintf('#%s[right] == ::window[right];', mat[i, j])
      }
      if (i < n && mat[i, j] != mat[i + 1, j]) {
        s[[length(s) + 1]] = sprintf('#%s[bottom] == #%s[top];', mat[i, j], mat[i + 1, j])
      }
      if (j < m && mat[i, j] != mat[i, j + 1]) {
        s[[length(s) + 1]] = sprintf('#%s[right] == #%s[left];', mat[i, j], mat[i, j + 1])
      }
    }
  }
  unique(unlist(s))
}

gssSize = function(..., `_type` = c('width', 'height')) {
  type = match.arg(`_type`)
  unlist(lapply(list(...), function(s) {
    if (!inherits(s, 'formula')) {
      str(s)
      stop('All arguments must be two-sided formulae')
    }
    sprintf('#%s[%s] == %s;', deparse(s[[2]]), type,  replaceRHSVars(s, type))
  }))
}

replaceRHSVars = function(form, type) {
  RHS = form[[3]]
  form[[2]] = NULL
  vars0 = all.vars(form)
  vars1 = sprintf('#%s[%s]', vars0, type)
  RHS = substituteDirect(RHS, as.list(setNames(vars1, vars0)))
  gsub('"', '', paste(deparse(RHS, width.cutoff = 500), collapse = ''))
}

#' @export
gssWidth = function(...) {
  gssSize(..., `_type` = 'width')
}

#' @export
gssHeight = function(...) {
  gssSize(..., `_type` = 'height')
}

#' @export
gssStyle = function(style) {
  tags$style(type = 'text/gss', paste(style, collapse = '\n'))
}
