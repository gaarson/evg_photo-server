local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

function Photos:getGalleryByCategory(category_id)
  return self:select("where category_id=?", category_id)
end

function Photos:uploadPhoto(file)
  print(file);
    
end

return Photos
