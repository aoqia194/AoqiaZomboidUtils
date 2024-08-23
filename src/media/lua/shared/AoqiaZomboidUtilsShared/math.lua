-- -------------------------------------------------------------------------- --
--                               Cool math stuff                              --
-- -------------------------------------------------------------------------- --



-- ------------------------------ Module Start ------------------------------ --

local aoqia_math = {}

--- @param val integer | int
--- @param min integer | int
--- @param max integer | int
--- @return integer | int
function aoqia_math.clamp(val, min, max)
    -- NOTE: Keep this here to avoid function call overhead.
    if val < min then
        return min
    elseif val > max then
        return max
    end

    return val
end

return aoqia_math
