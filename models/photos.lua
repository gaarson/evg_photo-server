local to_json = require("lapis.util").to_json
local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")

local split = require "sides.split"

Photos.img_path = "./static/img/" 

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

function Photos:getGalleryByCategory(category_id)
  return self:select("where category_id=?", category_id)
end

function Photos:uploadPhoto(file, info)

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

  local upladed = io.open(self.img_path .. filePath, "w")

  upladed:write(file.content)
  upladed:close()

  return photo
end

return Photos
