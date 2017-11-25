#include <stdio.h>
#include <pthread.h>
#include <malloc.h>

#define NUM 0x4
#define START 0x41

long long int threadInts[NUM];

struct args{
	void * a;
	void * b;
};

extern void * thread1(void *);

void main(){
	puts("working\n");
	int i;
	for(i=0;i<NUM;i++){
		char val;
		val = START + i*2;
		threadInts[i] = val | (val<<8) | (val<<16) | (val<<24);
	}

	pthread_t tids[NUM];

	for(i=0;i<NUM;i++){
		struct args * args = malloc(sizeof(struct args));
		args->a = &threadInts[i];
		args->b = malloc(0x21000);

		pthread_create(&tids[i], NULL, thread1, args);
	}

	int cont=1;
	while(cont){
		for(i=0;i<NUM;i++){
			char val;
			val = START + i*2;
			if(threadInts[i] != (val | (val<<8) | (val<<16) | (val<<24))){
				puts("THIS BROKE\n");
				printf("%i failed == %x != %x\n", i, threadInts[i], val);
				cont = 0;
				break;
			}

		}
	}
}
