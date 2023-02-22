library(shiny)
library(shinyGizmo)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h2("Questions"),
      textInput("name", "Name"),
      hr(),
      radioButtons("fav_pet", "Favourite Pet", choices = c("dog", "cat", "rabbit"), inline = TRUE),
      radioButtons("fav_fruit", "Favourite Fruit", choices = c("apple", "pear", "cherry"), inline = TRUE),
      radioButtons("fav_vegetable", "Favourite Vegetable", choices = c("carrot", "pepper", "broccoli"), inline = TRUE),
      actionButton("update", "Update Values")
    ),
    mainPanel(
      h2("Values"),
      verbatimTextOutput("values")
    )
  )
)

server <- function(input, output, session) {
  output$values <- renderPrint({
    input$update
    isolate({
      print(
        reactiveValuesToList(input)[c("name", "fav_pet", "fav_fruit", "fav_vegetable")]
      )
    })
  })
}

shinyApp(ui, server)
