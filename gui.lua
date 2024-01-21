local display = peripheral.find("monitor")
local display_x, display_y = display.getSize()
display.setTextScale(1)

function guiClear()
    display.setBackgroundColor(colors.black)
    display.clear()
    display.setCursorPos(1, 1)
end


function guiDrawText(x, y, text, color_text, color_bg)
    display.setBackgroundColor(color_bg)
    display.setTextColor(color_text)
    display.setCursorPos(x, y)
    display.write(text)
end