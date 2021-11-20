ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('HTOnTheFlux:blanchiment')
AddEventHandler('HTOnTheFlux:blanchiment', function(argent)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local taxe = 0    -- Le blanchisseur prend 35% (1-0.65 = 0.35)

	argent = ESX.Math.Round(tonumber(argent))
	pourcentage = argent * taxe
	Total = ESX.Math.Round(tonumber(pourcentage))

	if argent > 0 and xPlayer.getAccount('black_money').money >= argent then
		xPlayer.removeAccountMoney('black_money', argent)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiment', 'Attends ~r~10 minutes pour l\'opération', 'CHAR_MP_FM_CONTACT', 8)
		Citizen.Wait(600000)
		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiment', 'Tu as reçu : ' .. ESX.Math.GroupDigits(argent) .. ' ~g~$', 'CHAR_MP_FM_CONTACT', 8)
		xPlayer.addMoney(argent)
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiment', '~r~Montant invalide', 'CHAR_MP_FM_CONTACT', 8)
	end	
end)
