require("gui")


PLAYER_DETECTOR = peripheral.find("playerDetector")
RANGE_DETECTION = 10


while true do
    if PLAYER_DETECTOR then
        for _, player in pairs(PLAYER_DETECTOR.getOnlinePlayers()) do
            if PLAYER_DETECTOR.isPlayerInRange(RANGE_DETECTION, player) then
                display.write(("%s\z"):format(player))
            end
        end
        sleep(3)
    else
        error("Player detector is not found")
    end
end
