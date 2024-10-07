local table = {}

--- @param tbl table
--- @return table
function table.shallow_copy(tbl)
    local new = {}

    for k, v in pairs(tbl) do
        new[k] = v
    end

    return new
end

return table
