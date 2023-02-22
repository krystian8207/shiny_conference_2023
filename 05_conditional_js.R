library(shiny)
library(shinyGizmo)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  conditionalJS(
    condition = "input.submit > 0",
    jsCall = jsCalls$animateVisibility(when = FALSE),
    tags$div(
      class = "survey-container",
      tags$h1("shinyConf 2023 Survey", class = "survey-title"),
      hr(),
      commonInput("result", textInput("name", "Your Name", placeholder = "Type Name here")),
      hr(),
      commonInput("result", radioButtons("rating", "How did you like shinyConf2023?", choices = 1:10, selected = "", inline = TRUE)),
      hr(),
      commonInput(
        "result",
        conditionalJS(
          checkboxGroupInput(
            "fav_topics", "Which topics where you interested in the most (choose max two)",
            choices = c(
              "Shiny in life science", "Shiny 4 Good", "Learning Communities", "Shiny Modules",
              "Best Practices", "Shiny + Javascript", "Shiny in Business", "Shiny in Local Governments"
            ),
            inline = TRUE
          ),
          condition = "input.fav_topics.length == 2",
          jsCall = jsCalls$custom(
            true = JS("$(this).find('input:not(:checked)').prop('disabled', true)"),
            false = JS("$(this).find('input').prop('disabled', false)")
          )
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
      modalDialogUI(
        "comment_modal",
        textArea("comment", label = "Comment", value = ""),
        button = modalButtonUI("comment_modal", "Any additional comments (optional)", width = "300px"),
        footer = tagList(
          commonInput(
            "result",
            valueButton("confirm_comment", "Close", "[data-id='comment']", `data-dismiss` = "modal", `data-bs-dismiss` = "modal")
          )
        )
      ),
      hr(),
      conditionalJS(
        actionButton("submit", "Submit", width = "90%", class = "survey-submit"),
        condition = "!!input.result && !!input.result.name.value && !!input.result.rating.value",
        jsCall = jsCalls$disable(when = FALSE)
      )
    )
  ),
  conditionalJS(
    condition = "input.submit > 0",
    jsCall = jsCalls$animateVisibility(when = TRUE, delay = 500),
    h1(class = "submitted sg_hidden", "Thank you")
  )
)

server <- function(input, output, session) {
  observeEvent(input$submit, {
    print(input$result)
  })
}

shinyApp(ui = ui, server = server)
