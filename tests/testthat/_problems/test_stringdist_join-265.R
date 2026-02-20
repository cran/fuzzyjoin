# Extracted from test_stringdist_join.R:265

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
test_that(paste("stringdist_join returns a data.frame when x",
                "is a data.frame, whether y is or not"), {
  result <- diamonds %>%
    as.data.frame() %>%
    stringdist_inner_join(d, by = c(cut = "cut2"))

  expect_is(result, "data.frame")
  expect_false(inherits(result, "tbl_df"))

  result <- diamonds %>%
    as.data.frame() %>%
    stringdist_inner_join(as.data.frame(d), by = c(cut = "cut2"))

  expect_is(result, "data.frame")
  expect_false(inherits(result, "tbl_df"))
})

# test -------------------------------------------------------------------------
d <- tibble::tibble(cut2 = c(
    "Idea", "Premiums", "Premiom",
    "VeryGood", "VeryGood", "Faiir"
  )) %>%
    dplyr::mutate(type = dplyr::row_number())
diamonds_grouped <- diamonds %>%
    dplyr::group_by(cut)
