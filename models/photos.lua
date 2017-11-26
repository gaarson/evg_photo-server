local to_json = require("lapis.util").to_json
local db = require "lapis.db"
local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")

local split = require "utils.split"

Photos.img_path = "./build/img/" 

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

function Photos:getPhotos(category_id)
  if category_id then 
    return self:select("where category_id=?", category_id)
  else 
    return self:select()
  end
end

function Photos:uploadPhoto(file, info)
  local type = file["content-type"]
  local mimeType = split(type, "/")[2]
  
  local photo = self:create {
      title = info.name,
      category_id = info.category_id,
      caption = info.caption
    }
  local filePath = info.category_id 
                    .. "/" 
                    .. info.name .. "_" 
                    .. photo.id
                    .. "." .. mimeType

  db.query("UPDATE photos SET src = ? WHERE id = ?", 
    "/img/" .. filePath, photo.id)

  local upladed = io.open(self.img_path .. filePath, "w")

  upladed:write(file.content)
  upladed:close()

  return photo
end

function Photos:deletePhoto(photo_id) 
  local deleted_photo = self:delete({id = photo_id})
  
  return photo
end


return Photos
