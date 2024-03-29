database_setup <- function(dsn = "algo local", insert_test_data = TRUE) {
  conn <- dbConnect(odbc(), dsn = dsn)

  withr::local_dir("inst/sql/")
  to_install <-
    tibble(filename = list.files(pattern = ".sql", recursive = TRUE)) |>
    mutate(size = file.size(filename)) |>
    filter(size > 0) |>
    arrange(filename)

  tables <- dbGetQuery(conn, "SELECT NAME FROM SYS.TABLES")[[1]]
  views <- dbGetQuery(conn, "SELECT NAME FROM SYS.VIEWS")[[1]]

  if (length(views) > 0) {

    walk(
      views,
      function(.x) {
        if (dbExistsTable(conn, .x)) {
          dbExecute(conn, paste("DROP VIEW",.x))
        }
      }
    )
  }

  if (length(tables) > 0) {

    walk(
      tables,
      function(.x) {
        if (dbExistsTable(conn, .x)) {
          dbRemoveTable(conn, .x)
        }
      }
    )
  }

  for (i in to_install$filename) {
    qry <-
      readr::read_lines(file = i) |>
      glue::glue_collapse(sep = "\n")

    dbExecute(conn, qry)
  }

  if (insert_test_data) {

    for (i in names(test_data)) {

      rows_append(
        x = tbl(conn, i),
        y = test_data[[i]][[1]],
        copy = TRUE,
        in_place = TRUE
      )

    }
  }


}
