local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	 {name="Convenience Store",color=2, id=52, x= 374.225, y= 326.717, z = 102.800},
	 {name="Convenience Store",color=2, id=52, x= 25.8929, y= -1346.71, z = 28.597},
	 {name="Convenience Store",color=2, id=52, x= -48.1829, y= -1756.99, z = 28.500},
	 {name="Convenience Store",color=2, id=52, x= -707.769, y= -913.886, z = 18.315},
	 {name="Convenience Store",color=2, id=52, x= -1223.69, y= -907.031, z = 11.426},
	 {name="Convenience Store",color=2, id=52, x= -1487.15, y= -380.113, z = 39.2634},
	 {name="Convenience Store",color=2, id=52, x= 1163.24, y= -323.212, z = 68.3051},
	 {name="Convenience Store",color=2, id=52, x= 1136.09, y= -981.251, z = 45.5158},
	 {name="Convenience Store",color=2, id=52, x= 2556.55, y= 382.399, z = 107.723},
	 {name="Convenience Store",color=2, id=52, x= 547.382, y= 2670.33, z = 41.2565},
	 {name="Convenience Store",color=2, id=52, x= 1961.21, y= 3741.6, z = 31.4437},
	 {name="Convenience Store",color=2, id=52,x= 1698.95, y= 4924.46, z = 41.1637},
	 {name="Convenience Store",color=2, id=52, x= 1729.65, y= 6415.65, z = 34.137},
	 {name="Convenience Store",color=2, id=52, x= -3243.03, y= 1001.66, z = 11.9307},
	 {name="Convenience Store",color=2, id=52, x= 2678.06, y= 3281.11, z = 55.2411},
	 {name="Convenience Store",color=2, id=52, x= -3038.939, y= 585.954, z = 6.908},
	 {name="Convenience Store",color=2, id=52, x= -1820.37, y= 792.6558, z = 138.1091},
	 {name="Convenience Store",color=2, id=52, x= 1135.808, y= -982.281, z = 45.415},
	 {name="Convenience Store",color=2, id=52, x= -1487.553, y= -379.107, z = 39.163},
	 {name="Convenience Store",color=2, id=52, x= -2968.243, y= 390.910, z = 14.043},
	 {name="Convenience Store",color=2, id=52, x= 1166.024, y= 2708.930, z = 37.157},
	 {name="Convenience Store",color=2, id=52, x= 1392.562, y= 3604.684, z = 33.980},
	 {name="Convenience Store",color=2, id=52, x= -1393.409, y= -606.624, z = 29.319},
	 {name="Convenience Store",color=2, id=52, x= -559.906, y= 287.093, z = 81.176},
	 {name="Ammunation",color=1, id=110, x= -662.180, y= -934.961, z =20.929},
	 {name="Ammunation",color=1, id=110, x= 810.25, y= -2157.60, z =28.72},
	 {name="Ammunation",color=1, id=110, x= 1693.44, y= 3760.16, z =33.81},
	 {name="Ammunation",color=1, id=110, x= -330.24, y= 6083.88, z =30.55},
	 {name="Ammunation",color=1, id=110, x= 252.63, y= -50.00, z =68.99},
	 {name="Ammunation",color=1, id=110, x= 22.09, y= -1107.28, z =28.90},
	 {name="Ammunation",color=1, id=110, x= 2567.69, y= 294.38, z =107.83},
	 {name="Ammunation",color=1, id=110, x= -1117.58, y= 2698.61, z =17.65},
	 {name="Ammunation",color=1, id=110, x= 842.44, y= -1033.42, z =27.29},
	 {name="Tool Shop",color=11, id=402, x= 44.2555, y= -1747.69,  z = 28.5848},
	 {name="Barber Shop", color=51, id=71, x=136.8, y=-1708.4, z=28.3},
	 {name="Barber Shop", color=51, id=71, x=-1282.6, y=-1116.8, z=6.0},
	 {name="Barber Shop", color=51, id=71, x=1931.5, y=3729.7, z=31.8},
	 {name="Barber Shop", color=51, id=71, x=1212.8, y=-472.9, z=65.2},
	 {name="Barber Shop", color=51, id=71, x=-32.9, y=-152.3, z=56.1},
	 {name="Barber Shop", color=51, id=71, x=-278.1, y=6228.5, z=30.7},
	 {name="Clothing Store", color=4, id=73, x=72.254, y=-1399.102, z=28.376},
	 {name="Clothing Store", color=4, id=73, x=-703.776,  y=-152.258,  z=36.415},
	 {name="Clothing Store", color=4, id=73, x=-167.863,  y=-298.969,  z=38.733},
	 {name="Clothing Store", color=4, id=73, x=428.694,   y=-800.106,  z=28.491},
	 {name="Clothing Store", color=4, id=73, x=-829.413,  y=-1073.710, z=10.328},
	 {name="Clothing Store", color=4, id=73, x=-1447.797, y=-242.461,  z=48.820},
	 {name="Clothing Store", color=4, id=73, x=11.632,    y=6514.224,  z=30.877},
	 {name="Clothing Store", color=4, id=73, x=123.646,   y=-219.440,  z=53.557},
	 {name="Clothing Store", color=4, id=73, x=1696.291,  y=4829.312,  z=41.063},
	 {name="Clothing Store", color=4, id=73, x=618.093,   y=2759.629,  z=41.088},
	 {name="Clothing Store", color=4, id=73, x=1190.550,  y=2713.441,  z=37.222},
	 {name="Clothing Store", color=4, id=73, x=-1193.429, y=-772.262,  z=16.324},
	 {name="Clothing Store", color=4, id=73, x=-3172.496, y=1048.133,  z=19.863},
	 {name="Clothing Store", color=4, id=73, x=-1108.441, y=2708.923,  z=18.107},
	 {name="Clothing Store", color=4, id=73, x=1858.9041748047, y=3687.8701171875,  z=34.267036437988},
	 {name="Clothing Store", color=4, id=73, x=2435.4169921875, y=4965.6123046875,  z=46.810600280762},
	 {name="Tattoo Shop", color=1, id=75, x=1322.645, y=-1651.976, z=52.275},
	 {name="Tattoo Shop", color=1, id=75, x=-1153.676, y=-1425.68, z=4.954},
	 {name="Tattoo Shop", color=1, id=75, x=322.139, y=180.467, z=103.587},
	 {name="Tattoo Shop", color=1, id=75, x=1864.633, y=3747.738, z=33.032},
	 {name="Tattoo Shop", color=1, id=75, x=-293.713, y=6200.04, z=31.487},
	 {name="Tattoo Shop", color=1, id=75, x=-293.713, y=6200.04, z=31.487},
	 {name="Tattoo Shop", color=1, id=75, x=-1220.6872558594, y=-1430.6593017578, z=4.3321843147278},
	 {name="Court House",color=46, id=58, x= -552.8599, y= -190.7369,  z = 38.21967},
	 {name="Vangelico Jewery Store", color=4, id=617, x=-622.097, y=-230.720, z=38.057},
	 {name="Downtown Cab Co.", color=5, id=56, x=903.9481, y=-173.5247, z=74.0756},
	 {name="Burger Shot",color=46, id=106, x = -1194.111, y = -891.712, z = 13.995}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.color)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.name)
      EndTextCommandSetBlipName(info.blip)
    end
end)