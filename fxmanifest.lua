fx_version 'cerulean'
game 'gta5'
resource_name 'builder_peche'

author 'YourName'
description 'Basic test resource'
version '1.0.0'
files {
    
    'html/index.html',
    'html/assets/*',
    
}
client_scripts {

    'client.lua'
}
server_scripts {
    
    'config.lua',
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
ui_page 'html/index.html'