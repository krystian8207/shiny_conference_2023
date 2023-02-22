library(shiny)
library(shinyGizmo)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h2("Questions"),
      commonInput("result", textInput("name", "Name")),
      hr(),
      commonInputs(
        "result",
        radioButtons("fav_pet", "Favourite Pet", choices = c("dog", "cat", "rabbit"), inline = TRUE),
        radioButtons("fav_fruit", "Favourite Fruit", choices = c("apple", "pear", "cherry"), inline = TRUE),
        radioButtons("fav_vegetable", "Favourite Vegetable", choices = c("carrot", "pepper", "broccoli"), inline = TRUE),
        ignoreIds = "fav_fruit"
      ),
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
        input$result
      )
    })
  })
  observeEvent(input$name, {
    print(input$name)
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)
