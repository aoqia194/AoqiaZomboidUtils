-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering listeners/hooks.           --
-- -------------------------------------------------------------------------- --

-- AoqiaCarwannaExtended requires.
local constants = require("AoqiaZomboidUtilsShared/constants")
local debug_menu = require("AoqiaZomboidUtilsClient/ui/debug_menu")
local mod_constants = require("AoqiaZomboidUtilsShared/mod_constants")

-- TIS globals cache.
local Events = Events

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

local events = {}

--- @type Callback_OnFillInventoryObjectContextMenu
function events.fill_invobj_menu(player_num, context, items)
    if constants.IS_DEBUG == false then return end
    debug_menu.add_option_to_invmenu(context, items)
end

--- @type Callback_OnFillWorldObjectContextMenu
function events.fill_worldobj_menu(player_num, context, worldobjects, test)
    if constants.IS_DEBUG == false then return end
    debug_menu.add_option_to_worldmenu(context, worldobjects)
end

function events.register()
    logger:debug("Registering events...")

    Events.OnFillInventoryObjectContextMenu.Add(events.fill_invobj_menu)
    Events.OnFillWorldObjectContextMenu.Add(events.fill_worldobj_menu)
end

return events
