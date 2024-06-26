devtools::load_all()
rm(list = ls())
# looks for app.R in project root
options(shiny.autoload.r = TRUE)
options(shiny.autoreload = TRUE)
options(shiny.launch.browser = FALSE)
options(shiny.port = 8888)
options(shiny.trace = FALSE)
options(shiny.fullstacktrace = FALSE)
options(shiny.error = NULL)
runApp()
