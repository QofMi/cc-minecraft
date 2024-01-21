local display = peripheral.find("monitor")
local pos_x, pos_y = 1, 1
local color = colors.pink
local scale = 5

display.setTextColor(color)
display.setTextScale(scale)


local function displayTime(x, y)
    local time = os.time()
    display.clear()
    display.setCursorPos(x, y)
    display.write( textutils.formatTime(time, true) )
end


while true do
    displayTime(pos_x, pos_y)
    sleep(0.75)
end