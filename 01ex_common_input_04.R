library(shiny)
library(shinyGizmo)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "type", "Type", inline = TRUE,
        choices = c("radioButtons", "checkboxGroupInput", "selectInput")
      ),
      textInput("input_id", "Input Id"),
      actionButton("add", "Add"),
      h2("Controllers"),
      div(id = "controllers"),
      actionButton("update", "Update values")
    ),
    mainPanel(
      h2("Values"),
      verbatimTextOutput("values")
    )
  )
)

server <- function(input, output, session) {

  observeEvent(input$add, {
    args <- list(
      inputId = input$input_id,
      label = "Choose letter",
      choices = letters[1:3],
      inline = TRUE
    )
    if (input$type == "selectInput") {
      args$inline <- NULL
    }
    insertUI(
      "#controllers",
      ui = commonInput("result", do.call(input$type, args))
    )
  })

  output$values <- renderPrint({
    input$update
    isolate({
      print(input$result)
    })
  })
}

shinyApp(ui, server)
