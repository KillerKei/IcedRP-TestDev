fx_version 'bodacious'
games { 'rdr3', 'gta5' }


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

client_script {
  "client.lua",
}



export "GetClosestNPC"
export "IsPedNearCoords"
export "isPed"
export "GroupRank"
export "GlobalObject"
export "retreiveBusinesses"