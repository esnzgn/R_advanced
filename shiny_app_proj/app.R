library(shiny)
library(palmerpenguins)
library(DT)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Penguin Dashboard"),
  sidebarLayout(
    sidebarPanel(
          fluidRow(column(5, selectInput("species", "Choose Species:",
                      choices = unique(na.omit(penguins$species)))),
                   column(5, selectInput("sex", "Choose Sex:",
                                       choices = unique(na.omit(penguins$sex))))
                    ), br(),
          fluidRow(column(10, selectInput("island", "Choose Island:",
                            choices = unique(na.omit(penguins$island)))))
    ),
    mainPanel(
      plotOutput("filtered_plot"),
      br(), br(),
      h2(textOutput("summary_text")),
      br(), br(),
      downloadButton("download_data", "Download CSV"),
      DTOutput("filtered_table")
    )
  )
)

server <- function(input, output){
  filtered_data <- reactive({
    penguins %>%
      na.omit() %>% 
      filter(species == input$species,
             island  == input$island,
             sex == input$sex)
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
  output$summary_text <- renderText({
    tmp_react <- filtered_data()
    mean(tmp_react$body_mass_g, na.rm = T) %>%
    paste0("You selected ", input$species, "penguin. Sample size: ",
           nrow(filtered_data()), ", and the body mass is: ", round(., digits = 2))
  })
  output$download_data <- downloadHandler(
    filename = function() {
      paste0("penguine_", input$species, ".csv")
    },
    content = function(file){
      write.csv(filtered_data(), file, row.names = F)
    }
  )
  
  
}

shinyApp(ui, server)