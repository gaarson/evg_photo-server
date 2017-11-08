local lapis = require("lapis")

local capture_errors_json =require("lapis.application").capture_errors_json
local to_json = require("lapis.util").to_json

local app = lapis.Application()

local respond_to = require ("lapis.application").respond_to

local main = require "controllers.main"
local feedback = require "controllers.feedback"
local photos = require "controllers.photos"

app:match('/api/main', respond_to(main))
app:match('/api/photos', respond_to(photos))
app:match('/api/main/feedback', respond_to(feedback))

app:get('/*', function(self) 
  print(to_json(io))
  return 'alll'
end)
app:get('/', function(self) 
  local file = io.open('/Users/gaarson/programming/web/projects/evg_photo/server/build/index.html', 'w')
  print(to_json(file:read()))
  return file
end)

return app
