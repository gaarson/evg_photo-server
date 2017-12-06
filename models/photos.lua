local to_json = require("lapis.util").to_json
local db = require "lapis.db"
local magick = require "magick"
local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")

local split = require "utils.split"

Photos.img_path = "./build/img/" 

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

function Photos:getPhoto(id) 
  local photo = self:find(id)
  
  return photo
end 

function Photos:getPhotos()
  local photos = {}

  if category_id then 
    photos = self:select("where category_id=?", category_id)
  else 
    photos = self:select(nil, nil, {fields = "src, id, caption, title"})
  end

  return photos
end

function Photos:uploadPhoto(file, info)
  local type = file["content-type"]
  local mimeType = split(type, "/")[2]
  
  local photo = self:create {
      title = info.name,
      is_main = info.main,
      category_id = info.category_id,
      caption = info.caption
    }
  local thumbPath = info.category_id 
                    .. "/" 
                    .. info.name .. "_" 
                    .. photo.id
                    .. "_thumb"
                    .. "." .. mimeType
  local filePath = info.category_id 
                    .. "/" 
                    .. info.name .. "_" 
                    .. photo.id
                    .. "." .. mimeType

  db.query("UPDATE photos SET src = ?, thumbnail = ? WHERE id = ?", 
    "/img/" .. filePath, "/img/" .. thumbPath, photo.id)

  local upladed = io.open(self.img_path .. filePath, "w")
  upladed:write(file.content)
  upladed:close()
  local thumb = io.open(self.img_path .. thumbPath, "w")
  thumb:close();

  magick.thumb(self.img_path .. filePath, "300x400", self.img_path .. thumbPath)

  return photo
end

function Photos:deletePhoto(photo) 

  local deleted = self:find(photo.id)
  deleted:delete()
  os.remove("./build" .. photo.src)
  
  return deleted
end


return Photos
