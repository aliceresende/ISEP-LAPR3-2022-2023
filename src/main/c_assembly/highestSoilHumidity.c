int highestSoilHumidity( int readingsPerDay, int nSoilSens, int matrix[][readingsPerDay]){

int i,j;
int highest =  *(*(matrix + 4) + 0);

for ( i = 0; i < nSoilSens; i++){
    
    for ( j = 0; j < readingsPerDay; j++){

        if ( *(*(matrix + 4+i) + j)> highest){

            highest = *(*(matrix + 4+i) + j);
        }
    }
}
return highest;

}