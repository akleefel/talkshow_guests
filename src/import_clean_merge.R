#! /usr/bin/env Rscript
# import_clean_merge.R
# Alexander Kleefeldt Dec, 2017

# This script reads in, cleans and merges data from:
# 1:  https://raw.githubusercontent.com/TheUpshot/Sunday-Shows/master/guests.csv 
# 2:  raw_data/legislators-current.csv
# 3:  raw_data/legislators-historical.csv
# And write it to: 
# results/party_guests_clean.csv
#
# To achieve this, I load in the main data set `guests.csv` containing info on guests of political talk shows 
# and add information on their party-affiliation by joining `legislators-current.csv` and `legislators-historical.csv`. 
#
#
# Usage: Rscript src/import_clean_merge.R https://raw.githubusercontent.com/TheUpshot/Sunday-Shows/master/guests.csv raw_data/legislators-current.csv raw_data/legislators-historical.csv results/party_guests_clean.csv



#creating input variables 
args <- commandArgs(trailingOnly = TRUE)
input_file1 <- args[1] 
input_file2 <- args[2] 
input_file3 <- args[3] 
output_file <- args[4] 

#loading required packages
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ezknitr))

#setwd(".../talkshow_guests")

#main function to import, clean and merge data

main <- function(){
  
  #reading in talkshow guest data
  guests <- read_csv(input_file1)
  
  #separating name column into fist name and last name, removing middle name for simplicity
  guests <- guests %>% 
    mutate(gender = as.factor(gender)) %>% 
    separate(name, c("first_name","middle_name", "last_name")) %>% 
    mutate(last_name = ifelse(is.na(last_name), middle_name, last_name)) %>% 
    mutate(middle_name = ifelse(middle_name == last_name, NA, middle_name)) %>% 
    select(-middle_name)
  
  
  #reading in, cleaning & merging data on congress members
  current_politicians <- read_csv(input_file2)
  current_politicians <- current_politicians %>% 
    select(last_name, first_name, party)
  
  
  hist_politicians  <- read_csv(input_file3)
  hist_politicians <- hist_politicians %>% 
    filter(year(birthday)>1935) %>% 
    select(last_name, first_name, party)
  
  #combining the dataframe of congress members
  politicians <- rbind(current_politicians, hist_politicians)
  
  
  #combine both dataframes to add party information & filtering for rows with 'party' information
  party_guests <- left_join(guests, politicians, by = c("last_name","first_name"))
  
  party_guests_clean <- party_guests %>%
    filter(!is.na(party))
  
  #write clean csv to output folder
  write_csv(party_guests_clean, path = output_file)

}

main()
