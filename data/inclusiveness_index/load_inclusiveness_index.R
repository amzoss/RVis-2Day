library(tidyverse)
library(readxl)
library(here)
here::i_am("data/inclusiveness_index/load_inclusiveness_index.R")

inclusiveness_index <- 
  read_excel(here("data", "inclusiveness_index", "global_data_for_website_2020.xlsx"),
             na="9999") %>%
  rename_with(~ str_remove_all(.x, "[(|)]") %>% str_replace_all("[-| ]", ".")) %>%
  dplyr::filter(Continent != "Antarctica") %>% 
  mutate(Continent = Continent %>% as_factor() %>% fct_infreq(),
         Index.categories.2020 = Index.categories.2020 %>% as_factor() %>% 
           fct_relevel(c("No data", "Low", "Medium-Low", "Medium", "Medium-High", "High")))