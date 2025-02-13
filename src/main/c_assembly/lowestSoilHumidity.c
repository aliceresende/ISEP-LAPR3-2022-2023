int lowestSoilHumidity( int readingsPerDay, int nSoilSens,int matrix[][readingsPerDay]){

int i,j;
int lowest =  *(*(matrix + 4) + 0);

for ( i = 0; i < nSoilSens; i++)
{
    for ( j = 0; j < readingsPerDay; j++)
    {
        if ( *(*(matrix + 4+i) + j)< lowest)
        {
            lowest = *(*(matrix + 4+i) + j);
        }
    }
}
return lowest;
}