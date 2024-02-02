local event = require("event")
local com = require("component")
local computer = require("computer")
local interface = com.me_interface
local name = ""
local whitelist = { 'DrMattsuu', 'burnthisout' }

function checkName(name)
    for index, value in ipairs(whitelist) do
        if value == name then
            return true
        end
    end
    return false
end

function fill_inventory(fingerprint, direction, amount)
    local ok, value = pcall(interface.exportItem, fingerprint, direction, amount)
    if ok then
        return value.size
    end
    return 0
end

function count_empty_slots()
    local count = 0
    for i = 1, 36 do
        if com.pim.getAllStacks(0)[i] == nil then
            count = count + 1
        end
    end
    return count
end

local id = io.read("*l")
while true do
    name = com.pim.getInventoryName()
    if name ~= "" and name ~= "pim" then
        if checkName(name) then
            local count = count_empty_slots()
            for j = 1, count do
                fill_inventory({ id = id, dmg = 0 }, "UP", 64)
            end
            if count ~= 0 then
                print('Load completed')
            end
        else
            print("Not whitelisted")
        end
    end
    os.sleep(0.1)
end