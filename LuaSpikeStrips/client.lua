-- Made by 72006 D.Wheatley for EPRPC

RegisterNetEvent('c_setSpike')
AddEventHandler('c_setSpike', function()
  SetSpikesOnGround()
end)

RegisterNetEvent('c_deleteSpike')
AddEventHandler('c_deleteSpike', function()
  DeleteSpike()
end)

RegisterNetEvent('c_debugHeading')
AddEventHandler('c_debugHeading', function()
  debugHeading()
end)

function SetSpikesOnGround()
  if object ~= nil then
    DeleteObject(object)
  end
  
  x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
  local heading = GetEntityHeading(GetPlayerPed(-1))

  spike = GetHashKey("P_ld_stinger_s")

  RequestModel(spike)
  while not HasModelLoaded(spike) do
    Citizen.Wait(1)
  end
  
  object = CreateObject(spike, x, y, z-1, true, true, true)
	
  PlaceObjectOnGroundProperly(object)
  SetEntityHeading(object, heading)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped, false) then
      if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
        SetVehicleTyreBurst(veh, 0, true, 1000.0)
        SetVehicleTyreBurst(veh, 1, true, 1000.0)
        Citizen.Wait(200)
        SetVehicleTyreBurst(veh, 2, true, 1000.0)
        SetVehicleTyreBurst(veh, 3, true, 1000.0)
        Citizen.Wait(200)
        SetVehicleTyreBurst(veh, 4, true, 1000.0)
        SetVehicleTyreBurst(veh, 5, true, 1000.0)
        SetVehicleTyreBurst(veh, 6, true, 1000.0)
        SetVehicleTyreBurst(veh, 7, true, 1000.0)
        RemoveSpike()
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlPressed(0, 69) then -- Is 'E' pressed? 
	  if IsControlPressed(0,49) then -- Is '1' pressed?
	    if object == nil then
		  Notification("No stinger to delete")
		else
	      DeleteObject(object)
		end
	  elseif IsControlPressed(0, 50) then -- Is '2' pressed?
	    SetSpikesOnGround()
	  end
	end
  end
end)

function RemoveSpike()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  local vehCoord = GetEntityCoords(veh)
  if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
    spike = GetClosestObjectOfType(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
    SetEntityAsMissionEntity(spike, true, true)
    DeleteObject(spike)
	Notification("Stinger was effective")
  end
end

function DeleteSpike()
  local ped = GetPlayerPed(-1)
  local pedCoord = GetEntityCoords(ped)
  if DoesObjectOfTypeExistAtCoords(pedCoord["x"], pedCoord["y"], pedCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
    spike = GetClosestObjectOfType(pedCoord["x"], pedCoord["y"], pedCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
    SetEntityAsMissionEntity(spike, true, true)
    DeleteObject(spike)
	Notification("Stinger removed")
  else
    Notification("No stinger nearby")
  end
end

function Notification(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(0,1)
end

function debugHeading()
  local heading = GetEntityHeading(GetPlayerPed(-1))
  Notification(heading)
end