-- -------------------------------------------------------------------------- --
--                           A small logging module                           --
-- -------------------------------------------------------------------------- --

-- AoqiaZomboidUtils requires.
local constants = require("AoqiaZomboidUtilsShared/constants")

-- ------------------------------ Module Start ------------------------------ --

--- @class (exact) logger
--- @field __index self
--- @field private MOD_ID string
local logger = { MOD_ID = "AoqiaBaseLogger" }

--- @param str string The string that will be formatted.
--- @param ... any
function logger:debug(str, ...)
    if not self.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(("[%s] [DEBUG] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:debug_shared(str, ...)
    if not self.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(("[%s/shared] [DEBUG] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:debug_server(str, ...)
    if not self.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(("[%s/server] [DEBUG] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:info(str, ...)
    if not self.MOD_ID then return end

    print(("[%s] [INFO] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:info_shared(str, ...)
    if not self.MOD_ID then return end

    print(("[%s/shared] [INFO] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:info_server(str, ...)
    if not self.MOD_ID then return end

    print(("[%s/server] [INFO] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:warn(str, ...)
    if not self.MOD_ID then return end

    print(("[%s] [WARN] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:warn_shared(str, ...)
    if not self.MOD_ID then return end

    print(("[%s/shared] [WARN] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:warn_server(str, ...)
    if not self.MOD_ID then return end

    print(("[%s/server] [WARN] %s"):format(self.MOD_ID, str:format(...)))
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:error(str, ...)
    if not self.MOD_ID then return end

    error(("[%s] [ERROR] %s"):format(self.MOD_ID, str:format(...)), 1)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:error_shared(str, ...)
    if not self.MOD_ID then return end

    error(("[%s/shared] [ERROR] %s"):format(self.MOD_ID, str:format(...)), 1)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:error_server(str, ...)
    if not self.MOD_ID then return end

    error(("[%s/server] [ERROR] %s"):format(self.MOD_ID, str:format(...)), 1)
end

--- @param mod_id string
--- @return logger
function logger:new(mod_id)
    --- @class logger
    local o = {}
    setmetatable(o, self)

    self.__index = self
    o.MOD_ID = mod_id

    return o
end

return logger
