function guiClear(display)
    display.setBackgroundColor(colors.black)
    display.clear()
    display.setCursorPos(1, 1)
    display.setTextScale(1)
end

function guiDrawText(display, x, y, text, text_color, bg_color)
    display.setBackgroundColor(bg_color)
    display.setTextColor(text_color)
    display.setCursorPos(x, y)
    display.write(text)
end

function guiDrawLine(display, x, y, length, size, bar_color)
    for y_pos = y, y + size - 1 do
        display.setBackgroundColor(bar_color)
        display.setCursorPos(x, y_pos)
        display.write(string.rep(" ", length))
    end
end

function guiGetColorByLevel(percent_progress, gui_colors)
    for _, condition in pairs(gui_colors.levels) do
        if percent_progress <= condition.percent then
            return condition.color
        end
    end
end

function guiProgressBar(display, x, y, name, length, size, min_value, max_value, gui_colors)
    local display_x, display_y = display.getSize()
    local bar_size = math.floor((min_value / max_value) * length)
    local percent_progress = math.floor((min_value / max_value) * 100)
    local text = ("%s %d%%"):format(name, percent_progress)
    local bar_color = guiGetColorByLevel(percent_progress, gui_colors)

    guiDrawLine(display, x, y, length, size, gui_colors.background_color)
    guiDrawLine(display, x, y, bar_size, size, bar_color)

    if bar_size > display_x / 2 + #text / 2 then
        guiDrawText(display, display_x / 2 - #text / 2 + 2, y + size / 2, text, gui_colors.text_color, bar_color)
    elseif bar_size > #text then
        guiDrawText(display, (x + bar_size) - #text, y + size / 2, text, gui_colors.text_color, bar_color)
    else
        guiDrawText(display, display_x / 2 - #text / 2 + 2, y + size / 2, text, gui_colors.text_color, gui_colors.background_color)
    end
end