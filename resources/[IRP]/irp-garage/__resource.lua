resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@irp-core/locale.lua',
	'server.lua',
	's_chopshop.lua'
}

client_script {
	'@irp-core/locale.lua',
	'client.lua',
	'illegal_parts.lua',
	'chopshop.lua',
	'gui.lua'
}


dependencies {
	'irp-core'
}