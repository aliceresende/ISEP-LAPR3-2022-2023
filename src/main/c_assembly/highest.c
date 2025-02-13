#include <stdio.h>

int highest(int highest,long readingsPerDay, unsigned short *readings){

    int i;
    
    for( i = 0; i < readingsPerDay; i++){   
     
        if(highest< *(readings  + i)){
 
            highest = *(readings + i);
        }

    }

    return highest;
}
