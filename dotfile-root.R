dotfile <- '.quarto-version'
criterion <- rprojroot::root_criterion(
  function(path) file.exists(file.path(path, dotfile)), paste0('has ', dotfile)
)
root <- tryCatch(rprojroot::find_root(criterion = criterion, path = '.'), error = function(e){})
cat(root)
