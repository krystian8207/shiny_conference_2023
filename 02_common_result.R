library(shiny)
library(shinyGizmo)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  conditionalPanel(
    condition = "input.submit == 0",
    tags$div(
      class = "survey-container",
      tags$h1("shinyConf 2023 Survey", class = "survey-title"),
      hr(),
      commonInput(
        "result",
        textInput("name", "Your Name", placeholder = "Type Name here")
      ),
      hr(),
      commonInput(
        "result",
        radioButtons("rating", "How did you like shinyConf2023?", choices = 1:10, selected = "", inline = TRUE)
      ),
      hr(),
      commonInput(
        "result",
        checkboxGroupInput(
          "fav_topics", "Which topics were you interested in the most (choose max two)",
          choices = c(
            "Shiny in life science", "Shiny 4 Good", "Learning Communities", "Shiny Modules",
            "Best Practices", "Shiny + Javascript", "Shiny in Business", "Shiny in Local Governments"
          ),
          inline = TRUE
        )
      ),
      hr(),
      commonInput(
        "result",
        vsCheckboxInput(
          "fav_talks", "Choose your favourite talks",
          placeholder = "Select day and talks",
          choices = list(
            day1 = c("Talk A", "Talk B"),
            day2 = c("Talk C", "Talk D", "Talk E", "Talk F"),
            day3 = c("Talk G", "Talk H", "Talk J")
          ),
          choicesLabels = c("day1" = "Day 1", "day2" = "Day 2", "day3" = "Day 3")
        )
      ),
      hr(),
      actionButton("comment_modal", "Any additional comments (optional)", width = "300px"),
      hr(),
      conditionalPanel(
        actionButton("submit", "Submit", width = "90%", class = "survey-submit"),
        condition = "!!input.result && !!input.result.name.value && !!input.result.rating.value",
        style = "display: none;"
      )
    )
  ),
  conditionalPanel(
    condition = "input.submit > 0",
    h1(class = "submitted", "Thank you"),
    style = "display: none;"
  )
)

server <- function(input, output, session) {
  observeEvent(input$comment_modal, {
    showModal(
      modalDialog(
        commonInput(
          "result",
          textAreaInput("comment", label = "Comment", value = "")
        ),
        footer = modalButton("Close")
      )
    )
  })

  observeEvent(input$submit, {
    print(input$result)
  })
}

shinyApp(ui = ui, server = server)
