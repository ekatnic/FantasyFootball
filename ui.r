library(shiny)
source("server.R")
library("markdown")

ui<- fluidPage(
  titlePanel("List of Players"),
  textInput(inputId = "QB",
            label = "Quarterback", 
            value = ""),
  textInput(inputId = "RB1",
            label = "Running Back 1", 
            value = ""),
  textInput(inputId = "RB2",
            label = "Runinng Back 2", 
            value = ""),
  textInput(inputId = "WR1",
            label = "Wide Receiver 1", 
            value = ""),
  textInput(inputId = "WR2",
            label = "Wide Receiver 2", 
            value = ""),
  textInput(inputId = "WR3",
            label = "Wide Receiver 3", 
            value = ""),
  textInput(inputId = "TE",
            label = "Tight End", 
            value = ""),
  textInput(inputId = "DST",
            label = "Defense/Special Teams", 
            value = ""),
  textInput(inputId = "K",
            label = "Kicker", 
            value = ""),
  fluidRow(
    dataTableOutput(outputId = "table")
  )
)