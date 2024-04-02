run_app <- function(dsn) {

  pool <- dbPool(
    drv = odbc(),
    dsn = dsn
  )

  onStop(function() poolClose(pool))

  ui <-
    page_navbar(
      title = "Data management",
      id = NULL,
      selected = NULL,
      sidebar = NULL,
      fillable = TRUE,
      fillable_mobile = FALSE,
      gap = NULL,
      padding = NULL,
      position = c("static-top"),
      header =  tags$link(rel = "icon", type = "image/png", sizes = "32x32", href = "myBrowserImage.png"),
      footer = NULL,
      bg = NULL,
      inverse = "auto",
      collapsible = TRUE,
      fluid = TRUE,
      theme = bs_theme(),
      window_title = NA,
      lang = NULL,
      nav_menu(
        title = "Algo",
        nav_panel(
          "Run",
          layout_sidebar(
            sidebar = sidebar(
              title = "Runs"
            ),
            fillable = TRUE,
            fill = TRUE,
            bg = NULL,
            fg = NULL,
            border = NULL,
            border_radius = NULL,
            border_color = NULL,
            padding = NULL,
            gap = NULL,
            height = NULL
          )
        )
      ),
      nav_menu(
        title = "External sources",
        nav_panel(
          "PLACEHOLDER",
          layout_sidebar(
            sidebar = NULL,
            fillable = TRUE,
            fill = TRUE,
            bg = NULL,
            fg = NULL,
            border = NULL,
            border_radius = NULL,
            border_color = NULL,
            padding = NULL,
            gap = NULL,
            height = NULL
          )
        )
      )
    )

  server <- function(input, output, session) {

    tbl(pool, "ALGO")
  }

  shinyApp(
    ui, server
  )
}
