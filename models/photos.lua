local to_json = require("lapis.util").to_json
local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

function Photos:getGalleryByCategory(category_id)
  return self:select("where category_id=?", category_id)
end

function Photos:uploadPhoto(file)
  local filePath = io.tmpfile()
  print(to_json(filePath))
  local upladed = io.open(filePath, "w")
  upladed:write(string_format(file.content))
  upladed:close()
  return filePath
end

function Photos:setPhotoInfo(info) 
  print(to_json(info))
  return "success"
end 

return Photos
