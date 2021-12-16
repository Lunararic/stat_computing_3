#test
library(RCurl)
library(rvest)
library(tidyverse)
url = "https://en.wikipedia.org/wiki/COVID-19_pandemic_by_country_and_territory#void"
table = read_html(url) %>% 
  html_nodes(".wikitable") %>% 
  html_table()

table[9]

html_table(table[1])
html_table(table[2])
html_table(table[3])
html_table(table[4])

a=getURL()



page = read_html("https://en.wikipedia.org/wiki/List_of_U.S._states_by_life_expectancy")
# Obtain the piece of the web page that corresponds to the "wikitable" node
my.table = html_node(page, ".wikitable")
# Convert the html table element into a data frame
my.table = html_table(my.table, fill = TRUE)
# Extracting and tidying a single column from the table and adding row names
x = as.numeric(gsub("\\[.*","",my.table[,4]))
names(x) = gsub("\\[.*","",my.table[,2])
# Excluding non-states and averages from the table
life.expectancy = x[!names(x) %in% c("United States", "Northern Mariana Islands", "Guam", "American Samoa", "Puerto Rico", "U.S. Virgin Islands")]