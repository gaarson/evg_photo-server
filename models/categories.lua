local to_json = require("lapis.utils").to_json
local Model = require("lapis.db.model").Model
local Categories = Model:extend("photo")

local split = require "sides.split"

function Categories:getCategories() 
  return self:select()
end 

function Categories:uploadCategory(file, info) 

end
