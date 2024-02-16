## Redirect Checker

This is a simple tool written in R for test and trace the redirects made by an URL.
It can be useful if you want to see the final URL for a shorten link (maybe is it suspicious?),
or to get rid of the trackers between your click in a website and the actual final URL.

### Features
- Shows the final destination of an URL.
- Display all the redirections and response codes for each one

### How to use: two options
1. Create the function on your local environment

Just download the repository and execute `get_redirect.R`. Then, you can
use the function `get_redirections(url)`, being `url` the link you want to explore.

2. Selfhost the tool with Docker

If you want to use this tool on devices that does not have R, such as phones or tablets,
or even because you want to use without having to execute the function every time, 
you can self host it through Docker. Clone the repository, change the mapped ports 
if you need so, and execute `docker compose up -d` and navigate to the IP of the server
and the port 3838 or the one you chose. 

### To come
- Option to remove tracking parameters from final URL
- Improve UI