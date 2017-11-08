local config = require("lapis.config")

local body_size = "50m"


config({"development", "production"}, {
  port = 3030,
  body_size = body_size,
  email_enabled = true,
  mysql = {
    host = "127.0.0.1",
    user = "root",
    password = "rustislav",
    database = "evg_photo"
  }
})

config("production", {
  email_enabled = true,
  mysql = {
    host = "127.0.0.1",
    user = "root",
    password = "rustislav",
    database = "evg_photo"
  }
})
