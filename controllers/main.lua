local Photos = require "models.photos"
local to_json = require("lapis.util").to_json

return {
  before = function() 
    print("ASfsafsaf")
  end,
  GET = function() 
    local photos = Photos:getMainScreen() 
    return to_json(photos)
  end
}
