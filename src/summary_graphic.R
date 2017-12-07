#! /usr/bin/env Rscript
# sumary_graphic.R
# Alexander Kleefeldt Dec, 2017

# This script reads in the cleaned talkshow guest file (party_guests_clean.csv) and outpus a 
# summary graphic as a png file

#loading libraries 

library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)

#loading in data

talkshow_guests <- read_csv("results/party_guests_clean.csv")

talkshow_guests <- talkshow_guests %>% mutate(show = as.factor(show), party = as.factor(party), date =  lubridate(date,))

#creating separate dataframes for each talkshow 

fox_news <- talkshow_guests %>% filter(show == "Fox News Sunday") 
fox_news_count <- fox_news %>% group_by(party) %>% summarise(count = n())
fox_news_shows <- fox_news %>% group_by(date) %>% summarise(n())
fox_news_shows <- nrow(fox_news_shows)

meet_the_press <- talkshow_guests %>% filter(show == "Meet the Press") 
meet_the_press_count <- meet_the_press %>% group_by(party) %>% summarise(count = n())
fox_news_shows <- fox_news %>% group_by(date) %>% summarise(n())
meet_the_press_shows <- nrow(fox_news_shows)

face_the_nation <- talkshow_guests %>%  filter(show == "Face the Nation")
face_the_nation_count <-  face_the_nation %>% group_by(party) %>% summarise(count = n())


state_of_the_union <- talkshow_guests %>% filter(show == "State of the Union")
state_of_the_union_count <- state_of_the_union %>% group_by(party) %>% summarise(count =n())


this_week <- talkshow_guests %>% filter(show == "This Week")
this_week_count <- this_week %>% group_by(party) %>% summarise(count =n())
