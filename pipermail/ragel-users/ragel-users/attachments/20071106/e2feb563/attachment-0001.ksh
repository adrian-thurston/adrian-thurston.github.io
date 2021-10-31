

wf: wf.c
	gcc -O3 -o wf wf.c

wf.c: wf.rl
	ragel wf.rl | rlgen-cd -G2 -o wf.c
