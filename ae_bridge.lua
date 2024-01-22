require("gui")
--require("try-catch")

local ME_BRIDGE = peripheral.find("meBridge")

guiClear()

while true do
    guiProgressBar(
        2,
        6,
        "Storage",
        display_x-2,
        3,
        ME_BRIDGE.getUsedItemStorage(),
        ME_BRIDGE.getTotalItemStorage(),
        colors.green,
        colors.orange,
        colors.red,
        colors.gray
    )

    guiProgressBar(
        2,
        2,
        "AE Energy",
        display_x-2,
        3,
        ME_BRIDGE.getEnergyStorage(),
        ME_BRIDGE.getMaxEnergyStorage(),
        colors.red,
        colors.orange,
        colors.green,
        colors.gray
    )
    sleep(0.75)
end