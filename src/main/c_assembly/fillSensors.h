#ifndef FILLSENSORS_H
#define FILLSENSORS_H

typedef struct {
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit;
    unsigned short min_limit;
    unsigned long frequency;
    unsigned long readings_size;
    unsigned short *readings;
} Sensor;

void fillSensor(Sensor *sensorPtr, unsigned short id, unsigned char sensor_type,  unsigned short max_limit, unsigned short min_limit,unsigned long readings_size, unsigned long frequency, unsigned short *readings);

#endif