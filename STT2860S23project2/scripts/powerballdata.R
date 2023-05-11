# Script to read, tidy, and save Powerball numbers data
# Authors: Laura, Josie, Claudia
# Created: 2023-04-24
# Updated: 5/8/2023

# --------------------------------------------------
# packages

library(tidyverse)
library(readr)
library(readxl)
library(writexl)

# -------------------------------------------------------
# read Powerball data from the Excel file in data_raw
# x---------------------------------------x

powerball <- read_excel("data_raw/powerballdata.xlsx") %>%
  rename(
    drawdate = `Draw Date`,
    numbers = `Winning Numbers`,
    multiplier = `Multiplier`
  )

# -------------------------------------------------------
# Format, tidy, and reshape the dataset

# x-----INSTRUCTIONS FOR THIS SECTION-----x
# Delete the instructions when you are done

# Pivot the dataset so that all of the ball
# values (white and the powerball) are in a
# single column.
# x---------------------------------------x

powerball_tidy <- powerball %>%
  separate_wider_delim(
   numbers,
    delim = " ",
    names = c("w1", "w2", "w3", "w4", "w5", "powerball")
  ) %>%
  mutate(
    w1 = as.numeric(w1),
    w2 = as.numeric(w2),
    w3 = as.numeric(w3),
    w4 = as.numeric(w4),
    w5 = as.numeric(w5),
    powerball = as.numeric(powerball)
  ) %>% 
  
  pivot_longer(
    cols = starts_with("w"),
    names_to = "winning_number",
    values_to = "value"
  ) %>%
  mutate(winning_number = str_replace(winning_number, "w", ""))
  
# -------------------------------------------------------
# write tidied dataset to data_tidy folder

# x-----INSTRUCTIONS FOR THIS SECTION-----x
# Delete the instructions when you are done

# Write the pivoted data into an Excel file
# in the tidy_data folder. Unlike markdown,
# do not use ../ before the folder name in
# the file path. Just use "data_tidy/".
# x---------------------------------------x
write_xlsx(powerball_tidy, "data_tidy/tidypowerballdata.xlsx")

