local Shared = {}

local sqrt = math.sqrt
function Shared.IsBetweenRange(value, low, high)

    return value >= low and value <= high

end

function Shared.IsNear(x_1, y_1, x_2, y_2, distance_threshold)

    return sqrt((x_1 - x_2)^2 + (y_1 - y_2)^2) <= distance_threshold

end

return Shared