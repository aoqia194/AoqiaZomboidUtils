-- -------------------------------------------------------------------------- --
--                               Cool math stuff                              --
-- -------------------------------------------------------------------------- --



-- ------------------------------ Module Start ------------------------------ --

local math = {}

--- @param val integer
--- @param min integer
--- @param max integer
--- @return integer
function math.clamp(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max
    end

    return val
end

return math
