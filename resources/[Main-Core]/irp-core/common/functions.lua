local Charset = {}

for i = 48,  57 do table.insert(Charset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

irpCore.GetRandomString = function(length)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return irpCore.GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

irpCore.GetConfig = function()
	return Config
end

irpCore.GetWeapon = function(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = irpCore.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return i, weapons[i]
		end
	end
end

irpCore.GetWeaponList = function()
	return Config.Weapons
end

irpCore.GetWeaponLabel = function(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = irpCore.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return weapons[i].label
		end
	end
end

irpCore.GetWeaponComponent = function(weaponName, weaponComponent)
	weaponName = string.upper(weaponName)
	local weapons = irpCore.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].name == weaponComponent then
					return weapons[i].components[j]
				end
			end
		end
	end
end

irpCore.DumpTable = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. irpCore.DumpTable(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

irpCore.Round = function(value, numDecimalPlaces)
	return irpCore.Math.Round(value, numDecimalPlaces)
end
