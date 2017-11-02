local config = require("lapis.config")

config({"development", "production"}, {
  port = 3030,
  email_enabled = true,
  mysql = {
    host = "127.0.0.1",
    user = "root",
    password = "",
    database = "evg_photo"
  }
})

config("production", {
  email_enabled = true,
  postgres = {
    database = "my_app_prod"
  }
})
