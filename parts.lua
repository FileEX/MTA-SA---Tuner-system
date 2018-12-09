--[[
	Author: FileEX
]]

--[[	Typy:	
	1: engineData - typ na potrzeby mk, ustawia poszczegolne elementdaty na pojazd, moznaa dodac atrybut value
	2: handling - typ okreslajacy montaz handlingow, atrybut value okresla wartosc handlingu
	3: part - typ dla 'upgrades', okresla czesci, atrybuty data i value nie maja zastosowania

	Parametr compatibles okresla czy dana czesc moze zostac zamontowana w danym pojezdzie, umieszcza sie tam id pojazdow do ktorych mozna zamontowac czesc, lub 'all' jesli do wszystkich aut. Nie dotyczy typu part.
--]]

parts = { -- [nr] = {name = 'nazwa wyswietlana', price = cena, type = typ} [ data = elementdata, valueD = wartosc eldaty gdy czesc jest demontowana, valueM = wartosc eldaty gdy czesc jest montowana, compatibles = {id pojazdow}, originalName = oryginalna nazwa handlingu (nie wyswietlana)]
	[1] = {name = 'MK 1', price = 2000, type = 'engineData', data = 'veh:mk1', valueD = 0, valueM = 1, compatibles = {'all'}},
	[2] = {name = "MK 2", price = 4000, type = 'engineData', data = 'veh:mk2', valueD = 0, valueM = 1, compatibles = {'all'}},
	[3] = {name = 'MK 3', price = 6000, type = 'engineData', data = 'veh:mk3', valueD = 0, valueM = 1, compatibles = {'all'}},

	[4] = {name = 'ABS', price = 50, type = 'handling', valueM = true, valueD = false, compatibles = {[541] = true}, originalName = 'ABS'},

	[1000] = {name = 'Spoiler Pro', price = 1500, type = 'part',slot = 2},
	[1001] = {name = 'Spoiler Win', price = 1500, type = 'part', slot = 2},
	[1002] = {name = 'Spoiler Drag', price = 1500, type = 'part', slot = 2},
	[1003] = {name = 'Spoiler Alpha', price = 1500, type = 'part', slot = 2},
	[1004] = {name = 'Maska Champ Scoop', price = 1500, type = 'part', slot = 0},
	[1005] = {name = 'Maska Fury Scoop', price = 1500, type = 'part', slot = 0},
	[1006] = {name = 'Dach Scoop', price = 1500, type = 'part', slot = 7},
	[1007] = {name = 'Prawy próg', price = 1500, type = 'part', slot = 3},
	[1008] = {name = 'Nitro x5', price = 1500, type = 'part', slot = 8},
	[1009] = {name = 'Nitro x2', price = 1500, type = 'part', slot = 8},
	[1010] = {name = 'Nitro x10', price = 1500, type = 'part', slot = 8},
	[1011] = {name = 'Maska Race Scoop', price = 1500, type = 'part', slot = 0},
	[1012] = {name = 'Maska Worx Scoop', price = 1500, type = 'part', slot = 0},
	[1013] = {name = 'Lampy okrągłe Fog', price = 1500, type = 'part', slot = 6},
	[1014] = {name = 'Spoiler Champ', price = 1500, type = 'part', slot = 2},
	[1015] = {name = 'Spoiler Race', price = 1500, type = 'part', slot = 2},
	[1016] = {name = 'Spoiler Worx', price = 1500, type = 'part', slot = 2},
	[1017] = {name = 'Lewy próg', price = 1500, type = 'part', slot = 3},
	[1018] = {name = 'Wydech Upswept', price = 1500, type = 'part', slot = 13},
	[1019] = {name = 'Wydech Twin', price = 1500, type = 'part', slot = 13},
	[1020] = {name = 'Wydech duży', price = 1500, type = 'part', slot = 13},
	[1021] = {name = 'Wydech średni', price = 1500, type = 'part', slot = 13},
	[1022] = {name = 'Wydech mały', price = 1500, type = 'part', slot = 13},
	[1023] = {name = 'Spoiler Fury', price = 1500, type = 'part', slot = 2},
	[1024] = {name = 'Lampy kwadratowe Fog', price = 1500, type = 'part', slot = 6},
	[1025] = {name = 'Felgi Offroad', price = 1500, type = 'part', slot = 12},
	[1026] = {name = 'Prawy próg Alien', price = 1500, type = 'part', slot = 3}, -- Sultan
	[1027] = {name = 'Lewy próg Alien', price = 1500, type = 'part', slot = 3}, -- Sultan
	[1028] = {name = 'Wydech Alien', price = 1500, type = 'part', slot = 13}, -- Sultan
	[1029] = {name = 'Wydech X-Flow', price = 1500, type = 'part', slot = 13}, -- Sultan
	[1030] = {name = 'Lewy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Sultan
	[1031] = {name = 'Prawy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Sultan
	[1032] = {name = 'Dach Alien Vent', price = 1500, type = 'part', slot = 7}, -- Sultan
	[1033] = {name = 'Dach X-Flow Vent', price = 1500, type = 'part', slot = 7}, -- sultan
	[1034] = {name = 'Wydech Alien', price = 1500, type = 'part', slot = 13}, -- Elegy
	[1035] = {name = 'Dach X-Flow Vent', price = 1500, type = 'part', slot = 7}, -- elegy
	[1036] = {name = 'Prawy próg Alien', price = 1500, type = 'part', slot = 3}, -- elegy
	[1037] = {name = 'Wydech X-Flow', price = 1500, type = 'part', slot = 13}, -- elegy
	[1038] = {name = 'Dach Alien Vent', price = 1500, type = 'part', slot = 7}, -- Elegy
	[1039] = {name = 'Lewy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Elegy
	[1040] = {name = 'Lewy próg Alien', price = 1500, type = 'part', slot = 3}, -- Elegy
	[1041] = {name = 'Prawy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Elegy
	[1042] = {name = 'Prawy próg Alien', price = 1500, type = 'part', slot = 3}, -- Brodway
	[1043] = {name = 'Wydech Slamin', price = 1500, type = 'part', slot = 13}, -- Brodway
	[1044] = {name = 'Wydech Chrome', price = 1500, type = 'part', slot = 13}, -- Brodway
	[1045] = {name = 'Wydech X-Flow', price = 1500, type = 'part', slot = 13}, -- Flash
	[1046] = {name = 'Wydech Alien', price = 1500, type = 'part', slot = 13}, -- Flash
	[1047] = {name = 'Prawy próg Alien', price = 1500, type = 'part', slot = 3}, -- Flash
	[1048] = {name = 'Prawy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Flash
	[1049] = {name = 'Spoiler Alien', price = 1500, type = 'part', slot = 2}, -- Flash
	[1050] = {name = 'Spoiler X-Flow', price = 1500, type = 'part', slot = 2}, -- Flash
	[1051] = {name = 'Lewy próg Alien', price = 1500, type = 'part', slot = 3}, -- Flash
	[1052] = {name = 'Lewy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Flash
	[1053] = {name = 'Dach X-Flow', price = 2500, type = 'part', slot = 7}, -- Flash
	[1054] = {name = 'Dach Alien', price = 2500, type = 'part',slot = 7}, -- Flash
	[1055] = {name = 'Dach Alien', price = 3000, type = 'part', slot = 7}, -- Statum
	[1056] = {name = 'Prawy próg Alien', price = 4500, type = 'part', slot = 3}, -- Statum
	[1057] = {name = 'Prawy próg X-Flow', price = 4500, type = 'part', slot = 3}, -- Statum
	[1058] = {name = 'Spoiler Alien', price = 1500, type = 'part', slot = 2}, -- Statum
	[1059] = {name = 'Wydech X-Flow', price = 1500, type = 'part', slot = 13}, -- Statum
	[1060] = {name = 'Spoiler X-Flow', price = 1500, type = 'part', slot = 2}, -- Statum
	[1061] = {name = 'Dach X-Flow', price = 2500, type = 'part', slot = 7}, -- Statum
	[1062] = {name = 'Lewy próg Alien', price = 4500, type = 'part', slot = 3}, -- Statum
	[1063] = {name = 'Lewy próg X-Flow', price = 4500, type = 'part', slot = 3}, -- Statum
	[1064] = {name = 'Wydech Alien', price = 1500, type = 'part', slot = 13}, -- Statum
	[1065] = {name = 'Wydech Alien', price = 1500, type = 'part', slot = 13}, -- Jester
	[1066] = {name = 'Wydech X-Flow', price = 1500, type = 'part', slot = 13}, -- Jester
	[1067] = {name = 'Dach Alien', price = 2500, type = 'part', slot = 7}, -- Jester
	[1068] = {name = 'Dach X-Flow', price = 2500, type = 'part', slot = 7}, -- Jester
	[1069] = {name = 'Prawy próg Alien', price = 1500, type = 'part', slot = 3}, -- Jester
	[1070] = {name = 'Prawy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Jester
	[1071] = {name = 'Lewy próg Alien', price = 1500, type = 'part', slot = 3}, -- Jester
	[1072] = {name = 'Lewy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Jester
	[1073] = {name = 'Felgi Shadow', price = 500, type = 'part', slot = 12},
	[1074] = {name = 'Felgi Mega', price = 500, type = 'part', slot = 12},
	[1075] = {name = 'Felgi Rimshine', price = 600, type = 'part', slot = 12},
	[1076] = {name = 'Felgi Wires', price = 300, type = 'part', slot = 12},
	[1077] = {name = 'Felgi Classic', price = 100, type = 'part', slot = 12},
	[1078] = {name = 'Felgi Twist', price = 1000, type = 'part', slot = 12},
	[1079] = {name = 'Felgi Cutter', price = 1000, type = 'part', slot = 12},
	[1080] = {name = 'Felgi Switch', price = 1000, type = 'part', slot = 12},
	[1081] = {name = 'Felgi Grove', price = 1500, type = 'part', slot = 12},
	[1082] = {name = 'Felgi Import', price = 7500, type = 'part', slot = 12},
	[1083] = {name = 'Felgi Dollar', price = 5000, type = 'part', slot = 12},
	[1084] = {name = 'Felgi Trance', price = 1500, type = 'part', slot = 12},
	[1085] = {name = 'Felgi Atomic', price = 2000, type = 'part', slot = 12},
	[1086] = {name = 'Stereo', price = 10000, type = 'part', slot = 10},
	[1087] = {name = 'Hydraulika', price = 7500, type = 'part', slot = 9},
	[1088] = {name = 'Dach Alien', price = 2500, type = 'part', slot = 7}, -- Uranus
	[1089] = {name = 'Wydech X-Flow', price = 1500, type = 'part', slot = 13}, -- Uranus
	[1090] = {name = 'Prawy próg Alien', price = 1500, type = 'part', slot = 3}, -- Uranus
	[1091] = {name = 'Dach X-Flow', price = 2500, type = 'part', slot = 7}, -- Uranus
	[1092] = {name = 'Wydech Alien', price = 1500, type = 'part', slot = 13}, -- Uranus
	[1093] = {name = 'Lewy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Uranus
	[1094] = {name = 'Lewy próg Alien', price = 1500, type = 'part', slot = 3}, -- Uranus
	[1095] = {name = 'Prawy próg X-Flow', price = 1500, type = 'part', slot = 3}, -- Uranus
	[1096] = {name = 'Felgi Ahab', price = 1000, type = 'part', slot = 12},
	[1097] = {name = 'Felgi Virtual', price = 1000, type = 'part', slot = 12},
	[1098] = {name = 'Felgi Access', price = 1000, type = 'part', slot = 12},
	[1099] = {name = 'Lewy próg Chrome', price = 1500, type = 'part', slot = 3}, -- Brodway
	[1100] = {name = 'Osłona zderzaka Chrome Grill', price = 1500, type = 'part', slot = 4}, -- Remington
	[1101] = {name = 'Lewy próg Chrome Flames', price = 1500, type = 'part', slot = 3}, -- Remington
	[1102] = {name = 'Lewy próg Chrome Strip', price = 1500, type = 'part', slot = 3}, -- Savanna
	[1103] = {name = 'Dach Covertible', price = 2500, type = 'part', slot = 7}, -- Blade
	[1104] = {name = 'Wydech Chrome', price = 1500, type = 'part', slot = 13}, -- Blade
	[1105] = {name = 'Wydech Slamin', price = 1500, type = 'part', slot = 13}, -- Blade
	[1106] = {name = 'Prawy próg Chrome Arches', price = 1500, type = 'part', slot = 3}, -- Remington
	[1107] = {name = 'Lewy próg Chrome Strip', price = 1500, type = 'part', slot = 3}, -- Blade
	[1108] = {name = 'Prawy próg Chrome Strip', price = 1500, type = 'part', slot = 3}, -- Blade
	[1109] = {name = 'Tylnie osłony Chrome', price = 2000, type = 'part', slot = 5}, -- Slamvan
	[1110] = {name = 'Tylnie osłony Slamin', price = 2000, type = 'part', slot = 5}, -- Slamvan
	[1111] = {name = 'Front Little Sign', price = 1500, type = 'part', slot = 11}, -- Slamvan
	[1112] = {name = 'Front Little Sign 2', price = 1500, type = 'part', slot = 11}, -- Slamvan
	[1113] = {name = 'Wydech Chrome', price = 1500, type = 'part', slot = 13}, -- Slamvan
	[1114] = {name = 'Wydech Slamin', price = 1500, type = 'part', slot = 13}, -- Slamvan
	[1115] = {name = 'Przednie osłony Chrome', price = 1500, type = 'part', slot = 4}, -- Slamvan
	[1116] = {name = 'Przednie osłony Slamin', price = 1500, type = 'part', slot = 4}, -- Slamvan
	[1117] = {name = 'Przedni zderzak Chrome', price = 1500, type = 'part', slot = 14}, -- Slamvan
	[1118] = {name = 'Prawy próg Chrome Trim', price = 1500, type = 'part', slot = 3}, -- Slamvan
	[1119] = {name = 'Prawy próg Wheelcovers', price = 1500, type = 'part', slot = 3}, -- Slamvan
	[1120] = {name = 'Lewy próg Chrome Trim', price = 1500, type = 'part', slot = 3}, -- Slamvan
	[1121] = {name = 'Lewy próg Wheelcovers', price = 1500, type = 'part', slot = 3}, -- Slamvan
	[1122] = {name = 'Prawy próg Chrome Flames', price = 1500, type = 'part', slot = 3}, -- Remington
	[1123] = {name = 'Osłony Chrome Bars', price = 2000, type = 'part', slot = 16}, -- Remington
	[1124] = {name = 'Lewy próg Chrome Arches', price = 1500, type = 'part', slot = 3}, -- Remington
	[1125] = {name = 'Osłony Chrome Lights', price = 2000, type = 'part', slot = 16}, -- Remington
	[1126] = {name = 'Wydech Chrome', price = 1500, type = 'part', slot = 13}, -- Remington
	[1127] = {name = 'Wydech Slamin', price = 1500, type = 'part', slot = 13}, -- Remington
	[1128] = {name = 'Dach Vinyl Hardtop', price = 2500, type = 'part', slot = 7}, -- Blade
	[1129] = {name = 'Wydech Chrome', price = 1500, type = 'part', slot = 13}, -- Savanna
	[1130] = {name = 'Dach Hardtop', price = 2500, type = 'part', slot = 7}, -- Savanna
	[1131] = {name = 'Dach Softtop', price = 2500, type = 'part', slot = 7}, -- Savanna
	[1132] = {name = 'Wydech Slamin', price = 1500, type = 'part', slot = 13}, -- Savanna
	[1133] = {name = 'Prawy próg Chrome Strip', price = 1500, type = 'part', slot = 3}, -- Savanna
	[1134] = {name = 'Prawy próg Chrome Strip', price = 1500, type = 'part', slot = 3}, -- Tornado
	[1135] = {name = 'Wydech Slamin', price = 1500, type = 'part', slot = 13}, -- Tornado
	[1136] = {name = 'Wydech Chrome', price = 1500, type = 'part', slot = 13}, -- Tornado
	[1137] = {name = 'Lewy próg Chrome Strip', price = 1500, type = 'part', slot = 3}, -- Tornado
	[1138] = {name = 'Spoiler Alien', price = 2000, type = 'part', slot = 2}, -- Sultan
	[1139] = {name = 'Spoiler X-Flow', price = 1500, type = 'part', slot = 2}, -- Sultan
	[1140] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Sultan
	[1141] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Sultan
	[1142] = {name = 'Lewa okrągła wentylacja', price = 5000, type = 'part', slot = 1},
	[1143] = {name = 'Prawa okrągła wentylacja', price = 5000, type = 'part', slot = 1},
	[1144] = {name = 'Lewa kwadratowa wentylacja', price = 5000, type = 'part', slot = 1},
	[1145] = {name = 'Prawa kwadratowa wentylacja', price = 5000, type = 'part', slot = 1},
	[1146] = {name = 'Spoiler X-Flow', price = 1500, type = 'part', slot = 2}, -- Elegy
	[1147] = {name = 'Spoiler Alien', price = 1500, type = 'part', slot = 2}, -- Elegy
	[1148] = {name = 'Tylni zderzak X-Flow', price = 1500, type = 'part', slot = 15}, -- Elegy
	[1149] = {name = 'Tylni zderzak Alien', price = 1500, type = 'part', slot = 15}, -- Elegy
	[1150] = {name = 'Tylni zderzak Alien', price = 1500, type = 'part', slot = 15}, -- Flash
	[1151] = {name = 'Tylni zderzak X-Flow', price = 1500, type = 'part', slot = 15}, -- Flash
	[1152] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Flash
	[1153] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Flash
	[1154] = {name = 'Tylni zderzak Alien', price = 1500, type = 'part', slot = 15}, -- Stratum
	[1155] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Stratum
	[1156] = {name = 'Tylni zderzak X-Flow', price = 1500, type = 'part', slot = 15}, -- Stratum
	[1157] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Stratum
	[1158] = {name = 'Spoiler X-Flow', price = 1500, type = 'part', slot = 2}, -- Jester
	[1159] = {name = 'Tylni zderzak Alien', price = 1500, type = 'part', slot = 15}, -- Jester
	[1160] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Jester
	[1161] = {name = 'Tylni zderzak X-Flow', price = 1500, type = 'part', slot = 15}, -- Jester
	[1162] = {name = 'Spoiler Alien', price = 1500, type = 'part', slot = 2}, -- Jester
	[1163] = {name = 'Spoiler X-Flow', price = 1500, type = 'part', slot = 2}, -- Uranus
	[1164] = {name = 'Spoiler Alien', price = 1500, type = 'part', slot = 2}, -- Uranus
	[1165] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Uranus
	[1166] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Uranus
	[1167] = {name = 'Tylni zderzak X-Flow', price = 1500, type = 'part', slot = 15}, -- Uranus
	[1168] = {name = 'Tylni zderzak Alien', price = 1500, type = 'part', slot = 15}, -- Uranus
	[1169] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Sultan
	[1170] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Sultan
	[1171] = {name = 'Przedni zderzak Alien', price = 1500, type = 'part', slot = 14}, -- Elegy
	[1172] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Elegy
	[1173] = {name = 'Przedni zderzak X-Flow', price = 1500, type = 'part', slot = 14}, -- Jester
	[1174] = {name = 'Przedni zderzak Chrome', price = 1500, type = 'part', slot = 14}, -- Broadway
	[1175] = {name = 'Przedni zderzak Slamin', price = 1500, type = 'part', slot = 14}, -- Broadway
	[1176] = {name = 'Tylni zderzak Chrome', price = 1500, type = 'part', slot = 15}, -- Broadway
	[1177] = {name = 'Tylni zderzak Slamin', price = 1500, type = 'part', slot = 15}, -- Broadway
	[1178] = {name = 'Tylni zderzak Slamin', price = 1500, type = 'part', slot = 15}, -- Remington
	[1179] = {name = 'Przedni zderzak Chrome', price = 1500, type = 'part', slot = 14}, -- Remington
	[1180] = {name = 'Tylni zderzak Chrome', price = 1500, type = 'part', slot = 15}, -- Remington
	[1181] = {name = 'Przedni zderzak Slamin', price = 1500, type = 'part', slot = 14}, -- Blade
	[1182] = {name = 'Przedni zderzak Chrome', price = 1500, type = 'part', slot = 14}, -- Blade
	[1183] = {name = 'Tylni zderzak Slamin', price = 1500, type = 'part', slot = 15}, -- Blade
	[1184] = {name = 'Tylni zderzak Chrome', price = 1500, type = 'part', slot = 15}, -- Blade
	[1185] = {name = 'Przedni zderzak Slamin', price = 1500, type = 'part', slot = 14}, -- Remington
	[1186] = {name = 'Tylni zderzak Slamin', price = 1500, type = 'part', slot = 15}, -- Savanna
	[1187] = {name = 'Tylni zderzak Chrome', price = 1500, type = 'part', slot = 15}, -- Savanna
	[1188] = {name = 'Przedni zderzak Slamin', price = 1500, type = 'part', slot = 14}, -- Savanna
	[1189] = {name = 'Przedni zderzak Chrome', price = 1500, type = 'part', slot = 14}, -- Savanna
	[1190] = {name = 'Przedni zderzak Slamin', price = 1500, type = 'part', slot = 14}, -- Tornado
	[1191] = {name = 'Przedni zderzak Chrome', price = 1500, type = 'part', slot = 14}, -- Tornado
	[1192] = {name = 'Tylni zderzak Slamin', price = 1500, type = 'part', slot = 15}, -- Tornado
	[1193] = {name = 'Tylni zderzak Chrome', price = 1500, type = 'part', slot = 15}, -- Tornado
};