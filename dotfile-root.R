dotfile <- '.quarto-version'
criterion <- rprojroot::root_criterion(
  function(path) file.exists(file.path(path, dotfile)), paste0('has ', dotfile)
)
root <- rprojroot::find_root(criterion = criterion, path = '.')
cat(root)
