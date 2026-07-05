fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'McCord Discord: .mccord.'
description 'gl_ecall - Automatic Emergency Call System'
version '0.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/crash.lua',
    'client/ecall.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'ox_lib',
    'emergencydispatch'
}