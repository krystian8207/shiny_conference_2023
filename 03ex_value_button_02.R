library(shiny)
shinyApp(
  ui = fluidPage(
    textAreaInput(inputId = "txt1"),
    tags$textarea(id = "txt2"),
    tags$textarea(`data-id` = "txt3"),
    valueButton("val", "Take textarea value", '[data-id="txt"]', attribute = "value")
  ),
  server = function(input, output, session) {
    observeEvent(input$txt1, print(input$txt1))
    observeEvent(input$txt2, print(input$txt2))
    observeEvent(input$val, print(input$val))
  }
)
