int lowest(int lowest,long readingsPerDay,unsigned short *readings){

    int i;

    for( i = 0; i < readingsPerDay; i++){

        if(lowest > *(readings  + i)){
            lowest = *(readings + i);
        }
    }

    return lowest;
    
}
