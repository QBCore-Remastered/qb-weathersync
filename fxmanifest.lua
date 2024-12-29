fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'JaySixty'
description 'Syncs the time & weather for all players on the server and allows editing by command'
version '2.1.0'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/*.lua'
}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'client/*.lua'
}
