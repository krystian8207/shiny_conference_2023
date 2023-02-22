library(shiny)
shinyApp(
  ui = fluidPage(
    modalDialogUI(
      modalId = "mdl",
      textInput("val", "Some Text"),
      button = modalButtonUI("mdl", "Open Modal")
    )
  ),
  server = function(input, output, session) {}
)
