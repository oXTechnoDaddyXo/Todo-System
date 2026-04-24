--[[
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                                                                   ║
    ║               T O D O   S Y S T E M                               ║
    ║             ─────────────────────────                             ║
    ║            VORP TODO & CHECKBOX SCRIPT                            ║
    ║                 Redemption Script                                 ║
    ║                                                                   ║
    ║                                                                   ║
    ║                                                                   ║
    ╠═══════════════════════════════════════════════════════════════════╣
    ║   Server:    oXTechnoKhaliXo Scripts                              ║
    ║   Creator:   oXTechnoKhaliXo                                      ║
    ║   Discord:   https://discord.gg/8NjehNeEuZ                        ║
    ╠═══════════════════════════════════════════════════════════════════╣
    ║   © 2026 oXTechnoKhaliXo | All Rights Reserved                    ║
    ╚═══════════════════════════════════════════════════════════════════╝
]]
fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'oXTechnoKhaliXo'
description 'VORP Western Todo List (Sheriff Ledger Style)'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
	'html/logo.png',
	'tasks.json',
	'config.lua'
}

client_scripts {
	'config.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'vorp_core'
}