#! /usr/bin/env Rscript
# counts_summary.R
# Alexander Kleefeldt Dec, 2017
#
# This script reads in the cleaned talkshow guest file (party_guests_clean.csv) and outpus a 
# summary table of total counts (party_guests_counts.csv) of politician appearances across the different tv-shows 
#
#Usage: Rscript src/counts_summary.R results/party_guests_clean.csv results/party_guests_counts.csv


#creating input variables 
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1] 
output_file <- args[2]


#loading libraries 

suppressMessages(library(tidyverse))
suppressMessages(library(dplyr))
suppressMessages(library(ggplot2))
suppressMessages(library(lubridate))

#loading in data
talkshow_guests <- read_csv(input_file)


main <- function(){
  #creating separate dataframes for each talkshow 
  fox_news <- talkshow_guests %>% filter(show == "Fox News Sunday")
  fox_news_shows <- fox_news %>% group_by(date) %>% summarise(n())
  fox_news_shows <- nrow(fox_news_shows)
  
  fox_news_count <- fox_news %>% 
    group_by(party) %>% 
    summarise( count = n()) %>% 
    spread(party,count) %>% 
    mutate(total_guests = sum(Democrat, Independent, Republican))
  
  
  meet_the_press <- talkshow_guests %>% filter(show == "Meet the Press")
  meet_the_press_shows <- meet_the_press %>% group_by(date) %>% summarise(n())
  meet_the_press_shows <- nrow(meet_the_press_shows)
  
  meet_the_press_count <- meet_the_press %>% 
    group_by(party) %>% 
    summarise( count = n()) %>% 
    spread(party,count) %>% 
    mutate(total_guests = sum(Democrat, Independent, Republican))
  
  
  face_the_nation <- talkshow_guests %>% filter(show == "Face the Nation")
  face_the_nation_shows <- face_the_nation %>% group_by(date) %>% summarise(n())
  face_the_nation_shows <- nrow(face_the_nation_shows)
  
  face_the_nation_count <- face_the_nation %>% 
    group_by(party) %>% 
    summarise( count = n()) %>% 
    spread(party,count) %>% 
    mutate(total_guests = sum(Democrat, Independent, Republican))
  
  
  state_of_the_union <- talkshow_guests %>% filter(show == "State of the Union")
  state_of_the_union_shows <- state_of_the_union %>% group_by(date) %>% summarise(n())
  state_of_the_union_shows <- nrow(state_of_the_union_shows)
  
  state_of_the_union_count <- state_of_the_union %>% 
    group_by(party) %>% 
    summarise( count = n()) %>% 
    spread(party,count) %>% 
    mutate(total_guests = sum(Democrat, Independent, Republican))
  
  
  this_week <- talkshow_guests %>% filter(show == "This Week")
  this_week_shows <- this_week %>% group_by(date) %>% summarise(n())
  this_week_shows <- nrow(this_week_shows)
  
  this_week_count <- this_week %>% 
    group_by(party) %>% 
    summarise( count = n()) %>% 
    spread(party,count) %>% 
    mutate(total_guests = sum(Democrat, Independent, Republican))
  
  
  summary_counts <- rbind(fox_news_count,meet_the_press_count,face_the_nation_count,state_of_the_union_count,this_week_count) 
  summary_counts <- summary_counts %>% 
    mutate(show = c("Fox News Sunday","Meet the Press","Face the Nation","State of the Union","This Week"))
  
  summary_counts <-   summary_counts[c(5,4,1,3,2)]
  
  #write clean csv to output folder
  write_csv(summary_counts, path = output_file)  
}

main()
