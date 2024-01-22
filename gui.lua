require("isa")

display = peripheral.find("monitor")
display_x, display_y = display.getSize()


function guiClear()
    display.setBackgroundColor(colors.black)
    display.clear()
    display.setCursorPos(1, 1)
    display.setTextScale(1)
end


function guiDrawText(x, y, text, color_text, color_bg)
    display.setBackgroundColor(color_bg)
    display.setTextColor(color_text)
    display.setCursorPos(x, y)
    display.write(text)
end


function guiDrawLine(x, y, length, size, color_bar)
    for y_pos = y, y+size-1 do
        display.setBackgroundColor(color_bar)
        display.setCursorPos(x, y_pos)
        display.write(string.rep(" ", length))
    end
end


function guiProgressBar(x, y, name, length, size, min_value, max_value, color_bar, color_bg)
    local bar_size = math.floor((min_value/max_value)*length)
    local percent_progress = math.floor((min_value/max_value)*100)

    if is_nan(percent_progress) then
        guiClear()
    else
        local text = ("%s %d%%"):format(name, percent_progress)

        if percent_progress >= 95 then
            color_bar = colors.red
        elseif percent_progress >= 80 then
            color_bar = colors.orange
        end

        guiDrawLine(x, y, length, size, color_bg)
        guiDrawLine(x, y, bar_size, size, color_bar)

        if bar_size > display_x/2+#text/2 then
            guiDrawText(display_x/2-#text/2+2, y+size/2, text, colors.black, color_bar)
        elseif bar_size > #text then
            guiDrawText((x+bar_size)-#text, y+size/2, text, colors.black, color_bar)
        else
            guiDrawText(display_x/2-#text/2+2, y+size/2, text, colors.black, color_bg)
        end
    end
end