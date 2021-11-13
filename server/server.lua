ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'blanchi', 'alerte blanchi', true, true)

TriggerEvent('esx_society:registerSociety', 'blanchi', 'blanchi', 'society_blanchi', 'society_blanchi', 'society_blanchi', {type = 'public'})

-------------- INTERACTION ------------

RegisterServerEvent('e_bcso:requestarrest')
AddEventHandler('e_bcso:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	TriggerClientEvent('e_bcso:getarrested', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('e_bcso:doarrested', _source)
end)

RegisterServerEvent('e_bcso:requestrelease')
AddEventHandler('e_bcso:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	TriggerClientEvent('e_bcso:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('e_bcso:douncuffing', _source)
end)

RegisterServerEvent('e_bcso:handcuff')
AddEventHandler('e_bcso:handcuff', function(target)
  TriggerClientEvent('e_bcso:handcuff', target)
end)

RegisterServerEvent('e_bcso:drag')
AddEventHandler('e_bcso:drag', function(target)
  local _source = source
  TriggerClientEvent('e_bcso:drag', target, _source)
end)

RegisterServerEvent('e_bcso:putInVehicle')
AddEventHandler('e_bcso:putInVehicle', function(target)
  TriggerClientEvent('e_bcso:putInVehicle', target)
end)

RegisterServerEvent('e_bcso:OutVehicle')
AddEventHandler('e_bcso:OutVehicle', function(target)
    TriggerClientEvent('e_bcso:OutVehicle', target)
end)

ESX.RegisterServerCallback('e_bcso:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~Quelqu'un vous fouille ...")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)

RegisterNetEvent('jejey:confiscatePlayerItem')
AddEventHandler('jejey:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
        else
			TriggerClientEvent("esx:showNotification", source, "~r~Quantité invalide")
		end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount.." d' "..itemName.."~s~.")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous aconfisqué ~b~"..amount.." d' "..itemName.."~s~.")
        
    elseif itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)
