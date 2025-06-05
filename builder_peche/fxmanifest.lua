fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'Basic test resource'
version '1.0.0'
ui_page 'html/dist/index.html'
files {

    'html/dist/*',
    'html/dist/assets/*',

}
client_scripts {

    'client.lua'
}
server_scripts {

    'config.lua',
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}