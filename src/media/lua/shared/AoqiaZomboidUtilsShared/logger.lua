-- -------------------------------------------------------------------------- --
--                           A small logging module                           --
-- -------------------------------------------------------------------------- --

-- AoqiaZomboidUtils requires.
local constants = require("AoqiaZomboidUtilsShared/constants")

local os = os
local writeLog = writeLog

local os_date = os.date

-- ------------------------------ Module Start ------------------------------ --

--- @class (exact) logger
--- @field __index self
--- @field private MOD_ID string
local logger = { MOD_ID = "AoqiaBaseLogger" }

--- @param str string The string that will be formatted.
--- @param ... any
function logger:debug(str, ...)
    if self.MOD_ID == nil then return end
    if constants.IS_DEBUG == false then return end

    local fmt = ("[%s] [DEBUG] [%s] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:debug_shared(str, ...)
    if self.MOD_ID == nil then return end
    if constants.IS_DEBUG == false then return end

    local fmt = ("[%s] [DEBUG] [%s/shared] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:debug_server(str, ...)
    if self.MOD_ID == nil then return end
    if constants.IS_DEBUG == false then return end

    local fmt = ("[%s] [DEBUG] [%s/server] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:info(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [INFO] [%s] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:info_shared(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [INFO] [%s/shared] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:info_server(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [INFO] [%s/server] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:warn(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [WARN] [%s] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:warn_shared(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [WARN] [%s/shared] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:warn_server(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [WARN] [%s/server] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    print(fmt)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:error(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [ERROR] [%s] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    error(fmt, 1)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:error_shared(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [ERROR] [%s/shared] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    error(fmt, 1)
    writeLog(self.MOD_ID, fmt)
end

--- @param str string The string that will be formatted.
--- @param ... any
function logger:error_server(str, ...)
    if self.MOD_ID == nil then return end

    local fmt = ("[%s] [ERROR] [%s/server] %s"):format(
        os_date("%Y-%m-%d %H:%M:%S"),
        self.MOD_ID,
        str:format(...))

    error(fmt, 1)
    writeLog(self.MOD_ID, fmt)
end

--- Creates a new logger instance.
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
