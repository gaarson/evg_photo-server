local config = require("lapis.config")
local secrets = require "secrets.conf"

config({"development", "production"}, {
  mysql = {
    host = "127.0.0.1",
    user = "root",
    password = secrets.db_pass,
    database = "evg_photo"
  }
})

config("development", {
  port = 8080,
  num_workers = 1,
})

config("production", {
  port = 80,
  host = "ezhukov.ru",

  num_workers = 2,
  code_cache = "on",
  daemon = "on",
  notice_log = "logs/notice.log",
  logging = "false",

  session_name = "evg_photo_server",
  email_enabled = true,
})
