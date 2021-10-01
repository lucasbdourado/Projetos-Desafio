-----------------------------------------
------		Author: Lucas Dourado  ------
-----------------------------------------
------	 Discord: Nego2KBR#2482   -------
-----------------------------------------

-- Any questions call me on Discord

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                	  = nil
local isInGarage 	  = false
local HasAlreadyEnteredMarker = false
local LastGarage, LastPart, CurrentAction, CurrentActionMsg
local PropertyGarages = {}
local SpawnedCars = {}
local IsInGarageMenu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_2KGarage:getOwnedProperties', function(properties)
		PropertyGarages = properties
    end)

	Citizen.Wait(500)

	ESX.TriggerServerCallback('esx_2KGarage:getLastGarage', function(garageName)
		if garageName then
			if garageName ~= '' then
				isInGarage = true
				LastGarage = garageName
				TriggerServerEvent('esx_N2KGarage:enteredGarage', LastGarage, false, false)
			end
		end
	end)
end)

AddEventHandler('esx_N2KGarage:hasEnteredMarker', function(garage, part)
	if part == 'inLocation' then
		CurrentAction     = 'enter_garage'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para entrar na garagem' 
	elseif part == 'outMarker' then
		CurrentAction     = 'leave_garage'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para sair na garagem'
	elseif part == 'spawn_menu' then
		CurrentAction     = 'menu_garage'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para acessar a garagem' 
	elseif part == 'Security' then
		CurrentAction     = 'security_garage'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para acessar a seguradora' 
	end
end)

AddEventHandler('esx_N2KGarage:hasExitedMarker', function(garage, part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local currentGarage, currentPart
		
		for k,v in pairs(Config.PropertyGarages) do
			if not isInGarage and (PropertyGarages == v.Propriedade) then
				local GaragePos = v.inLocation
				local distance = #(playerCoords - GaragePos)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, GaragePos.x, GaragePos.y, GaragePos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, false, false, false, false)
					letSleep = false

					if distance < (Config.MarkerSize.x * 2) then
						isInMarker, currentGarage, currentPart = true, k, 'inLocation'
					end
				end
			end
		end
		
		for k,v in pairs(Config.Interiors) do
			if isInGarage then
				local GaragePos = v.outMarker
				local distance = #(playerCoords - GaragePos)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, GaragePos.x, GaragePos.y, GaragePos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, false, false, false, false)
					letSleep = false

					if distance < Config.MarkerSize.x then
						isInMarker, currentGarage, currentPart = true, LastGarage, 'outMarker'
					end
				end
			end
		end

		for k,v in pairs(Config.Garages) do
				local GaragePos = v.SpawnMenu
				local distance = #(playerCoords - GaragePos)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, GaragePos.x, GaragePos.y, GaragePos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, false, false, false, false)
				letSleep = false

				if distance < Config.MarkerSize.x then
					isInMarker, currentGarage, currentPart = true, k, 'spawn_menu'
				end
			end
		end

		for k,v in pairs(Config.Security) do
			local GaragePos = v.Pos
			local distance = #(playerCoords - GaragePos)

		if distance < Config.DrawDistance then
			DrawMarker(Config.MarkerType, GaragePos.x, GaragePos.y, GaragePos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, false, false, false, false)
			letSleep = false

			if distance < Config.MarkerSize.x then
				isInMarker, currentGarage, currentPart = true, k, 'Security'
			end
		end
	end


		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastGarage ~= currentGarage or LastPart ~= currentPart)) then
			if (LastGarage and LastPart and LastPartNum) and (LastGarage ~= currentGarage or LastPart ~= currentPart) then
				TriggerEvent('esx_N2KGarage:hasExitedMarker', LastGarage, LastPart)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastGarage              = currentGarage
			LastPart                = currentPart

			TriggerEvent('esx_N2KGarage:hasEnteredMarker', currentGarage, currentPart)
		end
		
		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_N2KGarage:hasExitedMarker', LastGarage, LastPart)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
		
	for k,v in pairs(Config.Garages) do

		local blip = AddBlipForCoord(v.SpawnMenu.x, v.SpawnMenu.y, v.SpawnMenu.z)

		SetBlipSprite (blip, 357)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Garagem")
		EndTextCommandSetBlipName(blip)

	end

	for k,v in pairs(Config.Security) do

		local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

		SetBlipSprite (blip, 68)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Seguradora")
		EndTextCommandSetBlipName(blip)

	end

end)

function EnterGarageFunction()
	if IsPedInAnyVehicle(PlayerPedId(),  false) then
		local vehicle       = GetVehiclePedIsIn(PlayerPedId(),  false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local vehName = GetEntityModel(vehicle)
		local vehModel = string.lower(GetDisplayNameFromVehicleModel(vehicleProps.model))
		local vehDisplayName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
		
		if GetPedInVehicleSeat(vehicle,  -1) == PlayerPedId() then
			BringVehicleToHalt(vehicle, 1.0, 1)
			Citizen.Wait(1000)
			ESX.TriggerServerCallback('esx_N2KGarage:enterGarage',function(position, stored)
				if stored == 0 then
					exports['mythic_notify']:SendAlert('error', 'Não há espaço para a guardar este carro na garagem!')
				elseif stored == 1 then
					TriggerServerEvent('esx_N2KGarage:enteredGarage', LastGarage, position, vehicleProps)
					Citizen.Wait(1000)
					DeleteVehicle(vehicle)
					isInGarage = true
				end
			end, LastGarage, vehicleProps, vehModel, vehDisplayName)
		else
			exports['mythic_notify']:SendAlert('error', 'Somente o dono do veículo pode guardar o veículo na garagem!')
		end
	else
		TriggerServerEvent('esx_N2KGarage:enteredGarage', LastGarage, false, false)
		isInGarage = true
	end
end

function LeaveGarageFunction(inVehicle, vehicleProp)
	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local exit = Config.PropertyGarages[LastGarage].spawnOutLocation

	DoScreenFadeOut(800)
	while not IsScreenFadedOut() do
		Wait(0)
	end

	for _,z in pairs(SpawnedCars) do
        local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 30.0, z.vehicle.model, 71)
        DeleteVehicle(vehicle)
    end
	Citizen.Wait(2000)

	ESX.Game.Teleport(playerPed, {x = exit.x, y = exit.y, z = exit.z, h = exit.h}, function()
	end)

	if inVehicle then
		ESX.Game.SpawnVehicle(vehicleProp.model,  {x = exit.x, y = exit.y, z = exit.z}, exit.h, function(vehicle)
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
			ESX.Game.SetVehicleProperties(vehicle, vehicleProp)
			SetVehicleOnGroundProperly(vehicle)
		end)
	end
		
	TriggerServerEvent('esx_2KGarage:deleteLastGarage')
	Citizen.Wait(1500)
	DoScreenFadeIn(1250)
    Citizen.Wait(500)
	SpawnedCars = {}
	isInGarage = false
end

function OpenGarageMenu()

	local vehicle = {}

	if not IsInGarageMenu then
		IsInGarageMenu = true
		SetNuiFocus(true, true)

		SendNUIMessage({
            show = true
        })
	end
end

function GarageMenuFunction()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_actions', {
		title    = 'Garage Menu',
		align    = 'top-left',
		elements = {
			{label = 'Guardar Veículo', value = 'store_vehicle'},
			{label = 'Retirar Veículo', value = 'get_vehicle'}
	}}, function(data, menu)
		if data.current.value == 'store_vehicle' then
			local vehicles = ESX.Game.GetVehiclesInArea(Config.Garages[LastGarage].GarageArea, Config.Garages[LastGarage].Radius)
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
			local vehCoords = GetEntityCoords(vehicle)
			local vehHeading = GetEntityHeading(vehicle)
			local vehPos = {
				x = vehCoords.x,
				y = vehCoords.y,
				z = vehCoords.z,
				h = vehHeading
			}
			local vehModel = string.lower(GetDisplayNameFromVehicleModel(vehProps.model))
			local vehDisplayName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			if vehicles then
				if vehicle then
					for i = 1, #vehicles, 1 do
						if vehicles[i] == vehicle then
							ESX.TriggerServerCallback('esx_2KGarage:storeGarageVehicle', function(stored)
								if stored then
									DeleteVehicle(vehicle)
								end
							end, vehProps, LastGarage, vehPos, vehModel, vehDisplayName)
						end
					end
				end
			end
			menu.close()
		elseif data.current.value == 'get_vehicle' then
			ListVehiclesMenu(LastGarage)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function SecurityMenuFunction()
	ESX.UI.Menu.CloseAll()
	local vehicleInfo = {}

	ESX.TriggerServerCallback('esx_N2KGarage:getVehiclesInSecurity', function(vehicles)
		IsInGarageMenu = true

		for i=1, #vehicles, 1 do
			local hashVehicle = vehicles[i].vehicle.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicle)
			local labelvehicle
			local plate = vehicles[i].vehicle.plate

			labelvehicle = vehicleName.. ' (' .. plate .. ') '

			table.insert(vehicleInfo, {modelo = vehicleName})
		end

		SetNuiFocus(true, true)
		SendNUIMessage({
            show = true,
			cars = vehicles,
			vehInfo = vehicleInfo,
			locale = "security"
        })

	end)
end

function RecoveryVehicle(vehicle, plate)
	print(plate)
	local vehicles = ESX.Game.GetVehicles()
	local found = false
	for i = 1, #vehicles, 1  do
		if vehicles[i] ~= -1 then
			local vehPropIndex = ESX.Game.GetVehicleProperties(vehicles[i])
			if vehPropIndex.plate == plate and DoesEntityExist(vehicles[i]) and GetEntityHealth(vehicles[i]) > 0 then
					found = true
					exports['mythic_notify']:SendAlert('error', 'Seu veículo foi rastreado e a ultima posição dele foi colocada no seu GPS!')

					local blipCar = AddBlipForEntity(vehicles[i])
						SetBlipSprite (blipCar, 225)
						SetBlipDisplay(blipCar, 4)
						SetBlipScale  (blipCar, 0.6)
						SetBlipColour (blipCar, 11)
						SetBlipAsShortRange(blipCar, true)

						EndTextCommandSetBlipName(blipCar)
					return
			end
		end
	end
	if not found then
		ESX.Game.SpawnVehicle(vehicle.model,  {x = Config.Security[LastGarage].SpawnPoint.x, y = Config.Security[LastGarage].SpawnPoint.y, z = Config.Security[LastGarage].SpawnPoint.z}, 90.0, function(callback_vehicle)
			ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
			SetVehRadioStation(callback_vehicle, "OFF")
			SetVehicleOnGroundProperly(callback_vehicle)
			if DoesEntityExist(callback_vehicle) then
				exports['mythic_notify']:SendAlert('inform', "Seu veículo foi recuperado e está no pátio ao lado!")
			end
		end)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'enter_garage' then
					EnterGarageFunction()
				elseif CurrentAction == 'leave_garage' then
					LeaveGarageFunction(false, false)
				elseif CurrentAction == 'menu_garage' then
					ListVehiclesMenu(LastGarage)
				elseif CurrentAction == 'security_garage' then
					SecurityMenuFunction()
				end
				CurrentAction = nil
			end
		end
	end
end)

function ListVehiclesMenu(garage)
	IsInGarageMenu = true
	local elements = {}

	ESX.TriggerServerCallback('esx_N2KGarage:getVehiclesInGarage', function(vehicles)
		SetNuiFocus(true, true)
		SendNUIMessage({
            show = true,
			cars = vehicles,
			locale = "garage"
        })
	end, garage)	
end

function SpawnVehicle(vehicle, plate, position, garage)
	ESX.Game.SpawnVehicle(vehicle.model,  {x = position.x, y = position.y, z = position.z}, position.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleOnGroundProperly(callback_vehicle)
	end)
	TriggerServerEvent('esx_2KGarage:deleteVehicle', garage, vehicle)
end

RegisterNetEvent('esx_2KGarage:insideGarage')
AddEventHandler('esx_2KGarage:insideGarage', function(Garagem)
	local playerPed = PlayerPedId()
	local Interior = Config.PropertyGarages[Garagem].interior
	local InteriorID = Config.GarageID[Interior]
	local exit = Config.PropertyGarages[Garagem].spawnOutLocation
	
	PinInteriorInMemory(InteriorID)

	TriggerServerEvent('esx_2KGarage:saveLastGarage', Garagem)
	
	DoScreenFadeOut(800)
	while not IsScreenFadedOut() do
		Wait(0)
	end
	Citizen.Wait(500)

	local offset = Config.Interiors[Interior]
	local entrada = GetOffsetFromInteriorInWorldCoords(InteriorID, offset.entrance[1], offset.entrance[2], offset.entrance[3])
	ESX.Game.Teleport(playerPed, {x = entrada[1], y = entrada[2], z = entrada[3], h = offset.heading}, function()
	end)
	ESX.TriggerServerCallback('esx_N2KGarage:getVehiclesInGarage', function(vehicles)
		for i=1, #vehicles, 1 do
			for j,l in pairs(offset.veh) do
				if vehicles[i].slot == j then
					local vehPos = GetOffsetFromInteriorInWorldCoords(InteriorID, l.pos[1], l.pos[2], l.pos[3])
					ESX.Game.SpawnLocalVehicle(vehicles[i].vehicle.model,{x = vehPos[1], y = vehPos[2], z = vehPos[3] + 1}, l.heading, function(car)
						ESX.Game.SetVehicleProperties(car, vehicles[i].vehicle)
						SetVehRadioStation(car, "OFF")
						SetVehicleOnGroundProperly(car)
						SetEntityInvincible(car, true)
						SetEntityProofs(car, true, true, true, true, true, true, 1, true)
						SetVehicleTyresCanBurst(car, false)
						SetVehicleCanBreak(car, false)
						SetVehicleCanBeVisiblyDamaged(car, false)
						SetEntityCanBeDamaged(car, false)
						SetVehicleExplodesOnHighExplosionDamage(car, false)


						local vehPlate = GetVehicleNumberPlateText(car):gsub("^%s*(.-)%s*$", "%1")
						table.insert(SpawnedCars,{slot = vehicles[i].slot, vehicle = vehicles[i].vehicle, plate = vehicles[i].vehicle.plate, pos = vehPos})
					end)
				end
			end
		end
	end, Garagem)
	Citizen.Wait(3000)
	DoScreenFadeIn(1250)
    Citizen.Wait(500)

	Citizen.CreateThread(function()
		while isInGarage do
			Citizen.Wait(0)
			local vehicle       = GetVehiclePedIsIn(PlayerPedId(),  false)
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			if IsPedInAnyVehicle(PlayerPedId(),  false) and isInGarage then
				local x,y,z = table.unpack(GetEntityVelocity(vehicle))
				if (x > 1.5 or y > 1.5 or z > 1.5) or (x < -1.5 or y < -1.5 or z < -1.5) then
					BringVehicleToHalt(vehicle, 1.0, 1)
					DoScreenFadeOut(800)
					while not IsScreenFadedOut() do
						Wait(0)
					end
					Citizen.Wait(500)
					
					DeleteVehicle(vehicle)
					TriggerServerEvent('esx_2KGarage:deleteVehicle', Garagem, vehicleProps)
					LeaveGarageFunction(true, vehicleProps)
				end
			end
		end
	end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
        if isInGarage then
            for i=0,63 do
                if i ~= GetPlayerServerId(PlayerId()) then
                    local otherPlayerPed = GetPlayerPed(GetPlayerFromServerId(i))
                    SetPlayerInvisibleLocally(GetPlayerFromServerId(i))
					SetEntityNoCollisionEntity(otherPlayerPed, playerPed, true)
                end
            end
			DisableControlAction(0, Keys['SPACE'], true)
			DisableControlAction(0, Keys['LEFTSHIFT'], true)
            DisablePlayerFiring(PlayerId(), true)
        end
    end
end)

function StartWorkaroundTask()
	if isRunningWorkaround then
		return
	end

	local timer = 0
	local playerPed = PlayerPedId()
	isRunningWorkaround = true

	while timer < 100 do
		Citizen.Wait(0)
		timer = timer + 1

		local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

		if DoesEntityExist(vehicle) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 4 then
				ClearPedTasks(playerPed)
			end
		end
	end

	isRunningWorkaround = false
end

function ToggleVehicleLock()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle

	Citizen.CreateThread(function()
		StartWorkaroundTask()
	end)

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords, 8.0, 0, 70)
	end

	if not DoesEntityExist(vehicle) then
		return
	end
	
	ESX.TriggerServerCallback('esx_2KGarage:requestPlayerCars', function(isOwnedVehicle, plate)

		if isOwnedVehicle then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 1 then
				SetVehicleDoorsLocked(vehicle, 2)
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
				Citizen.Wait(550)
					ESX.ShowNotification('~r~Veículo Travado:~y~\nModelo: ~w~'..GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)).. '\n~y~Placa: ~w~'..plate)
				Citizen.Wait(650)
				SetVehicleAlarm(vehicle, false)
			elseif lockStatus == 2 then
				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 1)
				ESX.ShowNotification('~g~Veículo Destravado:~y~\nModelo: ~w~'..GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)).. '\n~y~Placa: ~w~'..plate)
			end
		end
	end, GetVehicleNumberPlateText(vehicle))
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if Config.UseVehicleLockSystem then
			local dict = "anim@mp_player_intmenu@key_fob@"
		
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(0)
				end

			if IsControlJustReleased(0, Keys['M']) and IsInputDisabled(0) then
				if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click", 8.0, 8.0, -1, 48, 1, false, false, false)
					ToggleVehicleLock()
					Citizen.Wait(300)
				else 
					ToggleVehicleLock()
					Citizen.Wait(300)
				end
				
			elseif IsControlJustReleased(0, 173) and not IsInputDisabled(0) then
				ToggleVehicleLock()
				Citizen.Wait(300)
			end
		end
	end
end)

RegisterNetEvent('esx_2KGarage:reloadGarages')
AddEventHandler('esx_2KGarage:reloadGarages', function()
	ESX.TriggerServerCallback('esx_2KGarage:getOwnedProperties', function(properties)
		PropertyGarages = properties
     end)
end)

function has_value (tab, val)
	for index, value in ipairs(tab) do
			if value == val then
					return true
			end
	end

	return false
end

RegisterNUICallback('CloseNUI', function()
    SetNuiFocus(false, false)
    IsInGarageMenu = false
end)

RegisterNUICallback('SpawnVehicle', function(data, cb)
	SetNuiFocus(false, false)
    IsInGarageMenu = false
	SpawnVehicle(data.id.vehicle, data.id.plate, data.id.position, data.id.garage)
	cb('ok')
end)

RegisterNUICallback('StoreVehicle', function()
	SetNuiFocus(false, false)
    IsInGarageMenu = false
    local vehicles = ESX.Game.GetVehiclesInArea(Config.Garages[LastGarage].GarageArea, Config.Garages[LastGarage].Radius)
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
	local vehProps = ESX.Game.GetVehicleProperties(vehicle)
	local vehCoords = GetEntityCoords(vehicle)
	local vehHeading = GetEntityHeading(vehicle)
	local vehPos = {
		x = vehCoords.x,
		y = vehCoords.y,
		z = vehCoords.z,
		h = vehHeading
	}
	local vehModel = string.lower(GetDisplayNameFromVehicleModel(vehProps.model))
	local vehDisplayName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	if vehicles then
		if vehicle then
			for i = 1, #vehicles, 1 do
				if vehicles[i] == vehicle then
					ESX.TriggerServerCallback('esx_2KGarage:storeGarageVehicle', function(stored)
						if stored then
							DeleteVehicle(vehicle)
						end
					end, vehProps, LastGarage, vehPos, vehModel, vehDisplayName)
				end
			end
		end
	end
end)

RegisterNUICallback('SpawnVehicleSecurity', function(data, cb)
	SetNuiFocus(false, false)
    IsInGarageMenu = false
	RecoveryVehicle(data.id.vehicle, data.id.vehicle.plate)
	cb('ok')
end)