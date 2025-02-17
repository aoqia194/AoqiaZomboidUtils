local table = {}

--- Shallow copies a table, ignoring nested tables.
--- @param tbl table
--- @return table
function table.shallow_copy(tbl)
    local res = {}

    for k, v in pairs(tbl) do
        res[k] = v
    end

    return res
end

--- Recursively copies a table including metatable. Can be expensive depending on the size of `tbl`.
--- @param tbl table The table to copy.
--- @param with_keys boolean If keys can store tables, we need to copy them too.
--- @param preserve_metatable boolean Should we copy the metatable?
--- @param index nil | table DO NOT use this arg, it is internally used!
function table.deep_copy(tbl, with_keys, preserve_metatable, index)
    if type(tbl) ~= "table" then return tbl end

    -- Handle previously seen tables.
    if index and index[tbl] then return index[tbl] end

    -- Mark this newly-created table as seen and copy recursively.
    local new_index = index or {}
    local res = {}
    new_index[tbl] = res

    for k, v in pairs(tbl) do
        local v_copy = table.deep_copy(v, with_keys, preserve_metatable, new_index)

        -- Avoid one less copy per iteration if keys cannot be tables.
        if with_keys then
            local k_copy = table.deep_copy(k, with_keys, preserve_metatable, new_index)
            res[k_copy] = v_copy
        else
            res[k] = v_copy
        end
    end

    if preserve_metatable then
        return setmetatable(res, getmetatable(tbl))
    end

    return res
end

--- Recursively iterates over a table. Can be expensive depending on the size of `tbl`.
--- Will cause INFINITE LOOP if a sub-table refers to it's parent table (eg tbl.a -> tbl).
--- @param tbl table The table to iterate over.
--- @param predicate fun(k: any, v: any) The fn to call for each iteration of `tbl`.
function table.deep_iterate(tbl, predicate)
    if type(tbl) ~= "table" then return end

    for k, v in pairs(tbl) do
        table.deep_iterate(v, predicate)
        predicate(k, v)
    end
end

--- Initialises mod data for the object.
--- @param obj any
--- @param modid string
--- @returns table | nil The mod data table.
function table.init_mdata(obj, modid)
    assert(obj, "obj cannot be nil")
    assert(obj.getModData, "obj does not have getModData()")

    local mdata = obj:getModData()
    if (mdata[modid] == nil) then
        mdata[modid] = {}
    end
    return mdata[modid]
end

return table
