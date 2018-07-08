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


awayScores = unlist(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups[1][[1]]["awayTeamScores"]$awayTeamScores)
awayTeamName = paste(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups[1][[1]]$awayTeam$teamLocation, 
                     JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups[1][[1]]$awayTeam$teamNickname)
homeScores = unlist(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups[1][[1]]["homeTeamScores"]$homeTeamScores)
homeTeamName = paste(JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups[1][[1]]$homeTeam$teamLocation, 
                     JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups[1][[1]]$homeTeam$teamNickname)
scoreBoards = data.frame("Home" = homeTeamName, "Away" = awayTeamName, "HomeScore" = homeScores,
                         "AwayScore" = awayScores, "Week" = 1)



# flat.content <- flatten(this.content)

str(this.content)