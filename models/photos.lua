local Model = require("lapis.db.model").Model
local Photos = Model:extend("photos")

function Photos:getMainScreen() 
  return self:select("where is_main=1")
end

return Photos
