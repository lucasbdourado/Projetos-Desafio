-----------------------------------------
------		Author: Lucas Dourado  ------
-----------------------------------------
------	 Discord: Nego2KBR#2482   -------
-----------------------------------------

-- Any questions call me on Discord

fx_version 'adamant'

game 'gta5'

description 'ESX 2K Garage'

author 'Lucas Dourado'

version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/function.lua'
}

ui_page 'html/index.html'

files {
    "html/index.html",
    "html/src/css/style.css",
	"html/src/img/model/*.png",
    "html/src/js/script.js"
}

dependency 'es_extended'