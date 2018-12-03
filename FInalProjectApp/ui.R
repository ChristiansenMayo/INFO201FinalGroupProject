#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

major <- read.csv("../data/majors-list.csv")
major_list <- unique(major$Major_Category)
#install.packages("shinydashboard")
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = "style.css",
  class = "dark",
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  
  # Application title
  titlePanel("College Major Information"),
    
    dashboardPage(
      dashboardHeader(title = "Dashboard",
                titleWidth = 300
                
                      ),
      dashboardSidebar(
        width = 300,
        sidebarMenu( #These are the icons you can click on for the sidebar
          menuItem("HomePage", tabName = "home", icon = icon("dashboard")),
          menuItem("Career Probabillity of Employment", tabName = "Data", icon = icon("th")),
          menuItem("Popular Careers", tabName = "Data2", icon = icon("th")),
          menuItem("Majors Earnings", tabName = "Data3", icon = icon("th"))

      )
    ),
    #This is where the data for the tabs goes
      dashboardBody(
        tabItems(
          
          #Homepage
          tabItem( tabName = "home",
                   h1("Welcome to the Homepage!"),
                   column(11,  p("The data set that our group has chosen to work with is College Majors, accessed from the fivethirtyeight blog, 
                      and collected by The American Community Survey. 
                      The data was created to inform students about how the major you pick determines your chance of economic success. 
                      Our project gives insight help to students who are confused of what majors to take, 
                      and provides students with the information from the view of gender and future employment for them to refer to.")),
                   column(11, p("Our project will be answering these questions")),
                   column(11, p("- If I choose a certain major, what's the probability of being employed?")),
                   column(11, p("- What Careers are popular within Males and what is within Females?")),
                   column(11, p("- What's the difference of earnings between undergraduate and masters?")),
                   textOutput("pwd")
                   
          ),
          
          tabItem( tabName = "Data",
                   h1("Career Probabillity of Employment"),
                   
                   #Place Plots and data to display here
                   plotOutput("distPlot"),
                   
                   #Place input choices here
                   radioButtons("careerchoices", label = h3("Career Choices"), choices = major_list)

          ),
          
          tabItem( tabName = "Data2",
                   h1("Popular Careers"),
                   plotOutput("displot2"),
                   
                   radioButtons("careerchoices2", label = h3("Career Choices"), choices = major_list)
        
          ),
          
          tabItem( tabName = "Data3",
                   h1("Majors Earnings")
          )

        )
      )
    )
  )
)
