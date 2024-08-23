-- -------------------------------------------------------------------------- --
--                                    wawa                                    --
-- -------------------------------------------------------------------------- --

-- My requires.
local mod_constants = require("AoqiaZomboidUtilsShared/mod_constants")

-- std
local pairs = pairs
local tostring = tostring

-- TIS globals.
local getTextManager = getTextManager
local ISDebugMenu = ISDebugMenu
local ISPanel = ISPanel
local ISScrollingListBox = ISScrollingListBox
local UIFont = UIFont

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

--- @class ModDataPanel: ISPanel
--- @field obj BaseVehicle | InventoryItem
local moddata_panel = ISPanel:derive(mod_constants.MOD_ID .. "_moddata_panel")

--- @param y integer
--- @param item unknown
--- @param alt unknown
--- @return integer
function moddata_panel:draw_values(y, item, alt)
    local width = self:getWidth()

    self:drawRectBorder(0, y, width, self.itemheight - 1, 0.9, self.borderColor.r,
        self.borderColor.g, self.borderColor.b)

    if self.selected == item.index then
        self:drawRect(0, y, width, self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
    end

    self:drawText(item.text, 10, y + 2, 1, 1, 1, 0.9, self.font)

    return y + self.itemheight
end

--- @param y integer
--- @param item unknown
--- @param alt unknown
--- @return integer
function moddata_panel:draw_tables(y, item, alt)
    local width = self:getWidth()

    self:drawRectBorder(
        0,
        y,
        width,
        self.itemheight - 1,
        0.9,
        self.borderColor.r,
        self.borderColor.g,
        self.borderColor.b)

    if self.selected == item.index then
        self:drawRect(
            0,
            y,
            width,
            self.itemheight - 1,
            0.3,
            0.7,
            0.35,
            0.15)
    end

    self:drawText(item.text, 10, y + 2, 1, 1, 1, 0.9, self.font)

    return y + self.itemheight
end

--- Recursively parses `tbl` and adds the values to the `info_list`.
--- @param tbl table<any>
--- @param indent? string
function moddata_panel:parse_table_recurse(tbl, indent)
    if indent == nil then
        indent = ""
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

--- Shallow parses `tbl` and adds the values that aren't tables to the `info_list`.
--- @param tbl table<any>
function moddata_panel:parse_table(tbl)
    for k, v in pairs(tbl) do
        if type(v) ~= "table" then
            local s = ("[%s] = (%s)"):format(tostring(k), tostring(v))
            self.values:addItem(s, nil)
        end
    end
end

--- Parses all of the pairs in `mdata[name]` (or `mdata` if `name` is `__global`).
--- @param name? string
function moddata_panel:populate_values(name)
    if name == nil then return end

    self.values:clear()

    local mdata = self.obj:getModData()

    if name == "__global" then
        self:parse_table(mdata)
        return
    end

    self:parse_table_recurse(mdata[name])
end

--- Adds all of the keys from `mdata` to the `tables` list.
function moddata_panel:populate_tables()
    self.tables:clear()

    local mdata = self.obj:getModData()

    -- Holds all of the keys which are table names in `mdata`.
    local table_keys = {}
    -- Holds all of the keys which are variables in `mdata`.
    local keys = {}

    -- Get all keys from `mdata` table.
    for k, v in pairs(mdata) do
        if type(v) == table then
            table_keys[#table_keys + 1] = tostring(k)
        else
            keys[#keys + 1] = tostring(k)
        end
    end

    -- If no keys in `mdata` then assume it is empty.
    if #table_keys == 0 and #keys == 0 then
        -- self:populate_values()
        return
    end

    -- Create a global table key for values in `mdata` that are direct children of the table.
    if #keys > 0 then
        self.tables:addItem("__global", "__global")
    end

    -- Add keys which represent tables to the table list.
    for i = 1, #table_keys do
        local key = table_keys[i]
        self.tables:addItem(key, key)
    end

    self:populate_values(#keys > 0 and "__global" or table_keys[1])
end

function moddata_panel:render()
    if self.postrender then
        self:postrender()
    end
end

function moddata_panel:prerender()
    ISPanel.prerender(self)
end

function moddata_panel:update()
    ISPanel.update(self)
end

function moddata_panel:close()
    self:setVisible(false)
    self:removeFromUIManager()
end

function moddata_panel:createChildren()
    ISPanel.createChildren(self)

    local height = getTextManager():getFontHeight(UIFont.NewMedium)

    self.tables = ISScrollingListBox:new(
        self.padding,
        self.padding,
        200,
        self.height - ((self.padding * 3) + self.button_height))
    self.tables:initialise()
    self.tables:instantiate()
    self.tables.itemheight = height + 8
    self.tables.selected = 0
    self.tables.font = UIFont.NewMedium
    self.tables.doDrawItem = self.draw_tables
    self.tables.drawBorder = true
    self.tables.onmousedown = self.populate_values
    self.tables.target = self
    self:addChild(self.tables)

    self.values = ISScrollingListBox:new(
        self.tables.width + (self.padding * 2),
        self.padding,
        self.width - (self.tables.width + (self.padding * 3)),
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
        self.populate_tables)

    self:populate_tables()
end

function moddata_panel:initialise()
    ISPanel.initialise(self)
end

--- @param x integer
--- @param y integer
--- @param width integer
--- @param height integer
--- @param obj BaseVehicle | InventoryItem
--- @return ModDataPanel
function moddata_panel:new(x, y, width, height, obj)
    local o = ISPanel:new(x, y, width, height)

    --- @cast o ModDataPanel
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

return moddata_panel
