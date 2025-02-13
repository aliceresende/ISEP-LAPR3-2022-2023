#include "fillSensors.h"

void changefrequency(Sensor sensor,unsigned long frequency,unsigned short *readings){
	
    Sensor* sensorPtr = &sensor;

    sensorPtr -> frequency = frequency;
    unsigned long readings_size = (3600/frequency) * 24;
    sensorPtr -> readings_size = readings_size;
    sensorPtr -> readings = readings;
}