
local uiOpen = false

-- 🔒 HARD RESET (kein Ghost UI nach Restart)
AddEventHandler("onClientResourceStart", function(res)
    if res ~= GetCurrentResourceName() then return end

    uiOpen = false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    SendNUIMessage({ action = "forceClose" })
end)

-- =========================
-- OPEN ONLY VIA COMMAND
-- =========================
RegisterCommand("todo", function()
    if uiOpen then return end

    uiOpen = true

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)

    SendNUIMessage({
        action = "open",
        locale = Config.Locales[Config.Locale]
    })

    TriggerServerEvent("vorp_todo:requestTasks")
end)

-- =========================
-- SAFE CLOSE
-- =========================
local function closeUI()
    if not uiOpen then return end

    uiOpen = false

    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    SendNUIMessage({ action = "forceClose" })
end

-- =========================
-- NUI CALLBACKS
-- =========================
RegisterNUICallback("addTask", function(data, cb)
    if data and data.text then
        TriggerServerEvent("khali_todo:addTask", data.text)
    end
    cb(true)
end)

RegisterNUICallback("toggleTask", function(data, cb)
    if data and data.id then
        TriggerServerEvent("khali_todo:toggleTask", data.id)
    end
    cb(true)
end)

RegisterNUICallback("deleteTask", function(data, cb)
    if data and data.id then
        TriggerServerEvent("khali_todo:deleteTask", data.id)
    end
    cb(true)
end)

-- 🔴 CLOSE BUTTON
RegisterNUICallback("close", function(_, cb)
    closeUI()
    cb(true)
end)

-- 🔴 ESC CLOSE FIX
RegisterNUICallback("escape", function(_, cb)
    closeUI()
    cb(true)
end)

-- =========================
-- TASK SYNC
-- =========================
RegisterNetEvent("khali_todo:sendTasks", function(tasks)
    if not uiOpen then return end

    SendNUIMessage({
        action = "loadTasks",
        tasks = tasks or {}
    })
end)