# Driver Script
# Alexander Kleefeldt Dec 2017
# Runs talkshow_guests Analysis
#
# usage: make all

all: documents/talkshow_guests_report.md

##########################################################
# Data Wrangling
##########################################################

#creating cleaned and merged dataset that names and party affiliation of politicians who were guests in one of the talk shows.
results/party_guests_clean.csv: src/import_clean_merge.R
	Rscript src/import_clean_merge.R https://raw.githubusercontent.com/TheUpshot/Sunday-Shows/master/guests.csv raw_data/legislators-current.csv raw_data/legislators-historical.csv results/party_guests_clean.csv

#creating summary table of guest ratios. Using the cleaned and merged dataset as input
results/party_guests_ratios.csv: results/party_guests_clean.csv src/ratio_summary.R
	Rscript src/ratio_summary.R results/party_guests_clean.csv results/party_guests_ratios.csv

#creating a summary table of guest counts. Using the summary table of guest ratios as input
results/summary_counts.png: results/party_guests_clean.csv src/counts_summary.R
	Rscript src/counts_summary.R results/party_guests_clean.csv results/party_guests_counts.csv results/summary_counts.png


###########################################################
# Visualization
###########################################################

#creating a stacked bar chart. Using the summary table of guest ratios as input
results/ratio_plot.png: results/party_guests_ratios.csv src/ratio_graphic.R
	Rscript src/ratio_graphic.R results/party_guests_ratios.csv results/ratio_plot.png


###########################################################
# Documents
###########################################################

#creating a project report that summarizes all results of the analysis and puts them into context.
documents/talkshow_guests_report.md: results/summary_counts.png results/ratio_plot.png
	Rscript -e "ezknitr::ezknit('src/talkshow_guests_report.Rmd', out_dir = 'documents')"



###########################################################
# Clean
###########################################################
clean:
	rm -f results/party_guests_clean.csv
	rm -f results/party_guests_counts.csv
	rm -f results/party_guests_ratios.csv
	rm -f results/ratio_plot.png
	rm -f results/summary_counts.png
	rm -f documents/talkshow_guests_report.md
	rm -f documents/talkshow_guests_report.html
