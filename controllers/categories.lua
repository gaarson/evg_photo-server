local assert_error = require("lapis.application").assert_error
local json_params = require("lapis.application").json_params
local to_json = require("lapis.util").to_json

local Categories = require "models.categories"

return {
  before = function(self)
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,

  OPTIONS = function(self) 
    
  end,

  GET = function(self)
    local list = assert_error(Categories:getCategories(self.params.id))
    return { json = list }
  end,

  POST = json_params(function(self) 
    local file = self.params.file
    local info = self.params

    local success = assert_error(Categories:uploadCategory(file, info))
    return { json = success }
  end),
}
