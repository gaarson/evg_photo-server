local assert_error = require("lapis.appliation").assert_error
local to_json = require("lapis.util").to_json

local Categories = require "models.categories"

return {
  before = function(self)
    self.res.headers["Access-Control-Allow-Origin"] = "*"
  end,

  OPTIONS = function(self) 
  end,

  GET = function(self)
    local list = assert_error(Categories:getCategories(self.params.id))

    return { json = { list: list } }
  end,

  POST = function (self) 
    local file = self.params.file
    local info = self.params

    local success = assert_error(Categories:uplaodCategories(file, info))
    return { json = { success } }
  end 
}
