library(shiny)
shinyApp(
  ui = fluidPage(
    textAreaInput(inputId = "txt1", label = "textAreaInput (sends value to server)"),
    hr(),
    tags$label("textarea with provided id (sends value to server)"), br(),
    tags$textarea(id = "txt2"),
    hr(),
    tags$label("textarea id provided as data-id attribute (no value sent to the server)"), br(),
    tags$textarea(`data-id` = "txt3"),  br(),
    valueButton("val", "Take textarea value", '[data-id="txt3"]', attribute = "value")
  ),
  server = function(input, output, session) {
    observeEvent(input$txt1, print(input$txt1))
    observeEvent(input$txt2, print(input$txt2))
    observeEvent(input$txt3, print(input$txt3))
    observeEvent(input$val, print(input$val))
  }
)
