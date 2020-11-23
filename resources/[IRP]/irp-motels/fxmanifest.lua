fx_version 'adamant'
games { 'gta5' }

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@irp-core/locale.lua',
    'server/server.lua',
    'config.lua',
    'locales/en.lua'
}

client_scripts {
	'@irp-core/locale.lua',
    'client/client.lua',
    'config.lua',
    'locales/en.lua'
}

dependencies {
	'irp-core',
	'instance',
    'cron',
    'irp-datastore'
}

exports {
    'imClosesToRoom'
}