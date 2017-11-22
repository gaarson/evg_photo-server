local to_json = require("lapis.utils").to_json
local Model = require("lapis.db.model").Model
local Categories = Model:extend("photo")

local split = require "sides.split"

function Categories:getCategories() 
  return self:select()
end 

function Categories:uploadCategory(file, info) 
  local type = file["content-type"]
  local photo = self:create({
      title = info.name,
      category_id = info.category_id,
      caption = info.caption
    }, "id")

  local mimeType = split(type, "/")[2]
  local filePath = info.category_id 
                    .. "/" 
                    .. info.name .. "_" 
                    .. photo.id
                    .. "." .. mimeType

  self:update(
    {src = "/img/" .. filePath}, 
    { id = photo.id }
  )

  local upladed = io.open(self:img_path .. filePath, "w")

  upladed:write(file.content)
  upladed:close()

  return photo
end

return Categories
