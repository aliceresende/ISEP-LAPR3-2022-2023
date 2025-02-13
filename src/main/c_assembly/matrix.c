#include "demo_pcg.h"
#include "sens_temp.h"
#include "sens_velc_vento.h"
#include "sens_pluvio.h"
#include "sens_humd_atm.h"
#include "sens_humd_solo.h"

void createMatrix(int numberOfSensors, int readingsPerDay, int nSoilHum,int matrix[numberOfSensors][readingsPerDay]){

int i;
int j;

*(*(matrix + 0) + 0)=(char)pcg32_random_r();
for ( i = 1; i < readingsPerDay; i++)
{
   *(*(matrix + 0) + i) = (int)sens_temp((char)*(*(matrix + 0) + i-1),(char)pcg32_random_r());
}

*(*(matrix + 1) + 0)= (char)pcg32_random_r();
for ( i = 1; i < readingsPerDay; i++)
{
   *(*(matrix + 1) + i) = (int)sens_velc_vento((char)*(*(matrix + 1) + i-1),(char)pcg32_random_r());
}

*(*(matrix + 2) + 0)= (char)pcg32_random_r();
for ( i = 1; i < readingsPerDay; i++)
{
   *(*(matrix + 2) + i) = (int)sens_pluvio((char)*(*(matrix + 2) + i-1),(char)*(*(matrix + 0) + i),(char)pcg32_random_r());
}

*(*(matrix + 3) + 0)= (char)(pcg32_random_r()%100);
for ( i = 1; i < readingsPerDay; i++)
{
   *(*(matrix + 3) + i) = (int)sens_humd_atm((char)*(*(matrix + 3) + i-1),(char)*(*(matrix + 2) + i),(char)(pcg32_random_r()%100));
}

*(*(matrix + 4) + 0)= (char)(pcg32_random_r()%100);
for ( i = 4; i < nSoilHum + 4; i++)
{
    *(*(matrix + i) + 0)= (char)(pcg32_random_r()%100);
    for( j = 1; j < readingsPerDay; j++)
        *(*(matrix + i) + j) = (int)sens_humd_solo((char)*(*(matrix + i) + j-1),(char)*(*(matrix + 2) + j),(char)(pcg32_random_r()%100));
    }

}
