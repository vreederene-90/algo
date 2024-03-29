read_algo <- function(filename, format, skip = 1, dsn = "algo local") {
  if(tolower(tools::file_ext(filename)) != "csv") {
    stop("File extension is not .csv")
  }

  if (dbCanConnect(odbc(), dsn)) {

    conn <- dbConnect(odbc(), dsn)

    fread(
      file = filename,
      header = FALSE,
      skip = skip,
      na.strings = "",
      data.table = FALSE,
      col.names =
        tbl(conn, "ALGO") |>
        select(-ALGO_ID) |>
        colnames(),
      colClasses =
        tbl(conn, "ALGO") |>
        select(-ALGO_ID) |>
        collect(n = 1) |>
        map_chr(class) |>
        str_replace("Date","character")
    ) |>
      mutate(
        across(any_of(c(
          {
            tbl(conn, "ALGO") |> collect(n = 1) |> select(where(is.Date)) |> colnames()
          }
        )),as_date)
      )
  } else stop("No database connection available")

}

