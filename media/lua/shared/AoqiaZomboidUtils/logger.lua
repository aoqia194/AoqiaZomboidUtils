-- -------------------------------------------------------------------------- --
--                           A small logging module                           --
-- -------------------------------------------------------------------------- --

local constants = require("AoqiaZomboidUtils/constants")

-- ------------------------------ Module Start ------------------------------ --

--- @class Logger
local logger = {}

logger.MOD_ID = nil

function logger.debug(...)
    if not logger.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(string.format("[%s] [DEBUG] %s", logger.MOD_ID, string.format(...)))
end

function logger.debug_server(...)
    if not logger.MOD_ID then return end
    if constants.IS_DEBUG == false then return end

    print(string.format("[%s/server] [DEBUG] %s", logger.MOD_ID, string.format(...)))
end

function logger.info(...)
    if not logger.MOD_ID then return end

    print(string.format("[%s] [INFO] %s", logger.MOD_ID, string.format(...)))
end

function logger.info_server(...)
    if not logger.MOD_ID then return end

    print(string.format("[%s/server] [INFO] %s", logger.MOD_ID, string.format(...)))
end

function logger.warn(...)
    if not logger.MOD_ID then return end

    print(string.format("[%s] [WARN] ### %s ###", logger.MOD_ID, string.format(...)))
end

function logger.warn_server(...)
    if not logger.MOD_ID then return end

    print(string.format("[%s/server] [WARN] ### %s ###", logger.MOD_ID, string.format(...)))
end

function logger.error(...)
    if not logger.MOD_ID then return end

    local str = string.format("[%s] [ERROR] ###### %s ######", logger.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

function logger.error_server(...)
    if not logger.MOD_ID then return end

    local str = string.format("[%s/server] [ERROR] ###### %s ######", logger.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

--- @param mod_id string
function logger:register(mod_id)
    self.MOD_ID = mod_id
end

--- @param object Logger|nil
--- @return Logger instance
function logger:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self

    return object
end

return logger
