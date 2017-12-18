local config = require("lapis.config")
local secrets = require "secrets.conf"

local body_size = "50m"


config("development", {
  port = 3030,
  body_size = body_size,
  email_enabled = true,
  mysql = {
    host = "127.0.0.1",
    user = "root",
    password = secrets.db_pass,
    database = "evg_photo"
  }
})

config("production", {
  port = 80,
  email_enabled = true,
  mysql = {
    host = "127.0.0.1",
    user = "root",
    password = secrets.db_pass,
    database = "evg_photo"
  }
})
