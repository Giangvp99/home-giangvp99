-- ## Notifications ##
-- ~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local naughty = require("naughty")
local rnotification = require("ruled.notification")

-- Error handling :
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- Notifications :
naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- Urgent notifications :
rnotification.connect_signal("request::rules", function()
    rnotification.append_rule {
        rule       = { urgency = "critical" },
        properties = { bg = colors.black, fg = colors.green }
    }
end)
