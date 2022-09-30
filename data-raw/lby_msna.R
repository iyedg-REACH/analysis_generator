msna_url <- paste0(
  "https://www.impact-repository.org/document/reach/d12e44b6/",
  "REACH_LBY_Dataset_2105b_August-2021.xlsx"
)
file_path <- tempfile(fileext = "xlsx")

msna_url %>%
  httr2::request() %>%
  httr2::req_perform(path = file_path)

lby_msna2021 <- readxl::read_excel(file_path,
  sheet = "Clean Data",
  skip = 1,
  na = c("NA")
) %>%
  janitor::remove_empty(which = "cols")

usethis::use_data(lby_msna2021, overwrite = TRUE, compress = "bzip2", version = 3)

lby_msna2021_questions <- readxl::read_excel(file_path,
  sheet = "Kobo survey",
  na = c("NA")
) %>%
  janitor::remove_empty(which = "cols")

usethis::use_data(lby_msna2021_questions, overwrite = TRUE, compress = "bzip2", version = 3)

lby_msna2021_choices <- readxl::read_excel(file_path,
  sheet = "Kobo choices",
  na = c("NA")
) %>%
  janitor::remove_empty(which = "cols")

usethis::use_data(lby_msna2021_choices, overwrite = TRUE, compress = "bzip2", version = 3)
