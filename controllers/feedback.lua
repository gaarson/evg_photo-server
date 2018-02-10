local assert_error = require("lapis.application").assert_error
local json_params = require("lapis.application").json_params
local to_json = require("lapis.util").to_json

local Mailgun = require("mailgun").Mailgun


return {
  POST = json_params(function(self) 
    print(to_json(self.params))
    local mailgun = Mailgun({
        domain = "sandboxe4b0d5fff2344ced8dff6ca83651084d.mailgun.org",
        api_key = "api:key-2a1326e9a1244d47653ba47d29dc8adc"
      })

    print("LALALALAAL")

    mailgun:send_email({
      to = "gaarson666@gmail.com",
      subject = "Important message here",
      body = "TextTextText"
    })

    return { json = self.params }
  end),
}
