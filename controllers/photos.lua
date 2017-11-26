local assert_error = require("lapis.application").assert_error
local json_params = require("lapis.application").json_params
local to_json = require("lapis.util").to_json

local Photos = require "models.photos"

return {
  before = function(self) 
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,

  OPTIONS = function(self) 
    
  end,

  GET = function(self) 
    local photos = assert_error(Photos:getPhotos())
    return { json = photos } 
  end,

  POST = json_params(function(self)
    local file = self.params.file
    local info = self.params

    local success = assert_error(Photos:uploadPhoto(file, info))
    return { json = success }
  end),
}


