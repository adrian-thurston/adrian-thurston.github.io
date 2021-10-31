digraph adcpEngine {
	rankdir=LR;
	node [ shape = point ];
	ENTRY;
	en_4;
	node [ shape = circle, height = 0.2 ];
	node [ fixedsize = true, height = 0.65, shape = doublecircle ];
	4;
	5;
	node [ shape = circle ];
	1 -> 2 [ label = "DEF / clearTemp, accumTemp" ];
	2 -> 5 [ label = "DEF / accumTemp, storeSamplesPerBlock" ];
	3 -> 5 [ label = "0..255(dataRemaining) / accumTemp, storeData, processCompleteMessage" ];
	4 -> 1 [ label = "0 / clearAll" ];
	5 -> 1 [ label = "0(!dataRemaining) / clearAll" ];
	5 -> 3 [ label = "0..255(dataRemaining) / clearTemp, accumTemp" ];
	ENTRY -> 4 [ label = "IN" ];
	en_4 -> 4 [ label = "main" ];
}
