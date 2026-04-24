
local tasks = {}
local idCounter = 0

local resource = GetCurrentResourceName()
local file = "tasks.json"

local function save()
    SaveResourceFile(resource, file, json.encode({
        tasks = tasks,
        idCounter = idCounter
    }), -1)
end

local function load()
    local data = LoadResourceFile(resource, file)

    if data then
        local decoded = json.decode(data)
        if decoded then
            tasks = decoded.tasks or {}
            idCounter = decoded.idCounter or 0
        end
    end
end

AddEventHandler("onResourceStart", function(res)
    if res ~= resource then return end
    load()
end)

RegisterNetEvent("khali_todo:requestTasks", function()
    TriggerClientEvent("khali_todo:sendTasks", source, tasks)
end)

RegisterNetEvent("khali_todo:addTask", function(text)
    idCounter = idCounter + 1

    tasks[idCounter] = {
        id = idCounter,
        text = text,
        done = false
    }

    save()
    TriggerClientEvent("khali_todo:sendTasks", -1, tasks)
end)

RegisterNetEvent("khali_todo:toggleTask", function(id)
    if tasks[id] then
        tasks[id].done = not tasks[id].done
        save()
    end

    TriggerClientEvent("khali_todo:sendTasks", -1, tasks)
end)

RegisterNetEvent("khali_todo:deleteTask", function(id)
    if tasks[id] then
        tasks[id] = nil
        save()
    end

    TriggerClientEvent("khali_todo:sendTasks", -1, tasks)
end)