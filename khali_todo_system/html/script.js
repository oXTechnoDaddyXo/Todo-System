let locale = {};
let isOpen = false;

window.addEventListener("message", (event) => {
    const data = event.data;

    if (data.action === "open") {
        isOpen = true;
        locale = data.locale || {};

        document.getElementById("app").classList.remove("hidden");

        document.getElementById("title").innerText = locale.title;
        document.getElementById("taskInput").placeholder = locale.note;
    }

    if (data.action === "forceClose") {
        isOpen = false;
        document.getElementById("app").classList.add("hidden");
    }

    if (data.action === "loadTasks") {
        if (!isOpen) return;
        renderTasks(data.tasks || {});
    }
});

window.addNote = function () {
    const v = document.getElementById("taskInput").value;
    if (!v) return;

    fetch(`https://${GetParentResourceName()}/addTask`, {
        method: "POST",
        body: JSON.stringify({ text: v })
    });

    document.getElementById("taskInput").value = "";
};

window.toggleTask = function (id) {
    fetch(`https://${GetParentResourceName()}/toggleTask`, {
        method: "POST",
        body: JSON.stringify({ id })
    });
};

window.deleteTask = function (id) {
    fetch(`https://${GetParentResourceName()}/deleteTask`, {
        method: "POST",
        body: JSON.stringify({ id })
    });
};

window.closeUI = function () {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: "POST"
    });
};

window.renderTasks = function (tasks) {
    const list = document.getElementById("taskList");
    list.innerHTML = "";

    for (const id in tasks) {
        const t = tasks[id];
        if (!t) continue;

        const li = document.createElement("li");

        li.innerHTML = `
            <input type="checkbox" ${t.done ? "checked" : ""} onclick="toggleTask(${t.id})">
            <span class="${t.done ? "done" : ""}">${t.text}</span>
            <button onclick="deleteTask(${t.id})">X</button>
        `;

        list.appendChild(li);
    }
};