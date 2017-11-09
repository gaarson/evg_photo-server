local to_json = require("lapis.util").to_json
local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")
local split = require("sides.string")

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

function Photos:getGalleryByCategory(category_id)
  return self:select("where category_id=?", category_id)
end

function Photos:uploadPhoto(file, type)
  local mimeType = split(type, "/")[2]
  local filePath = "./static/img/" .. "newFile." .. mimeType
  local upladed = io.open(filePath, "w")

  upladed:write(file.content)
  upladed:close()

  return filePath

end

function Photos:setPhotoInfo(info) 
  print(to_json(info))
  return "success"
end 

return Photos
