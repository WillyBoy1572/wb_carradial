fx_version 'cerulean'
game 'gta5'

name         'wb_carradial'
author       'WillyBoy'
version      '1.0.0'
repository   'https://github.com/WillyBoy1572/wb_carradial'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
}

client_scripts {
    'client/*',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared/sh_Config.lua',
}

files {
    'locales/*.json'
}

dependencies {
    'ox_lib',
}