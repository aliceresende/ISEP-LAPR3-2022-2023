#include "readingfrequency.h"

void fillSensor(Sensor sensor,unsigned long frequency){
	
    Sensor* sensorPtr = &sensor;

    sensorPtr -> frequency = frequency;
    unsigned long readings_size = (3600/frequency) * 24;
    sensorPtr -> readings_size = readings_size;
    
}