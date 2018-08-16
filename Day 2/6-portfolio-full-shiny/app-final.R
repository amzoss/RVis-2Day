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

starwars_chars <- starwars %>% na.omit() %>% mutate(name=fct_reorder(as_factor(name),birth_year))

got <- read_csv("got_ratings.csv")

# Define UI for application that lays out input and output elements

ui <- 

  # using navbarPage to get navigation bar at the top
  navbarPage(
  
  # first item: main title appearing in the navigation bar
  title = "R Visualization Portfolio with Shiny",
  
  # Page 1: Game of Thrones NYT quadrant chart
  # first argument is the text that appears in the navbar; 
  # next argument is what fills the rest of the page (in this case a sidebar layout)
  
  tabPanel("Game of Thrones",
           sidebarLayout(
             
             # the sidebar includes the input widgets
             sidebarPanel(
               selectInput("gotcolor", "Select Variable for Color:", c("gender","loyalty")),
               sliderInput("labelsize", "Change Label Font Size:", 1,10,4, step=1)),
             
             # the main panel includes the outputs, defined in the server
             mainPanel(
               plotOutput(outputId = "gotPlot")
             )
             ) 
           ),
  
  # Page 2: Star Wars characters, dual interactive highlight charts
  # first argument is the text that appears in the navbar;
  # next argument is what fills the rest of the page (in this case, a fluid page)
  
  tabPanel("Star Wars",
           fluidPage(
             
             # first row is just a text element stretching across entire width
             fluidRow(p(em("Instructions: Drag a box on the left plot to highlight points on the right plot."))),
             
             # second row has two equal-sized elements: the two charts
             fluidRow(
               splitLayout(
                 
                 # the first chart has a brush defined; 
                 # the brush talks to the selectedData() function in the server
                 plotOutput("swPlot1", brush = brushOpts(id = "plot1_brush")),
                 plotOutput("swPlot2")
               )
             )
           ))
)

# Define server logic required to draw the plots
server <- function(input, output) {
  
  # the Game of Thrones plot uses the drop-down for color and the slider for text size 
  output$gotPlot <- renderPlot({
    ggplot(got, aes_string(x="moral",y="physical", color=input$gotcolor)) + 
       scale_y_reverse(lim=c(1,0)) +
       scale_x_continuous(limits=c(0,1)) +
       geom_hline(yintercept=.5) +
       geom_vline(xintercept=.5)+ 
       geom_point(aes())  + 
       geom_text(aes(label=label), nudge_y = -.025, show.legend = FALSE, 
                 size=as.numeric(input$labelsize)) +
       theme_bw() +
       annotate(geom = "text", x=c(.5,.5,0,1), y=c(1,0,.48,.52), 
                label=c("Ugly","Beautiful","Evil","Good"))}#, 
       #width=8*96, height=7*96, res=96
    )
  
  # a special reactive function responds to the Star Wars plot brush
  # and creates a subset of the full dataset for highlighting
  selectedData <- reactive({
    brushedPoints(starwars_chars, input$plot1_brush)
  })
  
  # the first plot doesn't respond to any of the inputs directly;
  # the brush makes it an input itself
  output$swPlot1 <- renderPlot({
    ggplot(starwars_chars, aes(birth_year, name)) +
      geom_point(size=5)
  })
  
  # the second plot uses the selectedData subset to add some red points on top of the black
  # note: when you use a reactive object, you have to include () after the name 
  # (e.g., "selectedData()")
  output$swPlot2 <- renderPlot({
    ggplot(starwars_chars, aes(height,mass)) +
      geom_point(size=5) + 
      geom_point(data=selectedData(), aes(height,mass), color="red", size=5) +
      scale_x_continuous(limits=c(min(starwars_chars$height),(max(starwars_chars$height)))) +
      scale_y_continuous(limits=c(min(starwars_chars$mass),(max(starwars_chars$mass))))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

