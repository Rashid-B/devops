provider "heroku" {
}

resource "heroku_app" "test" {
  name   = "case-heroku"
  region = "us"
  stack = "heroku-20" 
}

resource "heroku_build" "test" {
  app_id     = heroku_app.test.uuid
  
  source {
    path = "./app"
  }
}

resource "heroku_formation" "test" {
    app_id = heroku_app.test.uuid
    quantity = 1
    size = "free"
    type = "web"
}


