#ifndef READINGFREQUENCY_H
#define READINGFREQUENCY_H

typedef struct {
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit;
    unsigned short min_limit;
    unsigned long frequency;
    unsigned long readings_size;
    unsigned short *readings;
} Sensor;

void changefrequency(Sensor sensor, unsigned long frequency);

#endif
