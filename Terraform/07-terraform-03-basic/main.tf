provider "heroku" {
}

locals {
  instance_count = {
    stage = 1
    prod = 2
  }
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
    quantity = local.instance_count[terraform.workspace]
    size = "free"
    type = "web"
    lifecycle {
    create_before_destroy = true
  }
}


resource "heroku_formation" "test-2" {
    app_id = heroku_app.test.uuid
    quantity = 1
    size = each.value.instance_type
    for_each = var.instances
    type = "web"
}


