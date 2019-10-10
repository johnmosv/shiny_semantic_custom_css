library(shiny)
library(shiny.semantic)
library(semantic.dashboard)


# Need to add custom styles from semantic-ui 2.3.0 to styles/ for this to work
# I have copied from smentic-ui github page into folder Semantic-UI-230
options(shiny.custom.semantic = "styles/", 
        shiny.minified = FALSE) # use semantic.css instead of semantic.min.css
#options(shiny.custom.semantic = NULL) # get semantic css from api if NULL

ui <- shinyUI(
  semanticPage(
    title = "Website", theme = NULL,
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    div(style="margin-left: 210px",
        p("website content"))
  )
)

server <- function(input, output) {
  
}

shinyApp(ui, server)
