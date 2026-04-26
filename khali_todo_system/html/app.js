let container = document.getElementById("container");
let taskList = document.getElementById("taskList");
let title = document.getElementById("title");

window.addEventListener("message", function(event) {
    let data = event.data;

    if (data.action === "open") {
        container.classList.remove("hidden");
        typeWriter("📜 Cowboy Ledger");
    }

    if (data.action === "close") {
        container.classList.add("hidden");
    }

    if (data.action === "loadTasks") {
        renderTasks(data.tasks);
    }
});

function typeWriter(text) {
    title.innerHTML = "";
    let i = 0;

    let interval = setInterval(() => {
        title.innerHTML += text[i];
        i++;
        if (i >= text.length) clearInterval(interval);
    }, 40);
}

function renderTasks(tasks) {
    taskList.innerHTML = "";

    tasks.forEach(t => {
        let div = document.createElement("div");
        div.className = "task";

        let text = document.createElement("span");
        text.innerText = t.text;

        if (t.done) text.classList.add("done");

        let actions = document.createElement("div");

        let doneBtn = document.createElement("button");
        doneBtn.innerText = "✔";
        doneBtn.onclick = () => {
            fetch(`https://${GetParentResourceName()}/completeTask`, {
                method: "POST",
                body: JSON.stringify({ id: t.id })
            });
        };

        let delBtn = document.createElement("button");
        delBtn.innerText = "🗑";
        delBtn.onclick = () => {
            fetch(`https://${GetParentResourceName()}/deleteTask`, {
                method: "POST",
                body: JSON.stringify({ id: t.id })
            });
        };

        actions.appendChild(doneBtn);
        actions.appendChild(delBtn);

        div.appendChild(text);
        div.appendChild(actions);

        taskList.appendChild(div);
    });
}

function addTask() {
    let input = document.getElementById("taskInput");

    fetch(`https://${GetParentResourceName()}/addTask`, {
        method: "POST",
        body: JSON.stringify({ text: input.value })
    });

    input.value = "";
}

function closeUI() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: "POST"
    });
}