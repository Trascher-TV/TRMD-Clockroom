ESX = nil
local GUI, CurrentActionData = {}, {}
GUI.Time = 0
local LastZone, CurrentAction, CurrentActionMsg
local HasPayed, HasLoadCloth, HasAlreadyEnteredMarker = false, false, false

ESX = exports['es_extended']:getSharedObject()

function OpenShopMenu()
  local elements = {}


  ESX.UI.Menu.CloseAll()
	
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'supprime_cloth', {
			  css      = "skin",
              title    = _U('player_save'),
              align    = 'top-left',
              elements = {
				{label = _U('player_save'),             	value = 'clothessavea'}
			  }
			  
            }, function(data, menu)
			menu.close()
			if data.current.value == 'clothessavea' then
				exports['fivem-appearance']:openWardrobe()
			end

            end, function(data, menu)
              menu.close()
			  
			  CurrentAction     = 'shop_menu'
			  CurrentActionMsg  = _U('press_menu')
			  CurrentActionData = {}
    end, function(data, menu)

      menu.close()

      CurrentAction     = 'room_menu'
      CurrentActionMsg  = _U('press_menu')
      CurrentActionData = {}
    end)
end

AddEventHandler('GetCurrentResourceName:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {}
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil


		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('GetCurrentResourceName:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('GetCurrentResourceName:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  38) and (GetGameTimer() - GUI.Time) > 300 then

				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
	end
end)
