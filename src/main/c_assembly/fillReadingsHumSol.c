#include "demo_pcg.h"
#include "sens_humd_solo.h"

void fillReadingsHumSol(int readingsSize, unsigned short* humSolReadingsPtr, unsigned short* pluvioReadingsPtr){
    long i;

    *humSolReadingsPtr = (unsigned short) (pcg32_random_r()%100);
    for (i = 1; i < readingsSize; i++) {
        *(humSolReadingsPtr + i) = (unsigned short)sens_humd_atm((char) *(humSolReadingsPtr + i - 1), (char) *(pluvioReadingsPtr + i) ,(char)(pcg32_random_r()%100));
    }
}
