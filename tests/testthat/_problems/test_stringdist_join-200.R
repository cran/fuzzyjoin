# Extracted from test_stringdist_join.R:200

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
d_lowercase <- d %>%
    dplyr::mutate(cut2 = stringr::str_to_lower(cut2))
j1 <- stringdist_inner_join(diamonds, d_lowercase, by = c(cut = "cut2"), distance_col = "distance",
                              max_dist = 1)
