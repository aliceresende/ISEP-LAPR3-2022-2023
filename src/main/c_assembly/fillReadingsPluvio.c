#include "demo_pcg.h"
#include "sens_pluvio.h"

void fillReadingsPluvio(int readingsSize, unsigned short* pluvioReadingsPtr, unsigned short* temperaturaReadingsPtr){

    long i;
    *pluvioReadingsPtr = (unsigned short) pcg32_random_r();
    for (i = 1; i < readingsSize; i++) {
        *(pluvioReadingsPtr + i) = (unsigned short)sens_pluvio((char) *(pluvioReadingsPtr + i - 1), (char) *(temperaturaReadingsPtr + i) ,(char)pcg32_random_r());
    }
}
