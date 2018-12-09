--[[
	Author: FileEX
]]

local screenX,screenY = guiGetScreenSize();
local zoom = (1440 / screenX);

local tune = {};
setmetatable(tune, {__call = function(obj, ...) return obj:constructor(...) end, __index = tune});

addEvent('ui:event',true);
addEventHandler('ui:event',localPlayer, function(uiname,rd,w)
	local classTune = tune();
	classTune:toggleUI(uiname,rd,w);
end);

local function partIsCompatible(id,veh)
	for _,i in ipairs(veh.compatibleUpgrades) do
		if id == i then
			return true;
		end
	end
	if parts[id].type ~= 'part' and (parts[id].compatibles[veh.model] or parts[id].compatibles[1] == 'all') then
		return true;
	end
	return false;
end

local function vehicleHavePart(id,veh,onlyID)
	if parts[id].type == 'part' then
		for _,i in ipairs(veh.upgrades) do
			if not onlyID then
				if (id == i or veh:getUpgradeOnSlot(parts[id].slot) ~= 0) then
					return true;
				end
			else
				return id == i;
			end
		end
	end

	if parts[id].type ~= 'part' then
		if parts[id].type == 'engineData' then
			return veh:getData(parts[id].data) == parts[id].valueM;
		elseif parts[id].type == 'handling' then
			return veh.handling['ABS'];
		end
	end

	return false;
end

function tune:constructor()
	self.__init = function()
		self.actualUI = 0;
		self.dataInfo = {};
	end

	self.drawUI = function() if self.actualUI ~= 0 then return self.renderUI(self); end end;
	self.clickUI = function(btn,state) return self:clickedUI(btn,state,self); end;

	self.toggleUI = function(_,ui,rd,w)
		if ui == 'manageUI' then
			self.dataInfo = rd;
			self.dataInfo[1].wlasciciel = w;
			self.actualUI = 1;
		elseif ui == 'upgradeUI' then
			self.actualUI = 2;
			self.vehicleElement = rd;
			self:createCGUIElements(true);
		elseif ui == 'buyUI' then
			self.dataInfo = rd;
			self.actualUI = 3;
		else
			self.actualUI = 0;
			removeEventHandler('onClientRender',root,self.drawUI);
			removeEventHandler('onClientClick',root,self.clickUI);
			self:createCGUIElements();
			showCursor(false);
			_G['self'] = nil;
			collectgarbage('collect');
		end
		if self.actualUI ~= 0 then
			addEventHandler('onClientRender',root,self.drawUI);
			addEventHandler('onClientClick',root,self.clickUI);
			showCursor(true);
		end
	end

	self.__init();
	return self;
end

function tune:renderUI()
	if self.actualUI == 1 then
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 350 / zoom, screenY / 2 - 242 / zoom, 619 / zoom, 460 / zoom, tocolor(1, 0, 0, 230), false)
        dxDrawLinedRectangle(screenX / 2 - 350 / zoom, screenY / 2 - 242 / zoom, 619 / zoom, 460 / zoom,tocolor(29, 188, 254, 254), 1, false);
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 338 / zoom, screenY / 2 - 151 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false)
        dxDrawLinedRectangle(screenX / 2 - 338 / zoom, screenY / 2 - 151 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
        dxDrawText("Oplac", screenX / 2 - 356 / zoom, screenY / 2 - 163 / zoom, 552 / zoom, 366 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Wlasciciel\n"..self.dataInfo[1].wlasciciel, screenX / 2 - 775 / zoom, screenY / 2 - 286 / zoom, 1722 / zoom, 440 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Warsztat opłacony do \n"..get_date_from_unix(self.dataInfo[1].waznosc)..' '..string.format('%02d:%02d',math.ceil(self.dataInfo[1].waznosc / 3600 % 24), math.floor(self.dataInfo[1].waznosc / 60 % 60)), screenX / 2 - 775 / zoom, screenY / 2 - 156 / zoom, 1722 / zoom, 479 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Cena wynajmu na dobę\n"..self.dataInfo[1].cena, screenX / 2 - 775 / zoom, screenY - 26 / zoom, 1722 / zoom, 100 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 338 / zoom, screenY / 2 - 51 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false)
        dxDrawLinedRectangle(screenX / 2 - 338 / zoom, screenY / 2 - 51 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
        dxDrawText("Zwolnij", screenX / 2 - 356 / zoom, screenY / 2 - 63 / zoom, 552 / zoom, 466 / zoom, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 338 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false)
        dxDrawLinedRectangle(screenX / 2 - 338 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
        dxDrawText("Zamknij", screenX / 2 - 356 / zoom, screenY / 2 + 161 / zoom, 552 / zoom, 640 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
	elseif self.actualUI == 2 then
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 350 / zoom, screenY / 2 - 242 / zoom, 619 / zoom, 460 / zoom, tocolor(1, 0, 0, 230), false)
       	dxDrawLinedRectangle(screenX / 2 - 350 / zoom, screenY / 2 - 242 / zoom, 619 / zoom, 460 / zoom,tocolor(29, 188, 254, 254), 1, false);
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 338 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false)
        dxDrawLinedRectangle(screenX / 2 - 338 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
        dxDrawText("Montuj", screenX / 2 - 356 / zoom, screenY / 2 + 161 / zoom, 552 / zoom, 640 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 138 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false)
        dxDrawLinedRectangle(screenX / 2 - 138 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
        exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 + 62 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false)
        dxDrawLinedRectangle(screenX / 2 + 62 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
        dxDrawText("Zamknij", screenX / 2 + 35 / zoom, screenY / 2 + 161 / zoom, 552 / zoom, 640 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Demontuj", screenX / 2 + 455 / zoom, screenY / 2 + 161 / zoom, 552 / zoom, 640 / zoom, tocolor(255, 255, 255, 255), 1.00 / zoom, "default", "center", "center", false, false, false, false, false)
	elseif self.actualUI == 3 then
		exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 290 / zoom, screenY / 2 - 242 / zoom, 610 / zoom, 380 / zoom, tocolor(1, 0, 0, 230), false);
		dxDrawLinedRectangle(screenX / 2 - 290 / zoom, screenY / 2 - 242 / zoom, 610 / zoom, 380 / zoom, tocolor(29, 188, 254, 254), 1, false);
		exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 - 270 / zoom, screenY / 2 + 65 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false);
		dxDrawLinedRectangle(screenX / 2 - 270 / zoom, screenY / 2 + 65 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
		dxDrawText('Wynajmij', screenX / 2 - 220 / zoom, screenY / 2 + 65 / zoom, 552 / zoom, 565 / zoom, 0xFFFFFFFF, 1.00 / zoom, 'default', 'center', 'center', false, false, false);
		exports["nm-blur"]:dxDrawBluredRectangle(screenX / 2 + 140 / zoom, screenY / 2 + 65 / zoom, 161 / zoom, 49 / zoom, tocolor(0, 1, 1, 230), false);
		dxDrawLinedRectangle(screenX / 2 + 140 / zoom, screenY / 2 + 65 / zoom, 161 / zoom, 49 / zoom, tocolor(29, 188, 254, 254), 1, false);
		dxDrawText('Zamknij', screenX / 2 + 620 / zoom, screenY / 2 + 65 / zoom, 552 / zoom, 565 / zoom, 0xFFFFFFFF, 1.00 / zoom, 'default', 'center', 'center', false,false,false);
		dxDrawText('Nazwa\n'..self.dataInfo[2], screenX / 2 + 580 / zoom, screenY / 2 + 50 / zoom, 150 / zoom, 150 / zoom, 0xFFFFFFFF, 1.00 / zoom, 'default', 'center', 'center', false,false,false);
		dxDrawText('Cena za dobę\n'..self.dataInfo[1]..' $', screenX / 2 + 580 / zoom, screenY / 2 + 250 / zoom, 150 / zoom, 150 / zoom, 0xFFFFFFFF, 1.00 / zoom, 'default', 'center', 'center', false,false,false);
	end
end

function tune:clickedUI(btn,state)
	if btn == 'left' and state == 'down' then
		if self.actualUI == 1 then
			if isMouseInPosition(screenX / 2 - 338 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom) then
				self:toggleUI('');
			elseif isMouseInPosition(screenX / 2 - 338 / zoom, screenY / 2 - 51 / zoom, 161 / zoom, 49 / zoom) then
				triggerServerEvent('setStateToFree',localPlayer,self.dataInfo[1].id);
				self:toggleUI('');
			elseif isMouseInPosition(screenX / 2 - 338 / zoom, screenY / 2 - 151 / zoom, 161 / zoom, 49 / zoom) then
				triggerServerEvent('payForGarage',localPlayer,self.dataInfo[1].id);
			end
		elseif self.actualUI == 2 then
			if isMouseInPosition(screenX / 2 - 138 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom) then
				self:toggleUI('');
			elseif isMouseInPosition(screenX / 2 - 338 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom) then
				if not localPlayer:getData('operationInPrg') then
					local part = guiGridListGetSelectedItem(partsList);
					if part ~= -1 then
						local data = guiGridListGetItemData(partsList, part, 1);

						if not vehicleHavePart(data[4], self.vehicleElement,true) then
							triggerServerEvent('addPartProcess',localPlayer,data,self.vehicleElement);
						else
							outputChatBox('Ten pojazd ma już tą część.',255,255,255);
						end
					else
						outputChatBox('Wybierz część.',255,255,255);
					end
				else
					outputChatBox('Oczekuj na odpowiedź.',255,255,255);
				end
			elseif isMouseInPosition(screenX / 2 + 62 / zoom, screenY / 2 + 151 / zoom, 161 / zoom, 49 / zoom) then
				if not localPlayer:getData('operationInPrg') then
					local part = guiGridListGetSelectedItem(partsList);
					if part ~= -1 then
						local data = guiGridListGetItemData(partsList, part,1);

						if vehicleHavePart(data[4], self.vehicleElement,true) then
							triggerServerEvent('removePartProcess',localPlayer, data,self.vehicleElement);
							outputChatBox('Oczekiwanie na zgodę kierowcy...',255,255,255);
							localPlayer:setData('operationInPrg',true,false);
						else
							outputChatBox('Ten pojazd nie posiada tej części.',255,255,255);
						end
					else
						outputChatBox('Wybierz część.',255,255,255);
					end
				else
					outputChatBox('Oczekuj na odpowiedź.',255,255,255);
				end
			end
		elseif self.actualUI == 3 then
			if isMouseInPosition(screenX / 2 + 140 / zoom, screenY / 2 + 65 / zoom, 161 / zoom, 49 / zoom) then
				self:toggleUI('');
			elseif isMouseInPosition(screenX / 2 - 270 / zoom, screenY / 2 + 65 / zoom, 161 / zoom, 49 / zoom) then
				triggerServerEvent('buyProcess',localPlayer,self.dataInfo[1],self.dataInfo[3]);
				self:toggleUI('');
			end
		end
	end
end

function tune:createCGUIElements(b)
	if b then
		partsList = GuiGridList(screenX / 2 - 330 / zoom,screenY / 2 - 220 / zoom,570 / zoom, 350 / zoom,false);
		partsList:addColumn('Nazwa', 0.50);
		partsList:addColumn('Cena', 0.35);

		for k,v in pairs(parts) do
			row = partsList:addRow();

			if partIsCompatible(k,self.vehicleElement) then
				guiGridListSetItemText(partsList, row, 1, v.name, false, false);
				guiGridListSetItemText(partsList, row, 2, v.price..' $', false, false);
				guiGridListSetItemData(partsList, row, 1, {v.type, (v.data or nil), (v.value or nil), k});
				
				if vehicleHavePart(k,self.vehicleElement) then
					for i = 1,2 do
						guiGridListSetItemColor(partsList, row, i, unpack(cfg.havingItemColor));
					end
				else
					for i = 1,2 do
						guiGridListSetItemColor(partsList, row, i, unpack(cfg.notItemColor));
					end
				end

				if vehicleHavePart(k,self.vehicleElement,true) then
					for i = 1,2 do
						guiGridListSetItemColor(partsList, row, i, unpack(cfg.havingOnePartColor));
					end
				end
			end
		end
	else
		if isElement(partsList) then
			partsList:destroy();
		end
	end
end

addEvent('refreshClientData',true);
addEventHandler('refreshClientData',localPlayer,function(t)
	local self = tune;
	self.dataInfo[1].waznosc = t;
end);

addEvent('refreshPartsList',true);
addEventHandler('refreshPartsList',localPlayer,function()
	local self = tune;
	if isElement(partsList) then
		guiGridListClear(partsList);

		for k,v in pairs(parts) do
			row = partsList:addRow();

			if partIsCompatible(k,self.vehicleElement) then
				guiGridListSetItemText(partsList, row, 1, v.name, false, false);
				guiGridListSetItemText(partsList, row, 2, v.price..' $', false, false);
				guiGridListSetItemData(partsList, row, 1, {v.type, (v.data or nil), (v.value or nil), k});
				
				if vehicleHavePart(k,self.vehicleElement) then
					for i = 1,2 do
						guiGridListSetItemColor(partsList, row, i, unpack(cfg.havingItemColor));
					end
				else
					for i = 1,2 do
						guiGridListSetItemColor(partsList, row, i, unpack(cfg.notItemColor));
					end
				end

				if vehicleHavePart(k,self.vehicleElement,true) then
					for i = 1,2 do
						guiGridListSetItemColor(partsList, row, i, unpack(cfg.havingOnePartColor));
					end
				end
			end
		end
	end

	localPlayer:setData('operationInPrg',false,false);
end);

addEvent('answerTimeUp',true);
addEventHandler('answerTimeUp',localPlayer,function(a)
	localPlayer:setData('operationInPrg',false,false);
	outputChatBox((a == 'removePart' and 'Demontaż' or (a == 'addPart' and 'Montaż'))..' części nie powiódł się.',255,255,255);
	outputChatBox('Kierowca nie odpowiada, zgłoś do administracji, że blokuje stanowisko.',255,255,255);
end);

addEvent('continueAction',true);
addEventHandler('continueAction',localPlayer,function()
	outputChatBox('Oczekiwanie na zgodę kierowcy...',255,255,255);
	localPlayer:setData('operationInPrg',true,false);
end);