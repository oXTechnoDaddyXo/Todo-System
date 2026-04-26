-- =========================
-- AUTO DATABASE SETUP
-- =========================
CreateThread(function()
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS khali_todo_tasks (
            id INT AUTO_INCREMENT PRIMARY KEY,
            identifier VARCHAR(60) NOT NULL,
            text VARCHAR(255) NOT NULL,
            done TINYINT(1) DEFAULT 0
        )
    ]])

    print("^2[TODO]^0 Database ready (khali_todo_tasks)")
end)

-- =========================
-- FUNCTIONS
-- =========================
local function fetchTasks(src)
    local identifier = GetPlayerIdentifier(src, 0)

    local result = MySQL.query.await(
        "SELECT * FROM khali_todo_tasks WHERE identifier = ?",
        { identifier }
    )

    TriggerClientEvent("todo:sendTasks", src, result or {})
end

-- =========================
-- EVENTS
-- =========================
RegisterNetEvent("todo:requestTasks", function()
    fetchTasks(source)
end)

RegisterNetEvent("todo:addTask", function(text)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)

    MySQL.insert(
        "INSERT INTO khali_todo_tasks (identifier, text, done) VALUES (?, ?, ?)",
        { identifier, text, 0 }
    )

    fetchTasks(src)
end)

RegisterNetEvent("todo:completeTask", function(id)
    local src = source

    MySQL.update(
        "UPDATE khali_todo_tasks SET done = 1 WHERE id = ?",
        { id }
    )

    fetchTasks(src)
end)

RegisterNetEvent("todo:deleteTask", function(id)
    local src = source

    MySQL.update(
        "DELETE FROM khali_todo_tasks WHERE id = ?",
        { id }
    )

    fetchTasks(src)
end)