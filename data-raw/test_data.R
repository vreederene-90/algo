load_all()

algo_2024_03_12 <- read_algo("~/data/algo/ALGO_INTERFACE_20240312_10251.csv")

test_data <- list(
  algo = list(algo_2024_03_12 = algo_2024_03_12)
)

usethis::use_data(
  test_data,
  overwrite = TRUE
)

rm(list = ls())
load_all()
