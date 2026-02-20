# Extracted from test_stringdist_join.R:156

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
d <- tibble(cut2 = c(
    "Ideolll", "Premiumsss", "Premiomzzz",
    "VeryVeryGood", "VeryVeryGood", "FaiirsFair"
  )) %>%
    dplyr::mutate(type = dplyr::row_number())
j1 <- stringdist_inner_join(diamonds, d, by = c(cut = "cut2"))
