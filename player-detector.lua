require("gui")


PLAYER_DETECTOR = peripheral.find("playerDetector")

USE_DETECTOR = "by_range" -- by_range | by_coords
RANGE_DETECTION = 10
COORDS_DETECTION_POS_1 = {x = nil, y = nil, z = nil}
COORDS_DETECTION_POS_2 = {x = nil, y = nil, z = nil}

REDSTONE_SIGNAL = false
REDSTONE_SIDE = ""

USE_WHITE_LIST = false
WHITE_LIST = {}


local function isPlayerDetected()
    if USE_DETECTOR == "by_range" then
        return PLAYER_DETECTOR.isPlayerInRange(RANGE_DETECTION, player)
    end
    if USE_DETECTOR == "by_coords" then
        return PLAYER_DETECTOR.isPlayerInCoords(COORDS_DETECTION_POS_1, COORDS_DETECTION_POS_2, player)
    end
end


local function playerDetectorAction(display_action, redstone_action)
    if display then
        if display_action == "draw" then
            guiDrawText(2, y_pos, player, colors.pink, colors.black)
            y_pos = y_pos + 1
        elseif display_action == "clear" then
            guiClear()
        end
    end

    if REDSTONE_SIGNAL then
        redstone.setOutput(REDSTONE_SIDE, redstone_action)
    end
end


guiClear()
while true do
    y_pos = 1
    
    if PLAYER_DETECTOR then
        for _, _player in pairs(PLAYER_DETECTOR.getOnlinePlayers()) do
            player = _player
            
            if isPlayerDetected() then

                if USE_WHITE_LIST then
                    if is_contains(WHITE_LIST, player) then
                        playerDetectorAction("draw", true)
                    end
                else
                    playerDetectorAction("draw", true)
                end


            else
                playerDetectorAction("clear", false)
            
            end
        end
        sleep(1)
    else
        error("Player detector is not found")
    end

end
