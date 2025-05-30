library(shiny)
library(palmerpenguins)
library(DT)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Penguin Dashboard"),
    sidebarLayout(
      sidebarPanel(
        selectInput("species", "Choose Species:",
                    choices = unique(na.omit(penguins$species))),
      ),
      mainPanel(
        plotOutput("filtered_plot"),
        DTOutput("filtered_table")
      )
    )
  )

server <- function(input, output){
  filtered_data <- reactive({
    penguins %>%
      na.omit() %>% 
      filter(species == input$species)
  })
  output$filtered_table <- renderDT({
    filtered_data()
  })
  output$filtered_plot <- renderPlot({
    filtered_data() %>% 
      ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
      geom_point(aes(colour = sex)) +
      theme_minimal()
  })
}

shinyApp(ui, server)