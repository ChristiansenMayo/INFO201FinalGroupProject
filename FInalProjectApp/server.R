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
    major_name <- filter(data, data$Major_category == input$careerchoices)
    
    # draw the histogram with the specified bins
    ggplot(major_name, aes(x = major_name$Major, y = major_name$Employed / major_name$Total, label = round(major_name$Employed / major_name$Total, digits = 2))) + geom_bar(stat="identity") + ggtitle("Majors") + xlab("Majors") + ylab("Employment Rate") + coord_flip() + geom_text(color = "red", size = 5)
    
  })
  output$pwd <- renderText({
    getwd()
    
  })
  output$displot2 <- renderPlot({
    
    #Filter Data
    major_name <- filter(data, data$Major_category == input$careerchoices2)
    
    # Draw bar Chart
    ggplot(major_name, aes(x = Major, y = Total, label = Total)) + geom_bar(stat = "identity") + coord_flip() + geom_text(color = "red", size = 5) #+ coord_polar(theta = "y") + scale_fill_brewer(palette = "set1")
    
  })
  output$displot3 <-  renderPlot({
    
    #Filter Data
    major_earnings <- filter(data, data$Major_category == input$careerchoices3)
    
    ggplot(major_earnings, aes(x = "", Median, fill = Major, label = )) + geom_bar(stat = "identity") + coord_polar(theta = "y") 
  })
})
