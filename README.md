# talkshow_guests

### Project description

In this project I use data on politicians who have appeared on five American Sunday news and talk shows: “Meet the Press,” “Face the Nation,” “This Week,” “Fox News Sunday” and “State of the Union.” In the context of the discussions around "fake news" and biased media coverage, I asked myself another question: "Do all Sunday talk shows invite an equal amount of representatives from the different political parties?". Considering that different TV-networks in America cater to different audiences the likely answer is no. However, I decided to take a closer look and investigate which talk shows favor guests from which political parties.



### Hypothesis & Approach

My hypothesis is simply that different talk shows favor guests from different parties. To test this, this project a graphical and numerical summary of the proportions of guests from different parties for all 5 shows. The final [report](documents/talkshow_guests_report.md) contains a table of total counts of guests per party for all different shows as well as a visualization of party-ratios using a stacked bar plot.

### Usage

To reproduce the results of this project, follow these steps:

1. Clone the project repository to your computer
2. Navigate the shell to the project repository
3. Run the following commands in the exact order:

 *   creating  [cleaned and merged dataset](results/party_guests_clean.csv) that names and party affiliation of politicians who were guests in one of the talk shows.
 ```
 Rscript src/import_clean_merge.R https://raw.githubusercontent.com/TheUpshot/Sunday-Shows/master/guests.csv raw_data/legislators-current.csv raw_data/legislators-historical.csv results/party_guests_clean.csv
 ```
 * creating [summary table of guest         ratios](results/party_guests_ratios.csv). Using the [cleaned and merged dataset](results/party_guests_clean.csv) as input
 ```
 Rscript src/ratio_summary.R results/party_guests_clean.csv results/party_guests_ratios.csv
 ```
  * creating a [summary table of guest counts](results/party_guests_counts.csv).  Using the [summary table of guest ratios](results/party_guests_ratios.csv) as input
  ```
  Rscript src/counts_summary.R results/party_guests_clean.csv results/party_guests_counts.csv
  ```
   *  creating a [stacked bar chart](results/ratio_plot.png). Using the [summary table of guest ratios](results/party_guests_ratios.csv) as input
   ```
   Rscript src/ratio_graphic.R results/party_guests_ratios.csv results/ratio_plot.png
   ```
   * Finally, creating a [project report](documents/talkshow_guests_report.md) that summarizes all results of the analysis and puts them into context.
   ```
   Rscript -e "ezknitr::ezknit('src/talkshow_guests_report.Rmd', out_dir = 'documents')"
   ```


### Data Sources

|Dataset|Link|
|---|---|
|Talkshow Guests|[guests.csv](https://github.com/TheUpshot/Sunday-Shows)|
|Current Legislators|[legislators-current.csv](https://github.com/unitedstates/congress-legislators)|
|Historical Legislators|[legislators-historical.csv](https://github.com/unitedstates/congress-legislators)|
