
# talkshow_guests

## Report 

Please, find a short summary of the results of the analysis in this [report](documents/talkshow_guests_report.md)


## Project goal & description
The primary goal of this project was to create a data analysis pipeline that is *reproducable* for anyone using docker and command line using the below instructions. To make things somewhat interesting, I used data on politicians who have appeared on five American Sunday news and talk shows: “Meet the Press,” “Face the Nation,” “This Week,” “Fox News Sunday” and “State of the Union.” In the context of the discussions around "fake news" and biased media coverage, I asked myself another question: "Do all Sunday talk shows invite an equal amount of representatives from the different political parties?". Considering that different TV-networks in America cater to different audiences the likely answer is no. However, I decided to take a closer look and investigate which talk shows favor guests from which political parties.

## Hypothesis & Approach
My hypothesis is simply that different talk shows favor guests from different parties. To test this, this project a graphical and numerical summary of the proportions of guests from different parties for all 5 shows. The final report contains a table of total counts of guests per party for all different shows as well as a visualization of party-ratios using a stacked bar plot.

## Usage
To reproduce the results of this project, follow these steps:

1.Pull the docker image

`docker pull akleefel/talkshow_guests`

2.Clone the talkshow_guests github repo

`git clone https://github.com/akleefel/talkshow_guests.git`

3.Run the docker image

`docker run -it --rm -v ABSOLUTE_PATH_TO_ROJECT_DIRECTORY:/home/talkshow_guests akleefel/talkshow_guests /bin/bash`

4.change directory

`cd home/talkshow_guests`

5.clean existing results

`make clean`

6.Recreate data analysis

`make all`


## Data Sources

|Dataset|Link|
|---|---|
|Talkshow Guests|[guests.csv](https://github.com/TheUpshot/Sunday-Shows)|
|Current Legislators|[legislators-current.csv](https://github.com/unitedstates/congress-legislators)|
|Historical Legislators|[legislators-historical.csv](https://github.com/unitedstates/congress-legislators)|
