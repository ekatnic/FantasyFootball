library(tidyverse)
library(stringr)
library(httr)
library(jsonlite)
library(knitr)
library(DT)
library(tibble)

url = "http://games.espn.com/ffl/api/v2/leagueSettings?leagueId=17056&seasonId=2017"
result <- GET(url = url)
raw.content <- rawToChar(result$content)
JSON.content <- fromJSON(this.raw.content)

scoreBoard = data.frame(matrix(ncol=5, nrow=0))
names <- c("Home", "Away", "HomeScore", "AwayScore", "Week")
colnames(scoreBoard) <- names

addFrame <- function(week) {
  # Get away score
  awayScores = lapply(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups, "[", 2)
  
  # Get away name
  nameExtract = (lapply(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups,"[[",3))
  awayTeamName = paste(unlist(lapply(nameExtract, "[", 6)), 
                       unlist(lapply(nameExtract, "[", 4)))
  
  # Get home score
  homeScores = lapply(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups,"[","homeTeamScores")
  
  # Get home name PROBLEM EXTRACTING HOMETEAMNAME
  nameExtract = (lapply(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups,"[[",12))
  homeTeamName = paste(unlist(lapply(nameExtract, "[", 6)), 
                       unlist(lapply(nameExtract, "[", 4)))
  
  
  scoreBoard = data.frame("Home" = homeTeamName, "Away" = awayTeamName, "HomeScore" = unlist(homeScores),
                           "AwayScore" = unlist(awayScores))
}

# flat.content <- flatten(this.content)

