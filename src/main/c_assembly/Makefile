main: main.o demo_pcg.o readingsperDay.o sens_dir_vento.o sens_humd_atm.o sens_humd_solo.o sens_pluvio.o sens_temp.o sens_velc_vento.o lowest.o highest.o average.o fillSensors.o 
	gcc -Wall -g main.o demo_pcg.o readingsperDay.o sens_dir_vento.o sens_humd_atm.o sens_humd_solo.o sens_pluvio.o sens_temp.o sens_velc_vento.o lowest.o highest.o average.o fillSensors.o -o main

main.o: main.c demo_pcg.h sens_dir_vento.h sens_humd_atm.h sens_humd_solo.h sens_pluvio.h sens_temp.h sens_velc_vento.h fillSensors.h 
	gcc -Wall -g -c main.c

demo_pcg.o: demo_pcg.s
	gcc -Wall -g -c demo_pcg.s

readingsperDay.o: readingsperDay.c
	gcc -g -Wall -c readingsperDay.c -o readingsperDay.o
	
sens_dir_vento.o: sens_dir_vento.s
	gcc -Wall -g -c sens_dir_vento.s

sens_humd_atm.o: sens_humd_atm.s
	gcc -Wall -g -c sens_humd_atm.s

sens_humd_solo.o: sens_humd_solo.s
	gcc -Wall -g -c sens_humd_solo.s

sens_pluvio.o: sens_pluvio.s
	gcc -Wall -g -c sens_pluvio.s

sens_temp.o: sens_temp.s
	gcc -Wall -g -c sens_temp.s

sens_velc_vento.o: sens_velc_vento.s
	gcc -Wall -g -c sens_velc_vento.s

lowest.o: lowest.c
	gcc -g -Wall -c lowest.c -o lowest.o

average.o: average.c
	gcc -g -Wall -c average.c -o average.o

highest.o: highest.c
	gcc -g -Wall -c highest.c -o highest.o

fillSensors.o: fillSensors.c
	gcc -g -Wall -c fillSensors.c -o fillSensors.o

run: main
	./main

clean:
	rm *.o main
