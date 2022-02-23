fx_version 'adamant'
game 'gta5'

author 'Hoàng Đức'
version '1.0.0'
description 'Driving School - convert and edit from esx_dmvschool, ESX to QB-Core Framework'

version '1.0.4'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change this to your preferred language
	'config.lua'
}

server_scripts {
	'server.lua'
}

client_scripts {
	'client.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/logo.png',
	'html/dmv.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}