library(shinydashboard)
library(shiny)
library(dplyr)
library(readr)
library(stringr)
library(tidyr)
library(httr)
library(curl)

ui <- fluidPage(
  titlePanel(
    h1("Redirect checkR", align = "center"), windowTitle = "Redirect CheckR"),
  h4("This simple app just show you the final destination of an URL, helping you
     to know the servers you're going through", align = "center"),
  textInput("urlInput", "Enter URL", value = "", placeholder = "google.es"),
  actionButton("submitButton", "Submit"),
  verbatimTextOutput("resultOutput"),
  h5("Made by ", a("Mario Yanes", href = "https://github.com/myanesp"), align = "center"),
  h5(a("Source code", href = "https://github.com/myanesp/redirect-checkR"), icon("github", lib = "font-awesome"), align = "center")
)

server <- function(input, output) {
  
  output$resultOutput <- renderPrint({
    req(input$submitButton)
    
    url <- input$urlInput
    
    result <- processUrl(url)
    
    return(result)
  })
  
  
  processUrl <- function(url) {
    response <- GET(url, config = list(followlocation = FALSE))
    
    all_headers <- response$all_headers
    final_url <- response$url
    
    if(response$status_code == 404){
      cat("Not found. Maybe you just put the wrong URL?")
      
    } else {
      
      output_text <- paste("This link redirects to this final url:", final_url, "\n\n")
      
      if (!is.null(all_headers)) {
        
        for (i in seq_along(all_headers)) {
          output_text <- paste(output_text, "Redirection", i, ":\n")
          
          status <- all_headers[[i]]$status
          output_text <- paste(output_text, "Status:", status, "\n")
          
          if(status == 200) {
            output_text <- paste(output_text, "Location:", final_url, "\n")
          } else {
            location <- all_headers[[i]]$headers$location
            output_text <- paste(output_text, "Location:", location, "\n")
          }
          output_text <- paste(output_text, "\n")
        }
      } else {
        output_text <- paste(output_text, "No redirections\n")
      }
      
      return(output_text)
    }
  }
}


runApp(list(ui = ui, server = server), port = 3838, host = "0.0.0.0")