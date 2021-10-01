-----------------------------------------
------		Author: Lucas Dourado  ------
-----------------------------------------
------	 Discord: Nego2KBR#2482   -------
-----------------------------------------

-- Any questions call me on Discord

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_2KGarage:getOwnedProperties',function(source, cb)	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local property = 0

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier",{['@identifier'] = xPlayer.getIdentifier()}, function(data)
		for _,v in pairs(data) do
			local houses = json.decode(v.house)
			property = houses.houseId
		end
		cb(property)
	end)
end)

function PutVehicleInGarage(owner, garage, vehicleProps, vehCoords, vehModel, vehDisplayName)
    MySQL.Async.execute('INSERT INTO users_garages (identifier, plate, garage, vehicle, position, model, display) VALUES (@identifier, @plate, @garage, @vehicle, @position, @model, @display)',
		{
            ['@identifier'] = owner,
			['plate'] = vehicleProps.plate,
			['@garage']     = garage,
			['vehicle']     = json.encode(vehicleProps),
			['@position']     = json.encode(vehCoords),
			['@model']     = vehModel,
			['@display'] = vehDisplayName
		}, function(rowsChanged)
	end)

	MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate',
		{
            ['@vehicle'] = json.encode(vehicleProps),
			['@plate'] = vehicleProps.plate
		}, function(rowsChanged)
	end)
end

RegisterServerEvent('esx_2KGarage:deleteVehicle')
AddEventHandler('esx_2KGarage:deleteVehicle', function(garage, vehicleProps)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('DELETE FROM users_garages WHERE identifier = @identifier AND plate = @plate AND garage = @garage ',
	{
		['@identifier'] = xPlayer.identifier,
		['@plate']       = vehicleProps.plate,
		['@garage']     = garage
	}, function(rowsChanged)
	end)
end)

ESX.RegisterServerCallback('esx_2KGarage:storeGarageVehicle',function(source, cb, vehicleProps, garage, vehCoord, vehModel, vehDisplay)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = vehicleProps.plate
    }, function(result)
		if (result[1] ~= nil) then
			PutVehicleInGarage(xPlayer.identifier, garage, vehicleProps, vehCoord, vehModel, vehDisplay)
			xPlayer.triggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = "Veículo Guardado com sucesso!"})
			cb(true)
		else
			xPlayer.triggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "O ultimo veículo que você estava dirigindo não pertence a você!"})
			cb(false)
		end
    end)
end)

RegisterServerEvent('esx_N2KGarage:enteredGarage')
AddEventHandler('esx_N2KGarage:enteredGarage', function(currentGarage, position, vehicleProps)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    local garageInterior = Config.PropertyGarages[currentGarage].interior
    local maxSlots = Config.Interiors[garageInterior].maxSlots
		
    TriggerClientEvent('esx_2KGarage:insideGarage', _source, currentGarage)	
end)

ESX.RegisterServerCallback('esx_N2KGarage:enterGarage',function(source, cb, currentGarage, vehProps, vehModel, vehDisplay)
    local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    local garageInterior = Config.PropertyGarages[currentGarage].interior
    local maxSlots = Config.Interiors[garageInterior].maxSlots

    MySQL.Async.fetchScalar('SELECT COUNT(1) FROM users_garages WHERE identifier = @identifier AND garage = @garage',
		{
			['@identifier'] = xPlayer.identifier,
			['@garage']     = currentGarage
		}, function(result)
            local slot = (result + 1)
        if (result+1) > maxSlots then
		    cb(result+1, 0)
        else
			MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND owned_vehicles.plate NOT IN (SELECT plate from users_garages)', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = vehProps.plate
			}, function(result2)
				if (result2[1] ~= nil) then
					PutVehicleInGarage(xPlayer.identifier, currentGarage, vehProps, false, vehModel, vehDisplay)
					cb(result+1, 1)
				else
					xPlayer.triggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "O veículo que você está dirigindo não pertence a você!"})
					cb(result+1, 3)
				end
			end)
        end
	end)
end)

ESX.RegisterServerCallback('esx_N2KGarage:getVehiclesInGarage', function(source, cb, currentGarage)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM users_garages WHERE identifier = @identifier AND garage = @garage',
		{
			['@identifier'] = xPlayer.identifier,
			['@garage']     = currentGarage
		}, function(result)
			
			local vehicles = {}
			for i=1, #result, 1 do
				table.insert(vehicles, {
					slot = i,
					vehicle = json.decode(result[i].vehicle),
                    garage = currentGarage,
					position = json.decode(result[i].position),
					model = result[i].model,
					display = result[i].display
				})
			end
		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('esx_N2KGarage:getVehiclesInSecurity', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND owned_vehicles.plate NOT IN (SELECT plate from users_garages)',
		{
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local vehicles = {}
			for i=1, #result, 1 do
				table.insert(vehicles, {
					vehicle = json.decode(result[i].vehicle)
				})
			end
		cb(vehicles)
	end)
end)

RegisterNetEvent('esx_2KGarage:saveLastGarage')
AddEventHandler('esx_2KGarage:saveLastGarage', function(garage)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_garage = @last_garage WHERE identifier = @identifier', {
		['@last_garage'] = garage,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_2KGarage:deleteLastGarage')
AddEventHandler('esx_2KGarage:deleteLastGarage', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_garage = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('esx_2KGarage:requestPlayerCars', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil, plate)
	end)
end)

ESX.RegisterServerCallback('esx_2KGarage:getLastGarage', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_garage FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_garage)
	end)
end)

ESX.RegisterCommand('reloadgarages', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_2KGarage:reloadGarages')
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
