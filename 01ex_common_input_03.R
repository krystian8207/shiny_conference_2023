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
  controller_ids <- reactiveVal(NULL)

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
      ui = do.call(input$type, args)
    )
    controller_ids(c(controller_ids(), input$input_id))
  })

  output$values <- renderPrint({
    input$update
    isolate({
      print(reactiveValuesToList(input)[controller_ids()])
    })
  })
}

shinyApp(ui, server)
