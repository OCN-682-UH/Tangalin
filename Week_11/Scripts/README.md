# Tangalin

A collection of R projects by Natalia Tangalin.

## Shiny Apps

### Da Best or Broke Da Mouth Hawaiian Survey
A fun survey about Hawaiian islands and local food! 

🔗 **Live App:** [https://ainacology.shinyapps.io/DaBest_app/](https://ainacology.shinyapps.io/DaBest_app/)

```r
# This is a Shiny web application.
# https://ainacology.shinyapps.io/DaBest_app/

library(shiny)
library(rsconnect)

## Define choices
Hawaiian_Islands <- c("Niihau", "Kauai", "Oahu", "Molokai", "Maui", "Lanai", "Big Island")
local_food <- c("spam musubi", "manapua", "saimin", "loco moco", "malasadas", "poke")

# UI
ui <- fluidPage(
  titlePanel("Da Best or Broke Da Mouth Hawaiian Survey"),
  sidebarLayout(
    sidebarPanel(
      selectInput("island", "What's the best Hawaiian Island?", choices = Hawaiian_Islands),
      radioButtons("food", "What's is da most broke da mouth local food? ", choices = local_food)
    ),
    mainPanel(
      textOutput("selection")
    )
  )
)

# Server
server <- function(input, output) {
  output$selection <- renderText({
    paste("You chose", input$island, "as the best island and", input$food, "as your favorite local food.")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
```

## TidyTuesday Projects

### 2025-12-02: Zurich's Exploding Snowman (Böögg)
Analysis of whether the Böögg burning ceremony predicts summer weather. 

## About
Learning R, data visualization, and Shiny apps!  🌺