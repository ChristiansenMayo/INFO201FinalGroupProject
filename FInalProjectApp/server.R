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
major_gender <- read.csv("../data/women-stem.csv")
major_list_stem <- unique(major$Major_category)
recent_grads <- read.csv("data/recent-grads.csv", stringsAsFactors = FALSE)
library(shiny)
library(dplyr)
library(RColorBrewer)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    #Filter Data
    major_name <- filter(data, data$Major_category == input$careerchoices)
    
    # draw the histogram with the specified bins
    ggplot(major_name, aes(x = major_name$Major, y = major_name$Employed / major_name$Total, label = round(major_name$Employed / major_name$Total, digits = 2))) + geom_bar(stat="identity") + ggtitle("Majors") + xlab("Majors") + ylab("Employment Rate") + coord_flip() + geom_text(color = "red", size = 5, nudge_y = 0.011)
    
  })
  output$pwd <- renderText({
    getwd()
    
  })
  output$displot2 <- renderPlot({
    
    recent_grads_arrange <- recent_grads %>% arrange(Major_category)
    recent_grads[is.na(recent_grads)] <- 0
    majors <- unique(recent_grads_arrange$Major_category)
    majors <- majors[c(1, 2, 3, 12, 4, 13, 5, 6, 7, 14, 8, 9, 10, 11, 15, 16)]
    num_men <- c()
    num_women <- c()
    
    for (i in 1:length(majors)) {
      data_by_major <- recent_grads %>% filter(Major_category == majors[i]) %>% 
        mutate(M = sum(Men)) %>% mutate(F = sum(Women))
      num_men <- c(num_men, data_by_major[1, "M"])
      num_women <- c(num_women, data_by_major[1, "F"])
    }
    
    if (input$check == "Male") {
      pct <- round(num_men / sum(num_men) * 100)
      lbls <- paste0(majors, " ", pct, "%")
      pie(num_men, labels = lbls, col = rainbow(length(lbls)), 
          main = "Pie Chart of Men", radius = 1)
    }
    else {
      pct <- round(num_women / sum(num_women) * 100)
      lbls <- paste0(majors, " ", pct, "%")
      pie(num_women, labels = lbls, col = rainbow(length(lbls)), 
          main = "Pie Chart of Women", radius = 1)
    }
  })
  output$displot3 <-  renderPlot({
    
    #Filter Data
    major_earnings <- filter(data, data$Major_category == input$careerchoices3)
    
    ggplot(major_earnings, aes(x = Major, Median, fill = Major, label = paste0("$", Median))) + geom_bar(stat = "identity") + xlab("") + coord_flip() + geom_text(color = "red", size = 5, nudge_y = 6000)
  })
  output$displot4 <-  renderPlot({
    
    #Filter Data
    major_list <- filter(data, data$Major_category == input$careerchoices4)
    
    for (i in 1:length(majors)) {
      data_by_major <- recent_grads %>% filter(Major_category == majors[i]) %>% 
        mutate(M = sum(Men)) %>% mutate(F = sum(Women))
      num_men <- c(num_men, data_by_major[1, "M"])
      num_women <- c(num_women, data_by_major[1, "F"])
      
    }
  })
})
