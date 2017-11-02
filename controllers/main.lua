local assert_error =require("lapis.application").assert_error
local Photos = require "models.photos"

return {
  before = function(self) 
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,
  GET = function() 
    local photos = assert_error(Photos:getMainScreen())
    return { json = photos }
  end
}
