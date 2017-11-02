local lapis = require("lapis")
local capture_errors_json =require("lapis.application").capture_errors_json

local app = lapis.Application()

local respond_to = require ("lapis.application").respond_to

local main = require "controllers.main"
local feedback = require "controllers.feedback"
local photos = require "controllers.photos"

app:match('/api/main', respond_to(main))
app:match('/api/main/feedback', respond_to(feedback))
app:match('/api/photos', respond_to(photos))

return app
