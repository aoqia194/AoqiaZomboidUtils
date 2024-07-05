-- -------------------------------------------------------------------------- --
--                           A small logging module                           --
-- -------------------------------------------------------------------------- --

local constants = require("AoqiaZomboidUtils/constants")

-- ------------------------------ Module Start ------------------------------ --

--- @class logger
local logger = {}

logger.MOD_ID = "AoqiaBaseLogger"

function logger:debug(...)
    if not self.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(string.format("[%s] [DEBUG] %s", self.MOD_ID, string.format(...)))
end

function logger:debug_shared(...)
    if not self.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(string.format("[%s/shared] [DEBUG] %s", self.MOD_ID, string.format(...)))
end

function logger:debug_server(...)
    if not self.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(string.format("[%s/server] [DEBUG] %s", self.MOD_ID, string.format(...)))
end

function logger:info(...)
    if not self.MOD_ID then return end

    print(string.format("[%s] [INFO] %s", self.MOD_ID, string.format(...)))
end

function logger:info_shared(...)
    if not self.MOD_ID then return end

    print(string.format("[%s/shared] [INFO] %s", self.MOD_ID, string.format(...)))
end

function logger:info_server(...)
    if not self.MOD_ID then return end

    print(string.format("[%s/server] [INFO] %s", self.MOD_ID, string.format(...)))
end

function logger:warn(...)
    if not self.MOD_ID then return end

    print(string.format("[%s] [WARN] ### %s ###", self.MOD_ID, string.format(...)))
end

function logger:warn_shared(...)
    if not self.MOD_ID then return end

    print(string.format("[%s/shared] [WARN] ### %s ###", self.MOD_ID, string.format(...)))
end

function logger:warn_server(...)
    if not self.MOD_ID then return end

    print(string.format("[%s/server] [WARN] ### %s ###", self.MOD_ID, string.format(...)))
end

function logger:error(...)
    if not self.MOD_ID then return end

    local str = string.format("[%s] [ERROR] ###### %s ######", self.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

function logger:error_shared(...)
    if not self.MOD_ID then return end

    local str = string.format("[%s/shared] [ERROR] ###### %s ######", self.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

function logger:error_server(...)
    if not self.MOD_ID then return end

    local str = string.format("[%s/server] [ERROR] ###### %s ######", self.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

--- @param mod_id string
--- @return logger instance
function logger:new(mod_id)
    ---@class logger
    local o = {}
    setmetatable(o, self)

    self.__index = self
    o.MOD_ID = mod_id

    return o
end

return logger
