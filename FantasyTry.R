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

ScoreBoardPopulate <- function(teamNum) {
  # Get away score
  awayScores = unlist(lapply(teamNum, "[", 2))
  
  # Get away name
  nameExtract = (lapply(teamNum,"[[",3))
  awayTeamName = paste(unlist(lapply(nameExtract, "[", 6)), 
                       unlist(lapply(nameExtract, "[", 4)))
  
  # Get home score
  homeScores = unlist(lapply(teamNum,"[","homeTeamScores"))
  
  # Get home name 
  nameExtract = (lapply(teamNum,"[[","homeTeam"))
  homeTeamName = paste(unlist(lapply(nameExtract, "[", 6)), 
                       unlist(lapply(nameExtract, "[", 4)))

  
  scoreBoard <<- rbind(scoreBoard, data.frame("Home" = homeTeamName, "Away" = awayTeamName, "HomeScore" = unlist(homeScores),
                           "AwayScore" = unlist(awayScores), "Weeks" = 1:15))
}

teamCalls <- c(
              JSON.content$leaguesettings$teams$`1`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`2`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`3`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`4`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`5`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`6`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`7`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`8`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`9`$scheduleItems$matchups,
              JSON.content$leaguesettings$teams$`10`$scheduleItems$matchups
              )
ScoreBoardPopulate(teamCalls)
uniqueScoreBoard <- scoreBoard %>% unique %>% arrange(Weeks)
BuildTeamFrame <- function(teamName){
  TeamHomeScores <- uniqueScoreBoard %>% filter(Home == teamName) %>% select(Home, HomeScore, Weeks) %>% rename(Team = Home, Score = HomeScore)
  TeamAwayScores <- uniqueScoreBoard %>% filter(Away == teamName) %>% select(Away, AwayScore, Weeks) %>% rename(Team = Away, Score = AwayScore)
  return (rbind(TeamHomeScores, TeamAwayScores) %>% arrange(Weeks))
}
EthanScores <- BuildTeamFrame('Savage Mode')

