#include "demo_pcg.h"
#include "sens_velc_vento.h"

void fillReadingsVelocidadeVento(int readingsSize, unsigned short* velVentoReadingsPtr){

    long i;

    *velVentoReadingsPtr = (unsigned short) pcg32_random_r();
    for (i = 1; i < readingsSize; i++) {
        *(velVentoReadingsPtr + i) = (unsigned short)sens_velc_vento((char) *(velVentoReadingsPtr + i - 1),(char)pcg32_random_r());
    }
}
