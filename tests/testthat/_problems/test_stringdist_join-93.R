# Extracted from test_stringdist_join.R:93

# setup ------------------------------------------------------------------------
library(testthat)
test_env <- simulate_test_env(package = "fuzzyjoin", path = "..")
attach(test_env, warn.conflicts = FALSE)

# prequel ----------------------------------------------------------------------
context("stringdist_join")
d <- tibble::tibble(
  cut2 = c("Idea", "Premiums", "Premiom", "VeryGood", "VeryGood", "Faiir")
  ) %>%
  dplyr::mutate(type = dplyr::row_number())
d2 <- head(d, 3)
included <- c("Ideal", "Premium")
notin <- c("Fair", "Good", "Very Good")
d3 <- dplyr::bind_rows(d2, tibble::tibble(cut2 = "NewType", type = 4))

# test -------------------------------------------------------------------------
result <- diamonds %>%
    stringdist_semi_join(d2, by = c(cut = "cut2"))
