require("gui")
local ME_BRIDGE = peripheral.find("meBridge")

guiClear()

while true do
    guiProgressBar(
        2,
        5,
        "Storage",
        display_x-2,
        3,
        ME_BRIDGE.getUsedItemStorage(),
        ME_BRIDGE.getTotalItemStorage(),
        colors.green,
        colors.gray
    )
    sleep(0.75)
end