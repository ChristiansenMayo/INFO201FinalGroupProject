#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#source("../employment.R")
data <- read.csv("../data/all-ages.csv")
major <- read.csv("../data/majors-list.csv")
major_list <- unique(major$Major_Category)
library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    #Filter Data
    major_name <- filter(data, data$Major_category == input$checkGroup)
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] #data 

    
    # draw the histogram with the specified number of bins
    ggplot(major_name, aes(x = major_name$Major, y = major_name$Employed / major_name$Total)) + geom_bar(stat="identity") + ggtitle("Majors") + coord_flip() + xlab("Employment Rate") + ylab("Majors")
    
  })
  output$pwd <- renderText({
    getwd()
  })
  
})
