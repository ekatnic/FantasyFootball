#install.packages("dplyr")
#install.packages("readxl")
#install.packages("tidyverse")
library("dplyr")
library("readxl")
library("tidyverse")


#---- Create SubTables
TableColumns <- c("Player", "Position", "Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6", "Week 7",
                  "Week 8", "Week 9", "Week 10", "Week 11", "Week 12", "Week 13", "Week 14", "Week 15", "Week 16")

QB_list <- lapply(excel_sheets('~/Desktop/FantasyProject/Data/FormatedQBProjections.xlsx'), read_excel, path='~/Desktop/FantasyProject/Data/FormatedQBProjections.xlsx')
QB_Projections <- QB_list %>% reduce(full_join, by = "Player") %>% mutate(Position = "QB")
QB_Projections <- QB_Projections[c(1,18,2:17)]
colnames(QB_Projections) <- TableColumns

RB_list <- lapply(excel_sheets('~/Desktop/FantasyProject/Data/FormatedRBProjections.xlsx'), read_excel, path='~/Desktop/FantasyProject/Data/FormatedRBProjections.xlsx')
RB_Projections <- RB_list %>% reduce(full_join, by = "Offense") %>% mutate(Position = "RB")
RB_Projections <- RB_Projections[c(1,18,2:17)]
colnames(RB_Projections) <- TableColumns

WR_list <- lapply(excel_sheets('~/Desktop/FantasyProject/Data/FormatedWRProjections.xlsx'), read_excel, path='~/Desktop/FantasyProject/Data/FormatedWRProjections.xlsx')
WR_Projections <- WR_list %>% reduce(full_join, by = "Player") %>% mutate(Position = "WR")
WR_Projections <- WR_Projections[c(1,18,2:17)]
colnames(WR_Projections) <- TableColumns

TE_list <- lapply(excel_sheets('~/Desktop/FantasyProject/Data/FormatedTEProjections.xlsx'), read_excel, path='~/Desktop/FantasyProject/Data/FormatedTEProjections.xlsx')
TE_Projections <- TE_list %>% reduce(full_join, by = "Offense") %>% mutate(Position = "TE")
TE_Projections <- TE_Projections[c(1,18,2:17)]
colnames(TE_Projections) <- TableColumns

DST_list <- lapply(excel_sheets('~/Desktop/FantasyProject/Data/FormatedDSTProjections.xlsx'), read_excel, path='~/Desktop/FantasyProject/Data/FormatedDSTProjections.xlsx')
DST_Projections <- DST_list %>% reduce(full_join, by = "Defense/Special Teams") %>% mutate(Position = "DST")
DST_Projections <- DST_Projections[c(1,18,2:17)]
DST_Projections[,c(-1,-2)] <-round(DST_Projections[,c(-1,-2)],2)
colnames(DST_Projections) <- TableColumns
DST_Projections$Player <- substring(DST_Projections$Player,0,nchar(DST_Projections$Player)-9)

K_list <- lapply(excel_sheets('~/Desktop/FantasyProject/Data/FormatedKProjections.xlsx'), read_excel, path='~/Desktop/FantasyProject/Data/FormatedKProjections.xlsx')
K_Projections <- K_list %>% reduce(full_join, by = "Kickers") %>% mutate(Position = "K")
K_Projections <- K_Projections[c(1,18,2:17)]
K_Projections[,c(-1,-2)] <-round(K_Projections[,c(-1,-2)],2)
colnames(K_Projections) <- TableColumns

#----Create full table
full_projections <- rbind(QB_Projections, RB_Projections, WR_Projections, TE_Projections, DST_Projections, K_Projections)
write.csv(full_projections, "~/Desktop/FantasyProject/Data/ProjectionTable.csv")

# 
# teamBuilder <- function(PlayerList) {
#   team_Projections <- full_projections %>% filter(Player %in% PlayerList) #%>% select(c(-1,-2))
#   #team_Projections <- team_Projections %>% summarise_all(funs(sum(.,na.rm = TRUE)))
#   return (team_Projections)
# }
# 
# players <- c("Aaron Rodgers", "Le'Veon Bell", "David Johnson", "Antonio Brown", "Julio Jones", "Odell Beckham Jr.",
#              "Rob Gronkowski", "Jacksonville", "Justin Tucker")
# View(teamBuilder(players))
# team <- teamBuilder(players)
# summaryRow <- team %>% select(c(-1,-2)) %>% summarise_all(funs(sum(.,na.rm = TRUE)))
# summaryRow$Player = "TeamTotal"
# summaryRow$Position = ""
# summaryRow <- summaryRow[c(17,18,1:16)]
