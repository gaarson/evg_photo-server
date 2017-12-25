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
  local type = file["content-type"]
  local mimeType = split(type, "/")[2]
  local category = self:create {
      title = info.name,
      description = info.caption
    }
  local filePath = category.id .. "." .. mimeType

  db.query("UPDATE categories SET src = ? WHERE id = ?", 
    "/img/categories/" .. filePath, category.id)

  local upladed = io.open(self.img_path .. filePath, "w")

  os.execute("mkdir " .. "./build/img/" .. category.id)
  upladed:write(file.content)
  upladed:close()

  return category
end

function Categories:deleteCategory(category) 
  
  local deleted = self:find(category.id)
  deleted:delete()
  os.remove("./build" .. deleted.src)
  
  return deleted
end

return Categories
