library(shiny)
library(dplyr)
library(readxl)
library(tidyverse)
library(DT)
library(magrittr)


projectionTable <- read.csv("data/ProjectionTable.csv", stringsAsFactors = FALSE)

server <- function(input,output){
  
  output$table <- renderDataTable({
    playerList <- list(input$QB, input$RB1, input$RB2, input$WR1, input$WR2, input$WR3, input$FLEX, input$TE, input$DST, input$K)
    projectionTable <- projectionTable %>% filter(Player %in% playerList) %>% select(-1)
    #---build summary row
    summaryRow <- projectionTable %>% select(c(-1,-2)) %>% summarise_all(funs(sum(.,na.rm = TRUE)))
    summaryRow$Player = "TeamTotal"
    summaryRow$Position = ""
    summaryRow <- summaryRow[c(17,18,1:16)]
    fullTable <- rbind(projectionTable, summaryRow)
    #---bold summary row
    datatable(fullTable) %>%formatStyle(
                                        0,
                                        target = "row",
                                        fontWeight = styleEqual(nrow(fullTable), "bold")
                          ) %>% 
                          formatStyle(c(1:18),
                                        color = "black"
                          )
  
  })
}