local to_json = require("lapis.util").to_json
local db = require "lapis.db"
local Model = require("lapis.db.model").Model
local Categories = Model:extend("categories")

local split = require "utils.split"

Categories.img_path = "./build/img/categories/"

function Categories:getCategories() 
  return self:select()
end 

function Categories:getCategory(id) 
  local category = self:find(id)

  return category
end

function Categories:uploadCategory(file, info) 
  local magick = require("magick.wand")
  local type = file["content-type"]
  local mimeType = split(type, "/")[2]
  local image = magick.load_image_from_blob(file.content)

  image:scale(nil, 300)
  image:set_quality(100)

  local category = self:create {
      title = info.name,
      description = info.caption
    }
  local filePath = category.id .. "." .. mimeType

  category.src = "/img/categories/" .. filePath
  category:update('src')

  os.execute("mkdir " .. "./build/img/" .. category.id)

  image:write(self.img_path .. filePath)
  image:destroy()

  return category
end

function Categories:deleteCategory(category) 
  
  local deleted = self:find(category.id)
  deleted:delete()
  os.remove("./build" .. deleted.src)
  
  return deleted
end

return Categories
