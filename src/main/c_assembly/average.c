#include <stdio.h>

int average(int soma,long readingsPerDay,unsigned short *readings){

    int i;

    for( i = 0; i < readingsPerDay; i++){
		 soma = soma + *(readings + i);
    }

    return soma;
}
