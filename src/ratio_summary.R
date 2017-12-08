#! /usr/bin/env Rscript
# sumary_graphic.R
# Alexander Kleefeldt Dec, 2017

# This script reads in the cleaned talkshow guest file (party_guests_clean.csv) and outpus a 
# summary table of ratios of representatives from different parties across the different
# tv shows. The output is a csv file called party_guests_ratios.csv. 

#loading libraries 

suppressMessages(library(tidyverse))
suppressMessages(library(dplyr))
suppressMessages(library(ggplot2))
suppressMessages(library(lubridate))

#loading in data

talkshow_guests <- read_csv("results/party_guests_clean.csv")


main <- function(){
    #changing columns to factors
    talkshow_guests <- talkshow_guests %>% mutate(show = as.factor(show), party = as.factor(party))
    
    #creating separate dataframes for each talkshow and calculating ratios
    fox_news <- talkshow_guests %>% filter(show == "Fox News Sunday")
    fox_news_shows <- fox_news %>% group_by(date) %>% summarise(n())
    fox_news_shows <- nrow(fox_news_shows)
    fox_news_count <- fox_news %>% group_by(party) %>% summarise(count = n()/fox_news_shows)
    fox_news_ratio <- fox_news_count %>% mutate(total = sum(count)) %>% mutate(ratio = count/total) %>% select(party,ratio)
    
    
    meet_the_press <- talkshow_guests %>% filter(show == "Meet the Press") 
    meet_the_press_shows <- meet_the_press %>% group_by(date) %>% summarise(n())
    meet_the_press_shows <- nrow(meet_the_press_shows)
    meet_the_press_count <- meet_the_press %>% group_by(party) %>% summarise(count = n()/meet_the_press_shows)
    meet_the_press_ratio <- meet_the_press_count %>% mutate(total = sum(count)) %>% mutate(ratio = count/total) %>% select(party,ratio)
    
    
    face_the_nation <- talkshow_guests %>%  filter(show == "Face the Nation")
    face_the_nation_shows <- face_the_nation %>% group_by(date) %>% summarise(n())
    face_the_nation_shows <- nrow(face_the_nation_shows)
    face_the_nation_count <-  face_the_nation %>% group_by(party) %>% summarise(count = n()/face_the_nation_shows)
    face_the_nation_ratio <- face_the_nation_count %>% mutate(total = sum(count)) %>% mutate(ratio = count/total) %>% select(party,ratio)
    
    
    state_of_the_union <- talkshow_guests %>% filter(show == "State of the Union")
    state_of_the_union_shows <- state_of_the_union %>% group_by(date) %>% summarise(n())
    state_of_the_union_shows <- nrow(state_of_the_union_shows)
    state_of_the_union_count <- state_of_the_union %>% group_by(party) %>% summarise(count =n()/state_of_the_union_shows)
    state_of_the_union_ratio <- state_of_the_union_count %>% mutate(total = sum(count)) %>% mutate(ratio = count/total) %>% select(party,ratio)
    
    
    this_week <- talkshow_guests %>% filter(show == "This Week")
    this_week_shows <- this_week %>% group_by(date) %>% summarise(n())
    this_week_shows <- nrow(this_week_shows)
    this_week_count <- this_week %>% group_by(party) %>% summarise(count =n()/this_week_shows)
    this_week_ratio <- this_week_count %>% mutate(total = sum(count)) %>% mutate(ratio = count/total) %>% select(party,ratio)
    
    #joining ratios for all shows  
    ratio_summary <- left_join(state_of_the_union_ratio, this_week_ratio,by='party',suffix= c('.state','.this_week'))%>%
      left_join(., face_the_nation_ratio, by='party') %>% 
      left_join(.,meet_the_press_ratio,by='party') %>% 
      left_join(.,fox_news_ratio,by='party')
      
                                 
    ratio_summary <- ratio_summary %>% 
      rename(ratio.face = ratio.x) %>% 
      rename(ratio.meet = ratio.y) %>% 
      rename(ratio.fox = ratio)
     
    
    #write clean csv to output folder
    write_csv(ratio_summary, path = "results/party_guests_ratios.csv")  
}

main()
