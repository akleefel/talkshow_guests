#! /usr/bin/env Rscript
# ratio_graphic.R
# Alexander Kleefeldt Dec, 2017
#
# This script reads in the summary of rations (party_guests_ratios.csv) produced by ratio_summary.R and creates a 
# stacked bar chart (ratio_plot.png) to summarize  the ratios of politician appearances across the different tv-shows.
#
#Usage: Rscript src/ratio_graphic.R results/party_guests_ratios.csv results/ratio_plot.png

#creating command line variables 
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1] 
output_file <- args[2]


suppressMessages(library(tidyverse))
suppressMessages(library(ggplot2))


guest_ratios <- read_csv(input_file)


main <- function(){
  #some data wrangling to create dataframe in tidy format
  guest_ratios <- gather(guest_ratios, "party", "ratio", 1:3)
  guest_ratios <- guest_ratios %>% rename(Party = party) %>% rename(Ratio = ratio)
  
  guest_ratios <- guest_ratios %>% 
    mutate(Show = as.factor(Show),Party = as.factor(Party)) %>% 
    mutate(Party = fct_reorder(Party, Ratio))
  
  my_colors <- c("green4", "navyblue", "firebrick3")
  
  #creating stacked bar chart to visualize proportion of guests from different parties for each show
  ratio_plot <- ggplot(guest_ratios, aes(x=Show, y = Ratio))+
    geom_bar(aes(fill = Party), stat="identity", color = "black")+
    scale_fill_manual(values = my_colors)+
    theme_light()+
    ggtitle("Talkshow Guests by Party")+
    coord_flip()+
    theme(axis.title.y=element_blank())
    
  
  ggsave(output_file, ratio_plot)
}

main()
