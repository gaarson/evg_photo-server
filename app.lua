local lapis = require("lapis")
local app = lapis.Application()

local respond_to = require ("lapis.application").respond_to

local main = require "controllers.main"
local feedback = require "controllers.feedback"

app:match('/api/main', respond_to(main))
app:match('/api/main/feedback', respond_to(feedback))

return app
