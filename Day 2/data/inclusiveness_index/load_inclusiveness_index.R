library(tidyverse)
library(readxl)

inclusiveness_index <- read_excel('data/inclusiveness_index/global_data_for_website_2020.xlsx',
                                  na="9999") %>%
  rename_with(~ str_remove_all(.x, "[(|)]") %>% str_replace_all("[-| ]", "."))
