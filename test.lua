print("Hello from git")
print("ASDASDASD")


local DRIVE = peripheral.find("ae2:drive")
local ME_BRIDGE = peripheral.find("meBridge")

if DRIVE and ME_BRIDGE then
    for _, cell in pairs(DRIVE.list()) do
        -- print(("K - %s | V - %s"):format(key, val))
        local info = ME_BRIDGE.getItem(cell)
        print(info)
        -- for key, val in pairs() do
        --     print(("K - %s | V - %s"):format(key, val))
        -- end

    end
else
    error("Peripheral is not found")
end