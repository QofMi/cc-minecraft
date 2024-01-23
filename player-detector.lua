require("gui")


PLAYER_DETECTOR = peripheral.find("playerDetector")
RANGE_DETECTION = 10
REDSTONE_SIGNAL = false
REDSTONE_SIDE = ""
USE_WHITE_LIST = false
WHITE_LIST = {}

guiClear()
while true do
    
    if display then
        y_pos = 1
    end
    
    if PLAYER_DETECTOR then
        for _, player in pairs(PLAYER_DETECTOR.getOnlinePlayers()) do
            if PLAYER_DETECTOR.isPlayerInRange(RANGE_DETECTION, player) then

                if USE_WHITE_LIST then

                    if is_contains(WHITE_LIST, player) then
                        if display then
                            guiDrawText(2, y_pos, player, colors.pink, colors.black)
                            y_pos = y_pos + 1
                        end
        
                        if REDSTONE_SIGNAL then
                            redstone.setOutput(REDSTONE_SIDE, true)
                        end
                    end

                else
                    
                    if display then
                        guiDrawText(2, y_pos, player, colors.pink, colors.black)
                        y_pos = y_pos + 1
                    end
    
                    if REDSTONE_SIGNAL then
                        redstone.setOutput(REDSTONE_SIDE, true)
                    end
                
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
