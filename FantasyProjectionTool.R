library("dplyr")
library("readxl")
library("tidyverse")
QB_list <- lapply(excel_sheets('~/Desktop/FormatedProjections.xlsx'), read_excel, path='~/Desktop/FormatedProjections.xlsx')
QBProjections <- QB_list %>% reduce(full_join, by = "Player") %>% mutate(Position = "QB")
QBProjections <- QBProjections[c(1,18,2:17)]
