
local playerTasks = {}
local idCounters = {}

local resource = GetCurrentResourceName()
local file = "tasks.json"

-- SAVE
local function save()
    SaveResourceFile(resource, file, json.encode({
        playerTasks = playerTasks,
        idCounters = idCounters
    }), -1)
end

-- LOAD
local function load()
    local data = LoadResourceFile(resource, file)

    if data then
        local decoded = json.decode(data)
        if decoded then
            playerTasks = decoded.playerTasks or {}
            idCounters = decoded.idCounters or {}
        end
    end
end

AddEventHandler("onResourceStart", function(res)
    if res ~= resource then return end
    load()
end)

-- GET PLAYER IDENTIFIER
local function getIdentifier(src)
    local identifiers = GetPlayerIdentifiers(src)
    return identifiers[1] or tostring(src)
end

-- REQUEST TASKS
RegisterNetEvent("khali_todo:requestTasks", function()
    local src = source
    local id = getIdentifier(src)

    playerTasks[id] = playerTasks[id] or {}
    idCounters[id] = idCounters[id] or 0

    TriggerClientEvent("khali_todo:sendTasks", src, playerTasks[id])
end)

-- ADD TASK
RegisterNetEvent("khali_todo:addTask", function(text)
    local src = source
    local id = getIdentifier(src)

    playerTasks[id] = playerTasks[id] or {}
    idCounters[id] = (idCounters[id] or 0) + 1

    local taskId = idCounters[id]

    playerTasks[id][taskId] = {
        id = taskId,
        text = text,
        done = false
    }

    save()
    TriggerClientEvent("khali_todo:sendTasks", src, playerTasks[id])
end)

-- TOGGLE TASK
RegisterNetEvent("khali_todo:toggleTask", function(taskId)
    local src = source
    local id = getIdentifier(src)

    if playerTasks[id] and playerTasks[id][taskId] then
        playerTasks[id][taskId].done = not playerTasks[id][taskId].done
        save()
    end

    TriggerClientEvent("khali_todo:sendTasks", src, playerTasks[id])
end)

-- DELETE TASK
RegisterNetEvent("khali_todo:deleteTask", function(taskId)
    local src = source
    local id = getIdentifier(src)

    if playerTasks[id] then
        playerTasks[id][taskId] = nil
        save()
    end

    TriggerClientEvent("khali_todo:sendTasks", src, playerTasks[id])
end)