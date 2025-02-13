#include "demo_pcg.h"
#include "sens_humd_atm.h"

void fillReadingsHumAtm(int readingsSize, unsigned short* humAtmReadingsPtr, unsigned short* pluvioReadingsPtr){

    long i;

    *humAtmReadingsPtr = (unsigned short) (pcg32_random_r()%100);
    for (i = 1; i < readingsSize; i++) {
        *(humAtmReadingsPtr + i) = (unsigned short)sens_humd_atm((char) *(humAtmReadingsPtr + i - 1), (char) *(pluvioReadingsPtr + i) ,(char)(pcg32_random_r()%100));
    }
}
