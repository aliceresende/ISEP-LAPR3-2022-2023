#include "demo_pcg.h"
#include "sens_temp.h"

void fillReadingsTemperatura(int readingsSize, unsigned short* temperaturaReadingsPtr){

    long i;

    *temperaturaReadingsPtr = (unsigned short) pcg32_random_r();
    for (i = 1; i < readingsSize; i++) {
        *(temperaturaReadingsPtr + i) = (unsigned short)sens_temp((char) *(temperaturaReadingsPtr + i - 1),(char)pcg32_random_r());
    }
}
