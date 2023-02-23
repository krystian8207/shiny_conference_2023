library(shiny)
shinyApp(
  ui = fluidPage(
    textArea(inputId = "txt1", label = "textAreaInput (sends value to server)", value = ""),
    valueButton("val", "Take textarea value", '[data-id="txt1"]', attribute = "value")
  ),
  server = function(input, output, session) {
    observeEvent(input$txt1, print(input$txt1))
    observeEvent(input$val, print(input$val))
  }
)
