library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)


coffee_data <- data.frame(
  Bean = c("Ethiopia Yirgacheffe", "Colombia Supremo", "Sumatra Mandheling", "Brazil Cerrado"),
  Roast = c("Light", "Medium", "Dark", "Medium"),
  Acidity = c(8, 6, 3, 5),
  Body = c(4, 6, 9, 7),
  Rating = c(92, 88, 85, 87)
)

ui <- dashboardPage(
  dashboardHeader(title = "Coffee Brew Analytics"),
  dashboardSidebar(
    selectInput("roast", "Select Roast Level:", choices = unique(coffee_data$Roast))
  ),
  dashboardBody(
    fluidRow(
      infoBox("Avg Rating", mean(coffee_data$Rating), icon = icon("star")),
      plotOutput("beanPlot")
    )
  )
)

server <- function(input, output) {
  output$beanPlot <- renderPlot({
    filtered <- coffee_data %>% filter(Roast == input$roast)
    ggplot(filtered, aes(x = Bean, y = Rating, fill = Bean)) +
      geom_bar(stat = "identity") + theme_minimal() +
      labs(title = paste("Ratings for", input$roast, "Roast"))
  })
}

shinyApp(ui, server)