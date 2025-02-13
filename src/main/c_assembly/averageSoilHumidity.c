#include <stdio.h>

int averageSoilHumidity( long readingsPerDay, int linhaDeInicio, int linhaDeFim,char matrixPtr[linhaDeInicio][readingsPerDay]){

int i,j;
int soma = 0;

for ( i = linhaDeInicio; i < linhaDeFim; i++) {
    for ( j = 0; j < readingsPerDay; j++) {
		printf("%d \n",*(*(matrixPtr + i) + j));
        soma = soma + *(*(matrixPtr + i) + j);
    }
    
}
printf("\n");
soma = soma/(readingsPerDay * ((linhaDeFim - linhaDeInicio)));
return soma;
}
