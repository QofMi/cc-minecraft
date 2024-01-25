require("gui")
require("isa")

local ME_BRIDGE = peripheral.find("meBridge")
local display = peripheral.find("monitor")
local display_x, display_y = display.getSize()
local StorageData = {
    x = 2,
    y = 8,
    name = "Storage",
    size = 3,
    length = display_x - 2,
}
local StorageColors = {
    background_color = colors.gray,
    text_color = colors.black,
    levels = {
        {
            percent = 70,
            color = colors.green
        },
        {
            percent = 90,
            color = colors.orange
        },
        {
            percent = 100,
            color = colors.red
        }
    }
}
local AEEnergyData = {
    x = 2,
    y = 3,
    name = "AE Energy",
    size = 3,
    length = display_x - 2,
}
local AEEnergyColors = {
    background_color = colors.gray,
    text_color = colors.black,
    levels = {
        {
            percent = 30,
            color = colors.red
        },
        {
            percent = 60,
            color = colors.orange
        },
        {
            percent = 100,
            color = colors.green
        }
    }
}

function offline(display, data, gui_colors)
    local name = ("%s is offline"):format(data.name)
    guiDrawLine(display, data.x, data.y, data.length, data.size, gui_colors.background_color)
    guiDrawText(display, display_x / 2 - #name / 2 + 2, data.y + data.size / 2, name, colors.black, gui_colors.background_color)
end

guiClear(display)
while true do
    if not is_none(ME_BRIDGE.getMaxEnergyStorage()) then
        guiProgressBar(
                display,
                2,
                3,
                "AE Energy",
                display_x - 2,
                3,
                ME_BRIDGE.getEnergyStorage(),
                ME_BRIDGE.getMaxEnergyStorage(),
                AEEnergyColors
        )
    else
        offline(display, AEEnergyData, AEEnergyColors)
    end

    if not is_none(ME_BRIDGE.getTotalItemStorage()) then
        guiProgressBar(
                display,
                2,
                8,
                "Storage",
                display_x - 2,
                3,
                ME_BRIDGE.getUsedItemStorage(),
                ME_BRIDGE.getTotalItemStorage(),
                StorageColors
        )
    else
        offline(display, StorageData, StorageColors)
    end
    sleep(0.75)
end