library(httr)
library(curl)
library(stringr)

get_redirections <- function(url) {
  response <- GET(url, config = list(followlocation = FALSE))
  
  all_headers <- response$all_headers
  final_url <- response$url
  
  if(response$status_code == 404){
    cat("Not found. Maybe you just put the wrong URL?")
  } else {
    cat("This link redirects to this final url: ", final_url, "\n")
    cat("\n")
    cat("You can see the full tracelog just right here:", " \n\n")
    
    if (!is.null(all_headers)) {
      
      for (i in seq_along(all_headers)) {
        cat("Redirection", i, ":\n")
        
        status <- all_headers[[i]]$status
        cat("Status:", status, "\n")
        
        if(status == 200) {
          cat("Location:", final_url, "\n")
        } else {
          location <- all_headers[[i]]$headers$location
          cat("Location:", location, "\n")
        }
        cat("\n")
      }
    } else {
      cat("No redirections\n")
    }
  }
}

get_redirections(url)

response <- GET(url, config = list(followlocation = FALSE))

all_headers <- response$all_headers
final_url <- response$url

