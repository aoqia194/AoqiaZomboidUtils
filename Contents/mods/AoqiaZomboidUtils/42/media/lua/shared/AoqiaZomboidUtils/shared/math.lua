--- A clamp function added by AoqiaZomboidUtils
--- @param val integer | int
--- @param min integer | int
--- @param max integer | int
--- @return integer | int
function math.clamp(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max
    end

    return val
end
