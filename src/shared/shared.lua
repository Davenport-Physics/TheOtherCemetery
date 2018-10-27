local Shared = {}

function Shared.IsBetweenRange(value, low, high)

    if value >= low and value <= high then return true end
    return false

end

function Shared.IsNear(x_1, y_1, x_2, y_2, distance_threshold)

    if math.sqrt((x_1 - x_2)^2 + (y_1 - y_2)^2) <= distance_threshold then
        return true
    end

    return false

end

return Shared