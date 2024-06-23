-- -------------------------------------------------------------------------- --
--                           A small logging module                           --
-- -------------------------------------------------------------------------- --

local constants = require("AoqiaZomboidUtils/constants")

-- ------------------------------ Module Start ------------------------------ --

local logger = {}

function logger.debug(...)
    if constants.IS_DEBUG == false then return end
    print(string.format("[%s] [DEBUG] %s", constants.MOD_ID, string.format(...)))
end

function logger.debug_server(...)
    if constants.IS_DEBUG == false then return end
    print(string.format("[%s/server] [DEBUG] %s", constants.MOD_ID, string.format(...)))
end

function logger.info(...)
    print(string.format("[%s] [INFO] %s", constants.MOD_ID, string.format(...)))
end

function logger.info_server(...)
    print(string.format("[%s/server] [INFO] %s", constants.MOD_ID, string.format(...)))
end

function logger.warn(...)
    print(string.format("[%s] [WARN] ### %s ###", constants.MOD_ID, string.format(...)))
end

function logger.warn_server(...)
    print(string.format("[%s/server] [WARN] ### %s ###", constants.MOD_ID, string.format(...)))
end

function logger.error(...)
    local str = string.format("[%s] [ERROR] ###### %s ######", constants.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

function logger.error_server(...)
    local str = string.format("[%s/server] [ERROR] ###### %s ######", constants.MOD_ID, string.format(...))

    print(str)
    error(str, 1)
end

return logger
