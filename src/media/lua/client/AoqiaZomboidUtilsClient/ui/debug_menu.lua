-- -------------------------------------------------------------------------- --
--                                    wawa                                    --
-- -------------------------------------------------------------------------- --

-- My requires.
local constants = require("AoqiaZomboidUtilsShared/constants")
local mod_constants = require("AoqiaZomboidUtilsShared/mod_constants")
local moddata_panel = require("AoqiaZomboidUtilsClient/ui/moddata_panel")
local vehicleinfo_panel = require("AoqiaZomboidUtilsClient/ui/vehicleinfo_panel")

-- TIS globals.
local instanceof = instanceof
local ISContextMenu = ISContextMenu

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

local debug_menu = {}

--- @generic T
--- @param list T
--- @return T
function debug_menu.remove_duplicates(list)
    local result = {}

    local seen = {}
    for i = 1, #list + 1 do
        local item = list[i - 1]

        if not seen[item] then
            seen[item] = true
            result[#result + 1] = item
        end
    end

    return result
end

--- @param item InventoryItem
function debug_menu.do_item_moddata(item)
    --- @type ModDataPanel
    local panel = moddata_panel:new(100, 100, 840, 600, item)

    panel:initialise()
    panel:instantiate()
    panel:addToUIManager()
    panel:setVisible(true)
end

--- @param vehicle BaseVehicle
function debug_menu.do_vehicle_moddata(vehicle)
    --- @type ModDataPanel
    local panel = moddata_panel:new(100, 100, 840, 600, vehicle)
    panel:initialise()
    panel:instantiate()
    panel:addToUIManager()
    panel:setVisible(true)
end

--- @param vehicle BaseVehicle
function debug_menu.do_vehicle_info(vehicle)
    --- @type VehicleInfoPanel
    local panel = vehicleinfo_panel:new(100, 100, 600, 800, vehicle)
    panel:initialise()
    panel:addToUIManager()
    panel:setVisible(true)
end

--- @param context ISContextMenu
--- @param items ContextMenuItemStack[] | InventoryItem[]
function debug_menu.add_option_to_invmenu(context, items)
    if constants.IS_DEBUG == false then return end
    if items == nil or #items == 0 then return end

    local item = nil
    if instanceof(items[1], "InventoryItem") then
        --- @cast items InventoryItem[]
        item = items[1]
    else
        --- @cast items ContextMenuItemStack[]
        item = items[1].items[1]
    end

    if item == nil then
        logger:debug("Item was nil.")
        return
    end

    local option = context:addDebugOption(mod_constants.MOD_ID, item, nil)
    local menu = ISContextMenu:getNew(context)
    context:addSubMenu(option, menu)

    menu:addOption("Item ModData", item, debug_menu.do_item_moddata)
end

--- @param context ISContextMenu
--- @param worldobjects BaseVehicle[]
function debug_menu.add_option_to_worldmenu(context, worldobjects)
    if constants.IS_DEBUG == false then return end

    local square = worldobjects[1] and worldobjects[1]:getSquare() or nil
    if square == nil then
        logger:debug("Square was nil.")
        return
    end

    -- local objects = square:getObjects()
    -- for i = 1, objects:size() do
    --     local obj = objects:get(i - 1) --[[@as BaseVehicle | IsoObject]]
    --     worldobjects[#worldobjects + 1] = obj
    -- end
    -- worldobjects = debug_menu.remove_duplicates(worldobjects)

    local vehicle = square:getVehicleContainer()
    if vehicle == nil then
        logger:debug("Vehicle was nil.")
        return
    end

    local option = context:addDebugOption(mod_constants.MOD_ID, worldobjects, nil)
    local menu = ISContextMenu:getNew(context)
    context:addSubMenu(option, menu)

    menu:addOption("Vehicle ModData", vehicle, debug_menu.do_vehicle_moddata)
    menu:addOption("Vehicle Info", vehicle, debug_menu.do_vehicle_info)
end

return debug_menu
