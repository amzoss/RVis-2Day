#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)

DF <- read_csv("all_participants.csv")

DF$level <- factor(DF$level,
                   levels=c("Element","Cluster","Graph"),
                   ordered=TRUE)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Bootstrapping"),
  
  # Sidebar with a slider input for number of participants 
  sidebarLayout(
    sidebarPanel(
      sliderInput("subsample",
                  "Random subsample:",
                  min = 1,
                  max = 60,
                  value = 30)
    ),
    
    # Show a plot
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

# Define server logic required to draw the visualization
server <- shinyServer(function(input, output) {
  
  
  output$distPlot <- renderPlot({
    
    results <- data.frame()
    for (trial in 1:10){
      sampled_IDs <- DF %>% select(V1.Demo.ResponseID) %>% unique() %>% sample_n(input$subsample)
      sampled_subset <- DF[!(DF$V1.Demo.ResponseID %in% sampled_IDs$V1.Demo.ResponseID),]
      
      measures <- sampled_subset %>% 
        filter(is_unfam == 0 & both_pos >= 0 & both_neg >= 0) %>% 
        group_by(measure, level) %>% 
        summarise(ratio=sum(both_pos)/sum(both_neg),
                  num_responses=n(),
                  trial=trial) %>% 
        collect
      
      results <- bind_rows(results, measures)
      
    }
    
    measures_med <- results %>% 
      group_by(measure) %>% 
      summarise(med1=median(ratio)) %>%
      collect
    
    ordered_measures <- measures_med %>%
      arrange(med1) %>%
      select(measure) %>%
      collect
    
    results$measure = factor(results$measure, 
                             levels=as.vector(ordered_measures$measure),
                             ordered=TRUE)       
    
    ggplot(data = results) + 
      geom_boxplot(aes(y=ratio,x=measure,color=level)) +
      scale_y_log10() +
      coord_flip() +
      geom_hline(yintercept=1) +
      theme_bw()
    
    
  })
})

# Run the application 
shinyApp(ui = ui, server = server)

