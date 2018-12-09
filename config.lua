--[[
	Author: FileEX
]]

--[[ Notka: Dlaczego przedzial czasowy? - Dla optymalizacji.
	Domyslnie skrypt sprawdza co [restartTime] (7200) czy jest godzina conajmniej 12 w nocy, lub pozniejsza (napozniej 5 rano)
	Dlaczego nie moze byc 12 w nocy i koniec? - Jesli skrypt zostanie uruchomiony np. o 23, a sprawdza co 2 godziny, to nigdy się to nie zdarzy. Zawsze będzie to 1 w nocy.
	Mozna ustawic czas sprawdzania np. na 30 minut, wtedy mozna utrafic w rowna godzine, to kwestia optymalnosci.

]]

cfg = {
	tunersList = 'tunerzy', -- komenda wyswietlajaca liste tunerow
	tunerOwner = 'wlascicieltune', -- komenda na ustawianie wlasciciela
	acceptAddCmd = 'montuj', -- komenda na zgode montazu
	acceptRemoveCmd = 'demontuj', -- komenda na zgode demontazu
	acceptTime = 15, -- czas w sekundach na zgode (de)montazu
	ownerSerial = 'F0E9838BBDA302D40C016AD967B1F6A1', -- serial uprawniajacy do komeny tunerOwner (wlascicieltune)
	manageColor = {237,255,50,150}, -- kolor markera zarzadzania
	upgradeColor = {213,75,197,150}, -- kolor markera (de)montazu
	vehicleColor = {178,31,255,150}, -- kolor markera dla pojazdu
	restartTime = 7200, -- czas odswiezania warsztatow w sekundach. (Co jaki czas ma byc sprawdzana godzina)
	hours = {minH = 0, maxH = 5}, -- Od ktorej godziny najpredzej, do ktorej najpozniej moga zostac odswiezone warsztaty (od polnocy, do 5 rana)
	havingItemColor = {255,0,0,255}, -- kolor itemka na liscie jesli pojazd posiada jakas czesc zamontowana
	havingOnePartColor = {255,255,0,255}, -- kolor jednego itemka ten ktory jest zamontowany
	notItemColor = {0,255,0,255}, -- kolor itemka na liscie jesli pojazd nie posiada go.
	removePercent = 70, -- procent ktory dostaje klient po demontazu
	addPercent = 30, -- procent ktory dostaje mechanik po montazu
};