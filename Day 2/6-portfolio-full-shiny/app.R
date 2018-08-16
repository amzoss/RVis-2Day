#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Note: this is essentially a normal R script, so there are no code chunks

library(shiny)
library(tidyverse)

starwars_chars <- starwars %>% na.omit() %>% mutate(name=fct_reorder(as_factor(name),birth_year))

got <- read_csv("got_ratings.csv")


# Define UI for application that lays out input and output elements

ui <- 

  # We will reproduce the same layout as we used for flexdashboard.
  # the UI section isn't much like normal R code; it's basically just nested functions
  # and lists of elements, separated by commas
  
  #     function1(item1, function2(item2, item3, item4), function3(item5,...))
  
  # try building things one element at a time, slowly, and look at the errors for clues
  # most problems are parentheses and commas
  
  # Instructions:
  # 1. Create a page with a navigation bar using navbarPage()
  # 2. Add a title
  # 3. Add two tabs using tabPanel()
  #     a. one will be for Game of Thrones
  #     b. one will be for Star Wars
  # 4. For Game of Thrones, use a sidebarLayout()
  #     a. add the inputs to a sidebarPanel()
  #     b. add a plotOutput object to the mainPanel(), including an appropriate outputId
  # 5. For Star Wars, use a fluidPage()
  #     a. add two fluidRow() elements
  #     b. in the first row, add text instructions
  #     c. in the second row, add a splitLayout()
  #     d. in the splitLayout(), add two plotOutput() objects, one with a brush

  

# Define server logic required to draw the plots

server <- function(input, output) {
  
  # The server section will include all of the reactive code; it is all R code
  
  # we need to define four objects:
  # selectedData: same as previous
  # three renderPlot({}) objects, all saved to output$ using the outputIds specified
  # in the UI and including the appropriate input$inputIds, same as previous
  
}

# Run the application 
shinyApp(ui = ui, server = server)

