-- `radar.lua`
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
    
    for i, player in ipairs(players) do
        if player.health > 0 then
            -- относительные координаты
            local relX = player.x / radarRange * radarSize
            local relY = player.z / radarRange * radarSize  -- используем Z для плоского радара
            
            -- ограничиваем в пределах радара
            relX = math.max(-radarSize, math.min(radarSize, relX))
            relY = math.max(-radarSize, math.min(radarSize, relY))
            
            -- цвет в зависимости от здоровья
            local hpPercent = player.health / 100
            local r = math.floor(255 * (1 - hpPercent))
            local g = math.floor(255 * hpPercent)
            
            -- точка на радаре
            local dotSize = 4
            drawRect(radarX + relX - dotSize/2, radarY + relY - dotSize/2,
                     radarX + relX + dotSize/2, radarY + relY + dotSize/2,
                     r, g, 0, 255, dotSize/2, 0)
        end
    end
    
    -- центр (игрок)
    drawRect(radarX - 3, radarY - 3, radarX + 3, radarY + 3, 0, 255, 0, 255, 3.0, 0)
    
    drawText("Radar", radarX, radarY + radarSize + 10, 255, 255, 255, 255)
end

log("vlal script loaded")
