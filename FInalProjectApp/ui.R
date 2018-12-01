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
library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = "style.css",
  class = "dark",
  
  # Application title
  titlePanel("College Major Information"),
  
  # Sidebar with a slider input for number of bins 
    
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
                   p("Description of project will go here on the homepage"),
                   textOutput("pwd")
                   
          ),
          
          tabItem( tabName = "Data",
                   h1("Career Probabillity of Employment"),
                   
                   
                   #Place Plots and data to display here
                   plotOutput("distPlot"),
                   
                   #Place input choices here
                   #Need to input data
                   checkboxGroupInput("checkGroup", label = h3("Career Choices"), choices = major_list)

                   
          ),
          
          tabItem( tabName = "Data2",
                   h1("Popular Careers")
        
          ),
          
          tabItem( tabName = "Data3",
                   h1("Majors Earnings")
          )

        )
      )
    )
  )
)
