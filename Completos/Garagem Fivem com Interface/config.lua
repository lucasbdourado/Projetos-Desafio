-----------------------------------------
------		Author: Lucas Dourado  ------
-----------------------------------------
------	 Discord: Nego2KBR#2482   -------
-----------------------------------------

-- Any questions call me on Discord

Config = {}

Config.DrawDistance         = 20.0
Config.MarkerType           = 20
Config.MarkerSize           = {x = 0.7, y = 0.7, z = 0.7}
Config.MarkerColor          = {r = 240, g = 52, b = 52, a = 100}
Config.UseVehicleLockSystem = true -- Segurança do veículo(Trancar / Destrancar) com a tecla "M".

Config.GarageID = { -- Códigos de referência das garagens, não mexer nisso, por ser native do jogo.
	['garage_small'] = 149249, 
	['garage_medium'] = 148737, 
	['garage_large'] = 146433, 
}

Config.Security = {
	["Security"] = { 
		Pos = vector3(-202.0,-1158.4,23.8),
		SpawnPoint = {
			x = -223.6, y = -1162.9, z = 23.0
		}
	}
}

Config.PropertyGarages = {
	["paleto_1"] = {
		Propriedade = 144,
		interior = "garage_small",

		inLocation = vector3(-293.6, 6337.95, 32.3 ),
		
        spawnOutLocation = {x = -299.4,y = 6343.48,z = 30.26,h = 47.0},
	}
}

Config.Garages = {
	["garage_central"] = {
		SpawnMenu = vector3(213.8, -808.7, 31.0),
		GarageArea = vector3(227.2,-785.95, 29.24),
		Radius = 50.0
	}
}

Config.Interiors = {
	['garage_small'] = {
		entrance = {0.0, -5.0, 0.0},
		outMarker = vector3(179.0,-1005.0,-99.0),
		heading = 1.39,
		maxSlots = 2,
		veh = {
			[1] = {pos = {2.0, 0.0, 0.0}, heading = 181.59},
			[2] = {pos = {-2.0, 0.0, 0.0}, heading = 181.59},
		},
	},
	['garage_medium'] = {
		entrance = {0.0, -7.0, 0.0},
		outMarker = vector3(208.0,-999.0,-99.0),
		heading = 0.67,
		maxSlots = 6,
		veh = {
			[1] = {pos = {-4.97, -3.24, 0.0}, heading = 0.86},
			[2] = {pos = {0.0, -3.24, 0.0}, heading = 0.86},
			[3] = {pos = {4.97, -3.24, 0.0}, heading = 0.86},
			[4] = {pos = {-4.97, 3.24, 0.0}, heading = 180.0},
			[5] = {pos = {0.0, 3.24, 0.0}, heading = 180.0},
			[6] = {pos = {4.97, 3.24, 0.0}, heading = 180.0},
		},
	},
	['garage_large'] = {
		entrance = {-0.5, -12.00, 0.0},
		outMarker = vector3(228.0,-1006.0,-99.0),
		heading = 0.0,
		maxSlots = 10,
		veh = {
			[1] = {pos = {4.77, -10.0, 0.0}, heading = 91.0},
			[2] = {pos = {4.77, -5.5, 0.0}, heading = 91.0},
			[3] = {pos = {4.77, -1.0, 0.0}, heading = 91.0},
			[4] = {pos = {4.77, 3.5, 0.0}, heading = 91.0},
			[5] = {pos = {4.77, 8.0, 0.0}, heading = 91.0},
			[6] = {pos = {-4.77, -10.0, 0.0}, heading = 272.26},
			[7] = {pos = {-4.77, -5.5, 0.0}, heading = 272.26},
			[8] = {pos = {-4.77, -1.0, 0.0}, heading = 272.26},
			[9] = {pos = {-4.77, 3.5, 0.0}, heading = 272.26},
			[10] = {pos = {-4.77, 8.0, 0.0}, heading = 272.26},
		},
	},
}