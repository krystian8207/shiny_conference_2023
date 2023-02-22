library(shiny)
shinyApp(
  ui = fluidPage(
    modalDialogUI(
      modalId = "mdl",
      textInput("val", "Some Text"),
      button = NULL
    ),
    hr(),
    modalButtonUI(modalId = "mdl", "Open Modal From Here")
  ),
  server = function(input, output, session) {}
)
