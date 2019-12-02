local json = require "json"
-- unit = dfhack.gui.getSelectedUnit()

x = {[1] = "a", [2] = "b"}

local encode = json:encode(x)
print (encode)
