# Extracted from test_stringdist_join.R:130

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
d3 <- tibble::tibble(
    cut2 = c(
      "Idea", "Premiums", "Premiom",
      "VeryGood", "VeryGood", "Faiir"
    ),
    carat2 = c(0, .5, 1, 1.5, 2, 2.5)
  ) %>%
    dplyr::mutate(type = dplyr::row_number())
sdist <- function(s1, s2) stringdist::stringdist(s1, s2) <= 1
ndist <- function(n1, n2) abs(n1 - n2) < .25
j <- diamonds %>%
    fuzzy_inner_join(d3, by = c(cut = "cut2", carat = "carat2"),
                     match_fun = list(sdist, ndist))
