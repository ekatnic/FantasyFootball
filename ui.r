library(shiny)
source("server.R")
library("markdown")
library(shinythemes)

ui<- shinyUI(fluidPage(theme = shinytheme("slate"),
                  titlePanel("Players:"),
                  fluidRow(column(3,
                                  selectizeInput(inputId = "QB",
                                          label = "Quarterback", 
                                          choices = (projectionTable %>% filter(Position == "QB"))$Player,
                                          selected = ""
                                                 ),
                                  selectizeInput(inputId = "RB1",
                                          label = "Running Back 1", 
                                          choices = (projectionTable %>% filter(Position == "RB"))$Player
                                                ),
                                  selectizeInput(inputId = "RB2",
                                          label = "Running Back 2", 
                                          choices = (projectionTable %>% filter(Position == "RB"))$Player
                                                ),
                                  selectizeInput(inputId = "TE",
                                                 label = "Tight End", 
                                                 choices = (projectionTable %>% filter(Position == "TE"))$Player
                                  ),
                                  selectizeInput(inputId = "FLEX",
                                                 label = "Flex", 
                                                 choices = (projectionTable %>% filter(Position %in% c("RB","WR","TE")))$Player
                                  )
                                )
                      , column(3, offset = .5,
                            selectizeInput(inputId = "WR1",
                                              label = "Wide Receiver 1", 
                                              choices = (projectionTable %>% filter(Position == "WR"))$Player
                            ),
                               selectizeInput(inputId = "WR2",
                                              label = "Wide Receiver 2", 
                                              choices = (projectionTable %>% filter(Position == "WR"))$Player
                            ),
                            selectizeInput(inputId = "WR3",
                                 label = "Wide Receiver 3", 
                                 choices = (projectionTable %>% filter(Position == "WR"))$Player
                            ),
                            selectizeInput(inputId = "DST",
                                           label = "Defense/Special Teams", 
                                           choices = (projectionTable %>% filter(Position == "DST"))$Player
                            ),
                            selectizeInput(inputId = "K",
                                           label = "Kicker", 
                                           choices = (projectionTable %>% filter(Position == "K"))$Player
                            )
                      )
                      , column(3, offset = 1.75,
                               selectizeInput(inputId = "B1",
                                              label = "Bench", 
                                              choices = projectionTable$Player
                               ),
                               selectizeInput(inputId = "B2",
                                              label = "Bench", 
                                              choices = projectionTable$Player
                               ),
                               selectizeInput(inputId = "B3",
                                              label = "Bench", 
                                              choices = projectionTable$Player
                               ),
                               selectizeInput(inputId = "B4",
                                              label = "Bench", 
                                              choices = projectionTable$Player
                               ),
                               selectizeInput(inputId = "B5",
                                              label = "Bench", 
                                              choices = projectionTable$Player
                               )
                      )
                  ),
                  fluidRow( numericInput(inputId = "Week",
                                         label = h3("Choose Week"),
                                         min = 1,
                                         max = 16,
                                         value = 1
                            )
                    ,
                    column(4, width=7,dataTableOutput(outputId = "table"))
                  )
              )
        )