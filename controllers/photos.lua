local assert_error = require("lapis.application").assert_error
local to_json = require("lapis.util").to_json

local Photos = require "models.photos"

return {
  before = function(self) 
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,
  POST = function(self)
    print(to_json(self.params))
    return {
      json = {test = "test"}
    }
  end
}


