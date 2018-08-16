#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

county_map <- map_data("county","california")

county_map <- county_map %>% group_by(subregion) %>% mutate(rand = runif(1))

minLong <- round(min(county_map$long),2)

maxLong <- round(max(county_map$long),2)

minLat <- round(min(county_map$lat),2)

maxLat <- round(max(county_map$lat),2)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Projections Exercise"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput(
           "proj",
           label="Projection",
           choices=list("Mercator"="mercator",
                        "Sinusoidal"="sinusoidal",
                        "Azequalarea"="azequalarea"),
           selected="sinusoidal"
         ),
         sliderInput("longslider",
                     label="Zoom in on Longitude",
                     min=minLong,
                     max=maxLong,
                     value=c(minLong,maxLong),
                     step = 0.5),
         sliderInput("latslider",
                     label="Zoom in on Latitude",
                     min=minLat,
                     max=maxLat,
                     value=c(minLat,maxLat),
                     step = 0.5)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
   output$distPlot <- renderPlot({
     ggplot(county_map) + 
       geom_polygon(aes(x = long,
                        y = lat,
                        group=group,
                        fill=rand)) +
       coord_map(projection = input$proj, 
                 xlim=c(input$longslider[1],input$longslider[2]),
                 ylim=c(input$latslider[1],input$latslider[2]))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

