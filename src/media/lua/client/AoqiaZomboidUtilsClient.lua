-- -------------------------------------------------------------------------- --
--                      The main entry point for the mod.                     --
-- -------------------------------------------------------------------------- --

-- Mod requires.
local events = require("AoqiaZomboidUtilsClient/events")
local mod_constants = require("AoqiaZomboidUtilsShared/mod_constants")

local logger = mod_constants.LOGGER

-- ------------------------------- Entrypoint ------------------------------- --

events.register()

logger:debug("Lua init done!")
