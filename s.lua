--[[
	Author: FileEX
]]

local function getUserFromUID(i)
	if i and tonumber(i) then
		local q = exports['rpg_mysql']:mysql_query('SELECT username FROM rpg_accounts WHERE uid=? LIMIT 1;',i);
		if q then
			return q[1].username;
		end
	end
end

local function getVehicleFromData(data,player)
	if data then
		for _,v in ipairs(Element.getAllByType('marker',resourceRoot)) do
			local c = v:getData('m:data');
			if c then
				if c[1] == 'vehicle' and c[2] == data[2] then
					local mshp = v.colShape;
					local elements = mshp:getElementsWithin('vehicle');
					if #elements > 0 then
						if #elements == 1 then
							return elements[1];
						else
							player:outputChat('Na stanowisku jest za dużo pojazdów.',255,255,255);
							return false;
						end
					else
						player:outputChat('Na stanowisku nie ma żadnego pojazdu.',255,255,255);
						return false;
					end
					break;
				end
			end
		end
	end
	return false;
end

local function refreshTuners()
	local q = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty');
	
	if q and #q > 0 then

		for _,v in pairs(q) do
			local pm,up,pv = split(v.managePos,','), split(v.upgradePos,','), split(v.vehiclePos,',');
			local manageM = Marker(pm[1],pm[2],pm[3],'cylinder',2.3,unpack(cfg.manageColor));
			local upgradeM = Marker(up[1],up[2],up[3],'cylinder',2.3,unpack(cfg.upgradeColor));
			local vehicleM = Marker(pv[1],pv[2],pv[3],'cylinder',3.5,unpack(cfg.vehicleColor));
			manageM:setData('m:data',{'management',v.id},false);
			upgradeM:setData('m:data',{'upgrade',v.id},false);
			vehicleM:setData('m:data',{'vehicle',v.id},false);


			if not v.wlasciciel or v.wlasciciel == 0 then
				local pp = split(v.pickPos,',');
				local p = Pickup(pp[1],pp[2],pp[3], 3, 1274,1000);
				p:setData('p:identify',v.id,false);
			end

			if v.wlasciciel and v.wlasciciel ~= 0 and (v.waznosc <= getRealTime().timestamp) then
				exports['rpg_mysql']:mysql_query('UPDATE frpg_warsztaty SET wlasciciel=?, waznosc=? WHERE id=?',0,0,v.id);
				local pp = split(v.pickPos,',');
				local p = Pickup(pp[1],pp[2],pp[3], 3, 1274,1000);
				p:setData('p:identify',v.id,false);
			end
		end
	end
end

addCommandHandler(cfg.tunersList, function(plr, cmd)
	local q = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty');
	
	plr:outputChat('Nazwa | Wlasciciel | Online',255,255,255);
	for _,v in pairs(q) do
		local us = getPlayerFromName(getUserFromUID(q[1].wlasciciel));
		local online = us and 'Tak' or 'Nie';
		plr:outputChat(q[1].nazwa..' '..(us or 'Brak')..' '..online, 255,255,255);
	end
end);

addCommandHandler(cfg.tunerOwner, function(plr, cmd, id, uid)
	if plr.serial == cfg.ownerSerial then
		if tonumber(id) and tonumber(uid) then
			local q = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty WHERE id=? LIMIT 1;', id);
			
			if q and #q > 0 then
				for _,v in ipairs(Element.getAllByType('pickup')) do
					if v:getData('p:identify') and v:getData('p:identify') == q[1].id then
						v:removeData('p:identify');
						v:destroy();
						break;
					end
				end
				exports['rpg_mysql']:mysql_query('UPDATE frpg_warsztaty SET wlasciciel=?,waznosc=? WHERE id=?', uid, (getRealTime().timestamp + 3600) + 86400, id);
				plr:outputChat('Zmieniono wlasciciela warsztatu o id '..id..'.',255,255,255);
			else
				plr:outputChat('Warsztat o takim id ('..id..') nie istnieje.',255,255,255);
			end	
		else
			plr:outputChat('Użyj /'..cfg.tunerOwner..' <id tunera> <dbid>',255,255,255);	
		end
	end
end);

addEventHandler('onMarkerHit',resourceRoot,function(he,md)
	if he.type == 'player' and md then
		local data = source:getData('m:data');
		local q = exports['rpg_mysql']:mysql_query('SELECT wlasciciel FROM frpg_warsztaty WHERE id=? LIMIT 1;',data[2]);
		
		if q and #q > 0 then
			if data and (he:getData('user:uid') == tonumber(q[1].wlasciciel)) then
				if data[1] == 'management' then
					local q2 = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty WHERE id=?',data[2]);
					
					if q2 and #q2 > 0 then
						triggerClientEvent(he, 'ui:event',he, 'manageUI',q2,getUserFromUID(q2[1].wlasciciel));
					end
				elseif data[1] == 'upgrade' then
					local vh = getVehicleFromData(data,he);
					if vh then
						triggerClientEvent(he, 'ui:event',he, 'upgradeUI',vh);
					end
				end
			end
		end
	end
end);

addEventHandler('onPickupHit',resourceRoot,function(player)
	local idt = source:getData('p:identify');
	if idt then
		local q = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty WHERE id=? LIMI 1;',idt);
	
		if q and #q > 0 then
			triggerClientEvent(player, 'ui:event',player, 'buyUI',{q[1].cena,q[1].nazwa,q[1].id});
		end
	end
end);

addEvent('setStateToFree',true);
addEventHandler('setStateToFree',root,function(id)
	local q = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty WHERE id=?',id);

	if q and #q > 0 then
		exports['rpg_mysql']:mysql_query('UPDATE frpg_warsztaty SET wlasciciel=?, waznosc=? WHERE id=?',0,0,id);
		client:outputChat('Zwolniles/as warsztat.',255,255,255);
		local pp = split(q[1].pickPos,',');
		local p = Pickup(pp[1],pp[2],pp[3], 3, 1274,1000);
		p:setData('p:identify',q[1].id,false);
	end
end);

addEvent('payForGarage',true);
addEventHandler('payForGarage',root,function(id)
	local q = exports['rpg_mysql']:mysql_query('SELECT * FROM frpg_warsztaty WHERE id=?',id);

	if q and #q > 0 then
		if client.money >= q[1].cena then
			exports['rpg_mysql']:mysql_query('UPDATE frpg_warsztaty SET waznosc=? WHERE id=?', q[1].waznosc + 86400, id);
			client:outputChat('Przedłużono ważność o 1 dzień.',255,255,255);
			triggerClientEvent(client, 'refreshClientData',client, q[1].waznosc + 86400);
			client.money = client.money - q[1].cena;
		else
			client:outputChat('Nie masz wystarczająco pieniędzy, brakuje Ci '..q[1].cena - client.money..' $',255,255,255);
		end
	end
end);

addEvent('removePartProcess',true);
addEventHandler('removePartProcess',root,function(dt,veh)
	local cntr = veh.controller;
	local client = client;
	local actm;
	if cntr then
		cntr:outputChat('Wpisz /'..cfg.acceptRemoveCmd..' '..dt[4]..', jeśli wyrażasz zgode na (de)montaż.',255,255,255);
		
		local accept = function(plr,cmd,id)
			if id and tonumber(id) then
				if tonumber(id) == dt[4] then
					if dt[1] == 'part' then
						removeVehicleUpgrade(veh, id);
					elseif dt[1] == 'engineData' then
						veh:setData(parts[dt[4]].data, parts[dt[4]].valueD);
					elseif dt[1] == 'handling' then
						setVehicleHandling(veh, parts[dt[4]].originalName, parts[dt[4]].valueD);
					end

					cntr:outputChat('Część '..parts[dt[4]].name..' została zdemontowana.');
					client:outputChat('Część '..parts[dt[4]].name..' została zdemontowana.');

					local x = cfg.removePercent / 100;
					local p = x * parts[dt[4]].price;
					cntr.money = cntr.money + p;
					triggerClientEvent(client, 'refreshPartsList',client);
					removeCommandHandler(cfg.acceptRemoveCmd, accept);
					accept = nil;
					if actm.valid then
						actm:destroy();
					end
				else
					cntr:outputChat('Błędne ID.',255,255,255);
				end
			else
				cntr:outputChat('Nie podano ID.',255,255,255);
			end
		end
		addCommandHandler(cfg.acceptRemoveCmd, accept);

		actm = Timer(function(client)
			removeCommandHandler(cfg.acceptRemoveCmd, accept);
			accept = nil;
			cntr:outputChat('Operacja została anulowana. Nie blokuj stanowiska.',255,255,255);
			triggerClientEvent(client,'answerTimeUp',client, 'removePart');
		end,cfg.acceptTime * 1000,1,client);
	else
		client:outputChat('W pojeździe nie ma kierowcy.',255,255,255);
	end
end);

addEvent('addPartProcess',true);
addEventHandler('addPartProcess',root,function(dt,veh)
	local cntr = veh.controller;
	local client = client;
	if cntr then
		if cntr.money >= parts[dt[4]].price then
			triggerClientEvent(client, 'continueAction',client);
			cntr:outputChat('Wpisz /'..cfg.acceptAddCmd..' '..dt[4]..', jeśli wyrażasz zgodę na montaż.',255,255,255);

			local accept = function(plr,cmd,id)
				if id and tonumber(id) then
					if tonumber(id) == dt[4] then
						if dt[1] == 'part' then
							veh:addUpgrade(dt[4]);
						elseif dt[1] == 'engineData' then
							veh:setData(parts[dt[4]].data, parts[dt[4]].valueM);
						elseif dt[1] == 'handling' then
							setVehicleHandling(veh, parts[dt[4]].originalName, parts[dt[4]].valueM);
						end

						cntr:outputChat('Część '..parts[dt[4]].name..' została zamontowana.',255,255,255);
						client:outputChat('Część '..parts[dt[4]].name..' została zamontowana.',255,255,255);

						local x = cfg.addPercent / 100;
						local p = x * parts[dt[4]].price;
						client.money = client.money + p;
						cntr.money = cntr.money - parts[dt[4]].price;
						triggerClientEvent(client, 'refreshPartsList',client);
						removeCommandHandler(cfg.acceptAddCmd, accept);
						accept = nil;
						if actm.valid then
							actm:destroy();
						end
					else
						cntr:outputChat('Błędne ID.',255,255,255);
					end
				else
					cntr:outputChat('Nie podano ID.',255,255,255);
				end
			end
			addCommandHandler(cfg.acceptAddCmd, accept);

			actm = Timer(function(client)
				removeCommandHandler(cfg.acceptAddCmd, accept);
				accept = nil;
				cntr:outputChat('Operacja została anulowana. Nie blokuj stanowiska.',255,255,255);
				triggerClientEvent(client,'answerTimeUp',client, 'addPart');
			end,cfg.acceptTime * 1000,1,client);
		else
			client:outputChat('Klient nie ma tyle pieniędzy.',255,255,255);
		end
	else
		client:outputChat('W pojeździe nie ma kierowcy.',255,255,255);
	end
end);

addEvent('buyProcess',true);
addEventHandler('buyProcess',root,function(p,i)
	if client.money >= p then
		exports['rpg_mysql']:mysql_query('UPDATE frpg_warsztaty SET wlasciciel=?, waznosc=? WHERE id=?', client:getData('user:uid'), (getRealTime().timestamp + 3600) + 86400, i);
		client:outputChat('Pomyślnie zakupiono warsztat.',255,255,255);
		client.money = client.money - p;
		for _,v in ipairs(Element.getAllByType('pickup')) do
			if v:getData('p:identify') and v:getData('p:identify') == i then
				v:removeData('p:identify');
				v:destroy();
				break;
			end
		end
	else
		client:outputChat('Niestety nie masz tyle pieniędzy, brakuje Ci '..(p - client.money)..' $',255,255,255);
	end
end);

addEventHandler('onResourceStart',resourceRoot,function()
	refreshTuners();
	print('Warsztaty zostały załadowane.');

	Timer(function()
		local t = getRealTime();
		if (t.hour >= cfg.hours.minH and t.hour <= cfg.hours.maxH) and t.minute >= 0 then
			refreshTuners();
			print('Warsztaty zostały zaktualizowane.');
		end
	end, cfg.restartTime, 0);
end);
