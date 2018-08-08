library(shiny)
source("server.R")
library("markdown")
library(shinythemes)

ui<- shinyUI(fluidPage(theme = shinytheme("superhero"),
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
                      , column(3, offset = 2,
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
                  ),
                  fluidRow( 
                    dataTableOutput(outputId = "table")
                  )
              )
        )