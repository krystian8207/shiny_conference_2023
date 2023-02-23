library(shiny)

question <- checkboxGroupInput(
  "fav_topics", "Which topics were you interested in the most (choose max two)",
  choices = c(
    "Shiny in life science", "Shiny 4 Good", "Learning Communities", "Shiny Modules",
    "Best Practices", "Shiny + Javascript", "Shiny in Business", "Shiny in Local Governments"
  ),
  inline = TRUE
)

ui <- fluidPage(
  conditionalJS(
    question,
    condition = "input.fav_topics.length == 2",
    jsCall = jsCalls$custom(
      true = JS("$(this).find('input:not(:checked)').prop('disabled', true)"),
      false = JS("$(this).find('input').prop('disabled', false)")
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
