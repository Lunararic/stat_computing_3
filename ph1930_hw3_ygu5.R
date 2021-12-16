author="yue.gu@uth.tmc.edu"

# 1 IO
covid_stats = function(){
  if (!require("rvest")) install.packages("RCurl", repos = "https://cloud.r-project.org")
  if (!require("tidyverse")) install.packages("tidyverse", repos = "https://cloud.r-project.org")
  library("rvest")
  library("tidyverse")
  
  url = "https://en.wikipedia.org/wiki/COVID-19_pandemic_by_country_and_territory#void"
  table = read_html(url) %>% 
    html_nodes(".wikitable") %>% 
    html_table()
  
  covid_stats = as.data.frame(table[9]) %>% 
    select(-Var.6, -Var.7, -Var.8) %>% 
    filter(row_number()<= n()-1)
  return(covid_stats)
}

#test
# covid_stat = covid_stats()


# 2 RE
stat_comp_pkgs = function(){
  if (!require("httr")) install.packages("httr")
  if (!require("XML")) install.packages("XML")
  if (!require("tidyverse")) install.packages("tidyverse")
  library(httr)
  library(XML)
  library(tidyverse)
  
  lec = c("lec01_intro",
          "lec02_dev",
          "lec03_vec",
          "lec04_list",
          "lec05_factor",
          "lec06_prog",
          "lec07_env",
          "lec08_simu",
          "lec09_oo")
  
  slides = NULL
  for (i in 1:length(lec)){
    url = paste("https://bigcomplexdata.com/statcomp/",lec[i],".html", sep="",collapse = NULL)
    r = GET(url)
    doc = readHTMLList(doc=content(r, "text"))
    text = unlist(doc)
    slides = append(slides,text)
  }
  pkg_name = NULL
  pkg_name = append(pkg_name, str_extract(slides, "library([A-z0-9_]+)")[!is.na(str_extract(slides, "library([A-z0-9_]+)"))])
  pkg_name = append(pkg_name, unlist(str_split(str_extract(slides, "[A-z0-9_]+::[A-z0-9_]+")[!is.na(str_extract(slides, "[A-z0-9_]+::[A-z0-9_]+"))],"::"))[1])
  return(pkg_name)
}


# 3 SQL
rx_sql = function(){
  return("SELECT Name as Patients
          FROM Patient
          WHERE Id 
          NOT IN (SELECT Patient.Id FROM Patient, Rx WHERE Patient.Id = Rx.PatientID)")
}