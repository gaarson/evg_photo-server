local assert_error =require("lapis.application").assert_error
local to_json = require("lapis.util").to_json

local Photos = require "models.photos"

return {
  before = function(self) 
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,
  GET = function(self)
    local category_id = self.params.id
    local photos = assert_error(Photos:getGalleryByCategory(category_id))

    return { json = photos }
  end
}
