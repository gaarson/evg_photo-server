local assert_error = require("lapis.application").assert_error
local to_json = require("lapis.util").to_json

local Photos = require "models.photos"

return {
  before = function(self) 
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,

  OPTIONS = function(self) 
    
  end,

  POST = function(self)
    if self.params.newpic then 
      local file = self.params.newpic

      local success = assert_error(Photos:uploadPhoto(file))
      return { json = { success = success } }
    else 
      local info = self.params;

      local success = assert_error(Photos:setPhotoInfo(info))
      return { json = { success = info } }
    end 
  end 
}


