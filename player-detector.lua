require("gui")


PLAYER_DETECTOR = peripheral.find("playerDetector")
RANGE_DETECTION = 10
REDSTONE_SIGNAL = false
REDSTONE_SIDE = ""

guiClear()
while true do
    
    if display then
        local y_pos = 0
        --guiClear()
    end
    
    if PLAYER_DETECTOR then
        for _, player in pairs(PLAYER_DETECTOR.getOnlinePlayers()) do
            if PLAYER_DETECTOR.isPlayerInRange(RANGE_DETECTION, player) then
                if display then
                    guiDrawText(2, y_pos, player, colors.pink, colors.black)
                end

                if REDSTONE_SIGNAL then
                    redstone.setOutput(REDSTONE_SIDE, true)
                end

            else
                if display then
                    guiClear()
                end
                
                if REDSTONE_SIGNAL then
                    redstone.setOutput(REDSTONE_SIDE, false)
                end
            
            end
        end
        sleep(1)
    else
        error("Player detector is not found")
    end

end
