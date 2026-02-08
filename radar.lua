-- radar.lua
function update()
    local players = getPlayers()
    local screenW, screenH = getScreenSize()

    -- настройки радара
    local radarX = 100
    local radarY = 100
    local radarSize = 80
    local radarRange = 50  -- метров в игре

    -- фон радара
    drawRect(radarX - radarSize, radarY - radarSize,
             radarX + radarSize, radarY + radarSize,
             20, 20, 20, 200, 10.0, 0)

    -- сетка
    drawLine(radarX - radarSize, radarY, radarX + radarSize, radarY, 100, 100, 100, 100, 1.0)
    drawLine(radarX, radarY - radarSize, radarX, radarY + radarSize, 100, 100, 100, 100, 1.0)

    local clampMin, clampMax = radarSize, -radarSize
    local invRange = radarRange / radarSize
    local floor = math.floor
    local max = math.max
    local min = math.min

    for i = 1, #players do
        local player = players[i]
        if player.health >= 0 then
            -- относительные координаты
            local relX = player.x / invRange
            local relY = player.z / invRange  -- используем Z для плоского радара

            -- ограничиваем в пределах радара
            relX = max(clampMin, min(clampMax, relX))
            relY = max(clampMin, min(clampMax, relY))

            -- цвет в зависимости от здоровья
            local hpPercent = player.health * 0.01
            local r = floor(255 * (1 - hpPercent))
            local g = floor(255 * hpPercent)

            -- точка на радаре
            local dotSize = 4
            local half = dotSize * 0.5
            drawRect(radarX + relX - half, radarY + relY - half,
                     radarX + relX + half, radarY + relY + half,
                     r, g, 0, 255, half, 0)
        end
    end

    -- центр (игрок)
    drawRect(radarX - 3, radarY - 3, radarX + 3, radarY + 3, 0, 255, 0, 255, 3.0, 0)

    drawText("Radar", radarX, radarY + radarSize + 10, 255,
255, 255, 255)
end

log("Radar script loaded")
