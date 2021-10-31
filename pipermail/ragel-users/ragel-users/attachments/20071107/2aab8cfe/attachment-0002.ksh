

rwf: rwf.cpp
	g++ -O3 -o rwf rwf.cpp -lpthread

rwf.cpp: rwf.rl
	ragel rwf.rl | rlgen-cd -G2 -o rwf.cpp
