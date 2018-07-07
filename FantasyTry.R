library(tidyverse)
library(stringr)
library(httr)
library(jsonlite)
library(knitr)
library(DT)
library(tibble)

url = "http://games.espn.com/ffl/api/v2/scoreboard?leagueId=17056&seasonId=2017&matchupPeriodId=1"
raw.result <- GET(url = url)
this.raw.content <- rawToChar(raw.result$content)


this.content <- fromJSON(this.raw.content)
# flat.content <- flatten(this.content)


str(this.content)