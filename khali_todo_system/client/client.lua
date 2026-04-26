local uiOpen = false

RegisterCommand("todo", function()
    uiOpen = not uiOpen

    SetNuiFocus(uiOpen, uiOpen)

    SendNUIMessage({
        action = uiOpen and "open" or "close"
    })

    if uiOpen then
        TriggerServerEvent("todo:requestTasks")
    end
end)

RegisterNUICallback("close", function(_, cb)
    uiOpen = false
    SetNuiFocus(false, false)

    SendNUIMessage({ action = "close" })
    cb("ok")
end)

RegisterNUICallback("addTask", function(data, cb)
    TriggerServerEvent("todo:addTask", data.text)
    cb("ok")
end)

RegisterNUICallback("completeTask", function(data, cb)
    TriggerServerEvent("todo:completeTask", data.id)
    cb("ok")
end)

RegisterNUICallback("deleteTask", function(data, cb)
    TriggerServerEvent("todo:deleteTask", data.id)
    cb("ok")
end)

RegisterNetEvent("todo:sendTasks", function(tasks)
    SendNUIMessage({
        action = "loadTasks",
        tasks = tasks
    })
end)