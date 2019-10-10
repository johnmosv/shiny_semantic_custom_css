library(shiny)
library(shiny.semantic)
library(semantic.dashboard)

options(shiny.custom.semantic = "styles/", shiny.minified = FALSE)
#options(shiny.custom.semantic = NULL, shiny.minified = NULL)
dev <- TRUE

### I have not gotten this to work (using custon_dashboardPage). Need to make a custon_semanticPage as well and include the link in the already created head tag
# I think it is better to create a copy of the semantic.theme.css, rename it semantic.css, set options(shiny.custom.semantic = "styles/", shiny.minified = FALSE), and add custom css there. need to figure out how to add favicons which will not be loaded properly....


# custom_dashboardPage ----------------------------------------------------

custom_dashboardPage <- function(header, sidebar, body, title = "", suppress_bootstrap = TRUE, theme = NULL, 
                                 custom_css_in_www = "custom.css") 
{
  
  # Copied from: https://rdrr.io/github/Appsilon/semantic.dashboard/src/R/constants.R
  sidebar_js <- "
  /* Code below is needed to trigger visibility on reactive Shiny outputs. */
  /* Thanks to that users do not have to set suspendWhenHidden to FALSE.   */
  var previous_tab;
  $('#uisidebar .item').tab({
    onVisible: function(target) {
      if (previous_tab) {
        $(this).trigger('hidden');
      }
      $(window).resize();
      $(this).trigger('shown');
      previous_tab = this;
    }
  });

  $('#uisidebar')
    .sidebar({
      context: $('.pusher'),
      transition: 'push',
      dimPage: false,
      closable: false
    })
    .sidebar('attach events', '#toggle_menu');
"
  
  
  
  if (suppress_bootstrap) 
    shiny::suppressDependencies("bootstrap")
  if (is.null(sidebar)) 
    header$children[[1]] <- NULL
  shiny.semantic::semanticPage(
    shiny::tags$head(
      shiny::tags$link(rel = "stylesheet", type = "text/css", href = custom_css_in_www)
    ),
    header, sidebar, body, 
    shiny::tags$script(sidebar_js), # see above
    
    title = title, theme = theme)
  
}

#custom_dashboardPage()


# App ---------------------------------------------------------------------


custom_cssUI <- function(id) {

  ns <- NS(id)
  tagList()
  
}

custom_css <- function(input, output, session){

  ns = session
  
}




# Dev ---------------------------------------------------------------------


if(dev) {
 
  header = dashboardHeader(
    # the href cant be put in the header because it occurs inside the semantic-range script tag. 
    # so it is probably looking for the file at their api.
    # tags$head(
    #   tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    # )
  )
  sidebar = dashboardSidebar()
  body = dashboardBody(
    custom_cssUI("test")
  )
  # The tag should be included in dashboardPage (like in semanticPage. Need to make a custom function which can include arguments to semanticPage as semanticPage is called by dashboardPage)
  ui = dashboardPage(header, sidebar, body)
  
  server <- function(input, output, session){
    callModule(custom_css, "test")
  }
    
  shinyApp(ui, server)

}



