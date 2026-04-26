<img width="1536" height="1024" alt="promobild" src="https://github.com/user-attachments/assets/ba099a47-fb55-4f09-b0cf-646e8a90d2a9" />

# 🤠 Western Todo List (RedM)

A cinematic Western-style Todo List system for RedM featuring a 3D parchment UI, persistent database storage, and full task management.

## Features
- Western 3D UI
- Auto database creation
- Add / complete / delete tasks
- Persistent storage (oxmysql)
- /todo command

## Installation
1. Place in resources folder
2. ensure oxmysql
3. ensure khali_todo

## Database
CREATE TABLE IF NOT EXISTS khali_todo_tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    text VARCHAR(255) NOT NULL,
    done TINYINT(1) DEFAULT 0
);

## Command
/todo -> Open UI
