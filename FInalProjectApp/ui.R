#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

major <- read.csv("data/majors-list.csv")
major_list <- unique(major$Major_Category)
major_gender <- read.csv("data/women-stem.csv")
major_list_all <- unique(major$Major)
major_list_stem <- unique(major_gender$Major_category)
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
          menuItem("Gender Population in Careers", tabName = "Data2", icon = icon("th")),
          menuItem("Majors Earnings", tabName = "Data3", icon = icon("th")),
          menuItem("Graduates vs Undergraduates", tabName = "Data4", icon = icon("th"))

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
                   column(11, p("- What's the earning difference between Undergraduates and Graduates?"))
                   
          ),
          
          tabItem( tabName = "Data",
                   h1("Career Probabillity of Employment"),
                   p("Choose a career major category to view the probability rate of being employed."),
                   
                   #Place Plots and data to display here
                   plotOutput("distPlot"),
                   
                   #Place input choices here
                   radioButtons("careerchoices", label = h3("Career Choices"), choices = major_list)

          ),
          
          tabItem( tabName = "Data2",
                   h1("Gender Population in Careers"),
                   p("Select Male or Female to see gender population percentages in a major."),
                   
                   #Place plot
                   plotOutput("displot2"),
                   
                   radioButtons("check", label = h3("Select M/F"), choices = c("Male", "Female"))
                   
                   #radioButtons("careerchoices2", label = h3("Career Choices"), choices = major_list_stem)
        
          ),
          
          tabItem( tabName = "Data3",
                   h1("Majors Earnings"),
                   p("Select major category to see the Median level of earnings for majors in certain fields."),
                   
                   #place plot
                   plotOutput("displot3"),
                   
                   #Select Input
                   radioButtons("careerchoices3", label = h3("Career Choices"), choices = major_list)
                   
          ),
          
          tabItem( tabName = "Data4",
                   h1("Graduates vs Undergraduates"),
                   p("Select or type specfic majors to see earning differences between Undergraduates and Graduates."),
                   
                   #Select Plot
                   plotOutput("displot4"),
                   
                   #Place Input
                   selectInput("careerchoices4", label = h3("Career Choices"), choices = major$Major)
                   
                   
          )

        )
      )
    )
  )
)
