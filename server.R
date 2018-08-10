library(shiny)
library(dplyr)
library(readxl)
library(tidyverse)
library(DT)
library(magrittr)


projectionTable <- read.csv("data/ProjectionTable.csv", stringsAsFactors = FALSE)

server <- function(input,output){
  
  output$table <- renderDataTable({
    playerList <- list(input$QB, input$RB1, input$RB2, input$WR1, input$WR2, input$WR3,
                       input$FLEX, input$TE, input$DST, input$K, input$B1, input$B2, input$B3,
                       input$B5, input$B5)
    displayTable <- projectionTable %>% filter(Player %in% playerList) %>% select(2, 3, (input$Week + 3))
    colnames(displayTable)[3] <- "Projections"
    
    #Choose Starters
    QBs <- (displayTable %>% filter(Position == "QB") %>% top_n(1, Projections))$Player
    RBs <- (displayTable %>% filter(Position == "RB") %>% top_n(2, Projections))$Player
    WRs <- (displayTable %>% filter(Position == "WR") %>% top_n(3, Projections))$Player
    TE <- (displayTable %>% filter(Position == "TE") %>% top_n(1, Projections))$Player
    FLEX <- (displayTable %>% filter(Position %in% c("RB", "WR", "TE")) %>% 
              filter(!Player %in% append(RBs, c(WRs, TE))) %>% top_n(1, Projections))$Player
    DST <- (displayTable %>% filter(Position == "DST") %>% top_n(1, Projections))$Player
    K <- (displayTable %>% filter(Position == "K") %>% top_n(1, Projections))$Player
    StarterList <- append(QBs, c(RBs, WRs, TE, FLEX, DST, K))
      
    displayTable <- displayTable %>% filter(Player %in% StarterList)
    #---build summary row
    summaryRow <- displayTable %>% summarize(Projections = sum(Projections))
    summaryRow$Player = "TeamTotal"
    summaryRow$Position = ""
    summaryRow <- summaryRow[c(2,3,1)]
    fullTable <- rbind(displayTable, summaryRow)
    #---bold summary row
    datatable(fullTable) %>% formatStyle(
                                        0,
                                        target = "row",
                                        fontWeight = styleEqual(nrow(fullTable), "bold")
                          ) %>%
                          formatStyle(c(1:3),
                                        color = "black"
                          )

  })
}