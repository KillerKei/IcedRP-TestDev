fx_version 'adamant'
games { 'gta5' }

client_scripts {

	'@irp-core/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
	'@irp-core/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/server.lua'
}

dependency 'irp-base'
dependency 'irp-core'
dependency 'irp-doorlock'
dependency 'irp-knatusblowtorch'
dependency 'mhacking'