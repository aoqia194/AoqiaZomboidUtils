-- -------------------------------------------------------------------------- --
--                                    wawa                                    --
-- -------------------------------------------------------------------------- --

-- My requires.
local mod_constants = require("AoqiaZomboidUtilsShared/mod_constants")

-- std globals
local pairs = pairs
local tostring = tostring
local type = type

-- TIS globals.
local getTextManager = getTextManager
local ISDebugMenu = ISDebugMenu
local ISPanel = ISPanel
local ISScrollingListBox = ISScrollingListBox
local UIFont = UIFont

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

--- @class VehicleInfoPanel: ISPanel
--- @field obj BaseVehicle
--- @field padding integer
--- @field button_width integer
--- @field button_height integer
local vehicleinfo_panel = ISPanel:derive(mod_constants.MOD_ID .. "_vehicleinfo_panel")

--- @param y integer
--- @param item unknown
--- @param alt unknown
--- @return integer
function vehicleinfo_panel:draw_values(y, item, alt)
    local width = self:getWidth()

    self:drawRectBorder(0, y, width, self.itemheight - 1, 0.9, self.borderColor.r,
        self.borderColor.g, self.borderColor.b)

    if self.selected == item.index then
        self:drawRect(0, y, width, self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
    end

    self:drawText(item.text, 10, y + 2, 1, 1, 1, 0.9, self.font)

    return y + self.itemheight
end

--- Recursively parses `tbl` and adds the values.
--- @param tbl table<string, any>
--- @param indent? string
function vehicleinfo_panel:parse_table_recurse(tbl, indent)
    if indent == nil then
        indent = "    "
    end

    indent = tostring(indent)

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            local s = ("%s[%s] ="):format(indent, tostring(k))
            self.values:addItem(s, nil)
            self:parse_table_recurse(v, indent .. "        ")
        else
            local s = ("%s[%s] = (%s)"):format(indent, tostring(k), tostring(v))
            self.values:addItem(s, nil)
        end
    end
end

function vehicleinfo_panel:populate_values()
    self.values:clear()

    local keys = {
        "Name",
        "Id",
        "Type",
        "Color",
        "Skin Idx",
        "Pos",
        "Has Key",
        "Hotwired",
        "Hotwired Broken",
        "Regulator Speed",
        "Previously Entered",
        "Keys In Ignition",
        "Keys On Door",
        "Rust",
        "Blood FBLR",
        "Engine Loudness",
        "Engine Power",
        "Engine Quality",
        "Headlights",
        "Stoplights",
        "Light Count",
    }

    local values = {
        self.obj:getScriptName(),
        self.obj:getId(),
        self.obj:getVehicleType(),
        { H = self.obj:getColorHue(), S = self.obj:getColorSaturation(), V = self.obj:getColorValue() },
        self.obj:getSkinIndex(),
        { X = self.obj:getX(),        Y = self.obj:getY(),               Z = self.obj:getZ() },
        self.obj:getCurrentKey() ~= nil,
        self.obj:isHotwired(),
        self.obj:isHotwiredBroken(),
        self.obj:getRegulatorSpeed(),
        self.obj:isPreviouslyEntered(),
        self.obj:isKeysInIgnition(),
        self.obj:isKeyIsOnDoor(),
        self.obj:getRust(),
        {
            Front = self.obj:getBloodIntensity("Front"),
            Back = self.obj:getBloodIntensity("Back"),
            Left = self.obj:getBloodIntensity("Left"),
            Right = self.obj:getBloodIntensity("Right"),
        },
        self.obj:getEngineLoudness(),
        self.obj:getEnginePower(),
        self.obj:getEngineQuality(),
        self.obj:getHeadlightsOn(),
        self.obj:getStoplightsOn(),
        self.obj:getLightCount(),
    }

    for i = 1, #keys do
        local k = keys[i]
        local v = values[i]

        if type(v) == "table" then
            self.values:addItem(("[%s] ="):format(k))
            self:parse_table_recurse(v)
        else
            self.values:addItem(("[%s] = (%s)"):format(k, tostring(v)), nil)
        end
    end
end

function vehicleinfo_panel:render()
    if self.postrender then
        self:postrender()
    end
end

function vehicleinfo_panel:prerender()
    ISPanel.prerender(self)
end

function vehicleinfo_panel:update()
    ISPanel.update(self)
end

function vehicleinfo_panel:close()
    self:setVisible(false)
    self:removeFromUIManager()
end

function vehicleinfo_panel:createChildren()
    ISPanel.createChildren(self)

    local height = getTextManager():getFontHeight(UIFont.NewMedium)

    self.values = ISScrollingListBox:new(
        self.padding,
        self.padding,
        self.width - (self.padding * 2),
        self.height - ((self.padding * 3) + self.button_height))
    self.values:initialise()
    self.values:instantiate()
    self.values.itemheight = height + 8
    self.values.selected = 0
    self.values.font = UIFont.NewMedium
    self.values.doDrawItem = self.draw_values
    self.values.drawBorder = true
    self:addChild(self.values)

    ISDebugUtils.addButton(self,
        "close",
        self.padding,
        self.height - (self.button_height + self.padding),
        self.button_width,
        self.button_height,
        getText("IGUI_CraftUI_Close"),
        self.close)
    ISDebugUtils.addButton(self,
        "refresh",
        (self.padding * 2) + self.button_width,
        self.height - (self.button_height + self.padding),
        self.button_width,
        self.button_height,
        "Refresh",
        self.populate_values)

    self:populate_values()
end

function vehicleinfo_panel:initialise()
    ISPanel.initialise(self)
end

--- @param x integer
--- @param y integer
--- @param width integer
--- @param height integer
--- @param obj BaseVehicle
--- @return VehicleInfoPanel
function vehicleinfo_panel:new(x, y, width, height, obj)
    local o = ISPanel:new(x, y, width, height)

    --- @cast o VehicleInfoPanel
    setmetatable(o, self)
    self.__index = self

    o.obj = obj

    o.variableColor = { r = 0.9, g = 0.55, b = 0.1, a = 1 }
    o.borderColor = { r = 0.4, g = 0.4, b = 0.4, a = 1 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.8 }
    o.buttonBorderColor = { r = 0.7, g = 0.7, b = 0.7, a = 0.5 }
    o.zOffsetSmallFont = 25
    o.moveWithMouse = true

    o.padding = 10
    o.button_width = 100
    o.button_height = 25

    ISDebugMenu.RegisterClass(self)
    return o
end

return vehicleinfo_panel
