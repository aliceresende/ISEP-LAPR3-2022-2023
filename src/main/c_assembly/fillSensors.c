#include "fillSensors.h"
#include <string.h>
#include <stdlib.h>

void fillSensor(Sensor *sensorPtr, unsigned short id, unsigned char sensor_type,  unsigned short max_limit, unsigned short min_limit,unsigned long readings_size, unsigned long frequency, unsigned short *readingsDone){
	
	sensorPtr -> id = id;
	sensorPtr -> sensor_type = sensor_type;
	sensorPtr -> max_limit = max_limit;
	sensorPtr -> min_limit = min_limit;
	sensorPtr -> frequency = frequency;
	sensorPtr -> readings_size = readings_size;

	sensorPtr -> readings = ( unsigned short *) calloc(readings_size, sizeof(short));
	memcpy(sensorPtr -> readings, readingsDone, readings_size * sizeof(short));

}

