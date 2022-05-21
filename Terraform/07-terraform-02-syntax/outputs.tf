output "stack" {
 value = heroku_app.test.stack
 description = "The application stack is what platform to run the application in."
}

output "output_unique_id" {
 value = heroku_app.test.uuid
 description = "The unique UUID of the Heroku."
}

output "region" {
 value = heroku_app.test.region
 description = "The region that the app should be deployed in."
}

output "web_url" {
 value = heroku_app.test.web_url
 description = "The web (HTTP) URL that the application can be accessed at by default."
}


