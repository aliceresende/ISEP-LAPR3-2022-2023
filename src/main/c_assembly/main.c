#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

// US101
#include "demo_pcg.h"
// US102
#include "sens_dir_vento.h"
#include "sens_humd_atm.h"
#include "sens_humd_solo.h"
#include "sens_pluvio.h"
#include "sens_velc_vento.h"
#include "sens_temp.h"

#include "readingsperDay.h"

// US104
#include "highest.h"
#include "average.h"
#include "lowest.h"

// US110
#include "fillSensors.h"

// -----------------------------------------------------------------------------------------------------------
int i;

unsigned long state;
unsigned long inc;
unsigned long long num = 6364136223846793005ULL;

int numSensTemp, numSensVento, numSensPluvio, numSensAtm, numSensSoil, numSensDirVento, changedSensores;
Sensor *sensoresTemperatura, *sensoresVelVento, *sensoresPluviosidade, *sensoresHumidadeAtm, *sensoresHumidadeSolo, *sensoresDirVento;
int maxErrorCount, maior, menor,soma,errorCount, countBuff,i,j,change;
short minValue, maxValue;
long sizeTemperatura, sizeVento, sizePluviosidade, sizeHumidadeAtm, sizeHumidadeSolo, sizeDirVento;
unsigned short *readTemperatura, *readVento, *readPluviosidade, *readHumidadeAtm, *readHumidadeSolo, *readDirVento;
FILE *fptr, *fptrM;
float freqTemperatura, freqVelVento, freqPluvio, freqHumidadeAtm, freqHumidadeSolo, freqDirVento;
char answerSensTemp;

//US101 -----------------------------------------------------------------------------------------------------

void readRandomNumbers(unsigned long *buffer, int size) {
    FILE *f;
    int result;

    f = fopen("/dev/urandom", "r");

    if (f == NULL){
        printf("Error: open() failed to open /dev/random for reading\n");
        exit(1);
    }

    result = fread(buffer, sizeof(unsigned long), size, f);

    if (result < 1){
        printf("error , failed to read and words\n");
        exit(1);
    }
}

//----------------------------------------------------------------------------------------------------

void readSensoresTemperatura(short (*ptrMatrix)[3] ){

    fprintf(fptr, "--------Sensor de temperatura--------\n");
    printf("%s", "-------Sensor de temperatura-------\n");
    char ult_temp = 15;
    fprintf(fptr, "\nLeituras:\n\n");
    printf("\nLeituras:\n");

    int sizeBuff = (2 * numSensTemp * sizeTemperatura);

    unsigned long buffer[sizeBuff];
    unsigned long *ptrBuffer = buffer;
    readRandomNumbers(ptrBuffer,sizeBuff);

    countBuff = 0;

    for (i = 0; i < numSensTemp; i++){

        // obter o numero do sensor
        int nsensor = i + 1;
        fprintf(fptr, "\n   Sensor nº %d\n\n",nsensor);
        printf("\n  Sensor nº %d\n",nsensor);

        for(j = 0; j < sizeTemperatura; j++) {

            // variaveis para pcg32_random
             state = buffer[countBuff];
             inc = buffer[countBuff + 1];

            //Criar a nova temperatura
             ult_temp = sens_temp(ult_temp, (char)pcg32_random_r());

             if( i == 0 && j == 0){ 
                maior = ult_temp;
                menor = ult_temp;
             }

            //adicionar o valor ao array de leituras
             *(readTemperatura + j ) = ult_temp;

             // print do valor gerado
             printf("%6d°C", ult_temp);
             fprintf(fptr, "%6d°C",ult_temp);

            //verificar intervalo leitura - US104
             if ((short)ult_temp < minValue || (short)ult_temp > maxValue){

                errorCount++;
                printf("ERRO");

                if (errorCount == maxErrorCount){
                    // return main();
                }

             } else {
                errorCount = 0;
             }

             countBuff++;

        }

        fillSensor((sensoresTemperatura +i), nsensor,(unsigned char)'1', (unsigned short) maxValue,(unsigned short) minValue,(unsigned long) sizeTemperatura,(unsigned long) freqTemperatura, readTemperatura);

        //TESTAR O FILL READINGS: printf("\n%d\n", sensoresTemperatura[i].readings[1]);

        maior = highest(maior,sizeTemperatura,readTemperatura);
        menor = lowest(menor,sizeTemperatura,readTemperatura); 
        soma = average(soma,sizeTemperatura,readTemperatura);

        fprintf(fptr, "\n    ----------------\n");
        printf("%s", "\n    --------------\n");
    }

    // preencher com Média
     *(*(ptrMatrix + 1)+ 0) = soma/(sizeVento * numSensVento);

    // preencher com Max
     *(*(ptrMatrix + 1)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 1)+ 2) = menor;


}

void readSensoresVelVento(short (*ptrMatrix)[3] ){

    printf("\n\n%s", "-------Sensor de velocidade vento-------\n");
    fprintf(fptr, "\n\n-------Sensor de velocidade vento-------\n");
    unsigned char ult_velc_vento = 35;
    fprintf(fptr, "\nLeituras:\n\n");
    printf("\nLeituras:\n");

    int sizeBuff = (2 * numSensVento * sizeVento);

    unsigned long buffer[sizeBuff];
    unsigned long *ptrBuffer = buffer;
    readRandomNumbers(ptrBuffer,sizeBuff);

    soma=0;
    countBuff = 0;


    for (i = numSensTemp; i < (numSensVento + numSensTemp ); i++){

        int nsensor = i - numSensTemp + 1;

        fprintf(fptr, "\n   Sensor nº %d\n\n",nsensor);
        printf("\n  Sensor nº %d\n\n",nsensor);

        for(j = 0; j < sizeVento; j++) {

             state = buffer[countBuff];
             inc = buffer[countBuff + 1];

             ult_velc_vento = sens_velc_vento(ult_velc_vento, (char)pcg32_random_r());

            if( i == numSensTemp && j == 0){ 
                maior = ult_velc_vento;
                menor = ult_velc_vento;
             }

            //adicionar o valor ao array de leituras
             *(readVento + j ) = ult_velc_vento;

             printf("%6dkm/h", ult_velc_vento);
             fprintf(fptr,"%6dkm/h", ult_velc_vento);

             if (ult_velc_vento < minValue || ult_velc_vento > maxValue){

                errorCount++;
                if (errorCount == maxErrorCount) {
                    //return main();
                }
            } else {
                errorCount = 0;
            }

            countBuff++;
        }

        fillSensor((sensoresVelVento + i), nsensor,(unsigned char)'2', (unsigned short) maxValue,(unsigned short) minValue,(unsigned long) sizeVento,(unsigned long) freqVelVento, readVento);

        maior = highest(maior,sizeVento,readVento);
        menor = lowest(menor,sizeVento,readVento);
        soma = average(soma,sizeVento,readVento);

        fprintf(fptr, "\n\n    ----------------\n");
        printf("%s", "\n\n    --------------\n");
    }

    // preencher com Média
     *(*(ptrMatrix + 1)+ 0) = soma/(sizeVento * numSensVento);

    // preencher com Max
     *(*(ptrMatrix + 1)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 1)+ 2) = menor;

}

void readSensoresPluviosidade(short (*ptrMatrix)[3] ){

    printf("\n\n%s", "-------Sensor de pluviosidade-------\n");
    fprintf(fptr, "\n\n-------Sensor de pluviosidade-------\n");
    char ult_temp = 15;
    unsigned char ult_pluvio = 20;
    fprintf(fptr, "\nLeituras:\n\n");
    printf("\nLeituras:\n");

    int sizeBuff = (2 * numSensPluvio * sizePluviosidade);

    unsigned long buffer[sizeBuff];
    unsigned long *ptrBuffer = buffer;
    readRandomNumbers(ptrBuffer,sizeBuff);

    soma=0;

    countBuff = 0;

    for (i = (numSensTemp + numSensVento); i < (numSensTemp + numSensVento + numSensPluvio); i++){

        int nsensor = i - (numSensTemp + numSensVento) + 1;
        fprintf(fptr, "\n   Sensor nº %d\n\n",nsensor);
        printf("\n  Sensor nº %d\n",nsensor);

        for(j = 0; j < sizePluviosidade; j++) {

            state = buffer[countBuff];
            inc = buffer[countBuff + 1];

            ult_pluvio = sens_pluvio(ult_pluvio, ult_temp, (char)pcg32_random_r());

            if( i == (numSensTemp + numSensVento) && j == 0){ 
                maior = ult_pluvio;
                menor = ult_pluvio;
             }

            //adicionar o valor ao array de leituras
             *(readPluviosidade + j ) = ult_pluvio;


            printf("%6dmm", ult_pluvio);
            fprintf(fptr,"%6dmm", ult_pluvio);

            if (ult_pluvio < minValue || ult_pluvio > maxValue) {
                errorCount++;
                if (errorCount == maxErrorCount) {
                    //return main();
                }
            } else {
                errorCount = 0;
            }

            countBuff++;
        }

        fillSensor((sensoresPluviosidade +i), nsensor,(unsigned char)'3', (unsigned short) maxValue,(unsigned short) minValue,(unsigned long) sizePluviosidade,(unsigned long) freqPluvio, readPluviosidade);

        maior = highest(maior,sizePluviosidade,readPluviosidade);
        menor = lowest(menor,sizePluviosidade,readPluviosidade); 
        soma = average(soma,sizePluviosidade,readPluviosidade);


        fprintf(fptr, "\n    ----------------\n");
        printf("%s", "\n    --------------\n");
    }

    // preencher com Média
     *(*(ptrMatrix + 2)+ 0) = (soma/(sizePluviosidade * numSensPluvio));

    // preencher com Max
     *(*(ptrMatrix + 2)+ 1) =  maior;

    // preencher com Min
     *(*(ptrMatrix + 2)+ 2) =  menor;

}


void readSensoresHumidadeAtmosferica(short (*ptrMatrix)[3] ){

    printf("\n\n%s", "-------Sensor de humidade atmosférica-------\n");
    fprintf(fptr, "\n\n-------Sensor de humidade atmosférica-------\n");
    unsigned char ult_hmd_atm = 20;
    unsigned char ult_pluvio = 20;
    fprintf(fptr, "\nLeituras:\n\n");
    printf("\nLeituras:\n");

    int sizeBuff = (2 * numSensAtm * sizeHumidadeAtm);

    unsigned long buffer[sizeBuff];
    unsigned long *ptrBuffer = buffer;
    readRandomNumbers(ptrBuffer,sizeBuff);

    soma=0;

    countBuff = 0;

    for (i = (numSensTemp + numSensVento+numSensPluvio); i < (numSensTemp + numSensVento + numSensPluvio + numSensAtm); i++){

        int nsensor = i - (numSensTemp + numSensVento+numSensPluvio) + 1;
        fprintf(fptr, "\n   Sensor nº %d\n\n",nsensor);
        printf("\n  Sensor nº %d\n",nsensor);

        for(j = 0; j < sizeHumidadeAtm; j++) {

             state = buffer[countBuff];
             inc = buffer[countBuff + 1];

             ult_hmd_atm = sens_humd_atm(ult_hmd_atm, ult_pluvio, (char)(pcg32_random_r() % 100));

            if( i == (numSensTemp + numSensVento+numSensPluvio) && j == 0) { 
                maior = ult_hmd_atm;
                menor = ult_hmd_atm;
             }

             //adicionar o valor ao array de leituras
             *(readHumidadeAtm + j ) = ult_hmd_atm;

             printf("%6d%%", ult_hmd_atm);
             fprintf(fptr,"%6d%%", ult_hmd_atm);

             if (ult_hmd_atm < minValue || ult_hmd_atm > maxValue) {
                errorCount++;
                if (errorCount == maxErrorCount){
                    //return main();
                }
            } else {
                errorCount = 0;
            }

            countBuff++;
        }

        fillSensor((sensoresHumidadeAtm + i), nsensor,(unsigned char)'4', (unsigned short) maxValue,(unsigned short) minValue,(unsigned long) sizeHumidadeAtm,(unsigned long) freqHumidadeAtm, readHumidadeAtm);

        maior = highest(maior,sizeHumidadeAtm,readHumidadeAtm);
        menor = lowest(menor,sizeHumidadeAtm,readHumidadeAtm); 
        soma = average(soma,sizeHumidadeAtm,readHumidadeAtm);

        fprintf(fptr, "\n    ----------------\n");
        printf("%s", "\n    --------------\n");
    }

    // preencher com Média
     *(*(ptrMatrix + 3)+ 0) = soma/(sizeHumidadeAtm * numSensAtm);

    // preencher com Max
     *(*(ptrMatrix + 3)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 3)+ 2) = menor;

}


void readSensoresHumidadeSolo(short (*ptrMatrix)[3] ){

     printf("\n\n%s", "-------Sensor de humidade do solo-------\n");
     fprintf(fptr, "\n\n-------Sensor de humidade do solo-------\n");
     unsigned char ult_hmd_solo = 10;
     unsigned char ult_pluvio = 20;
     fprintf(fptr, "\nLeituras:\n\n");
     printf("\nLeituras:\n");

    int sizeBuff = (2 * numSensSoil * sizeHumidadeSolo);

    unsigned long buffer[sizeBuff];
    unsigned long *ptrBuffer = buffer;
    readRandomNumbers(ptrBuffer,sizeBuff);

     soma = 0;
     countBuff = 0;

     for (i = (numSensTemp + numSensVento + numSensPluvio + numSensAtm); i < (numSensTemp + numSensVento + numSensPluvio + numSensAtm + numSensSoil); i++){

        int nsensor = i - (numSensTemp + numSensVento + numSensPluvio + numSensAtm) + 1;
        fprintf(fptr, "\n   Sensor nº %d\n\n",nsensor);
        printf("\n  Sensor nº %d\n",nsensor);

        for(j = 0; j < sizeHumidadeSolo; j++) {

             state = buffer[countBuff];
             inc = buffer[countBuff + 1];

            ult_hmd_solo = sens_humd_solo(ult_hmd_solo, ult_pluvio, (char)(pcg32_random_r() % 100));

            if( i == (numSensTemp + numSensVento + numSensPluvio + numSensAtm) && j == 0) { 
                maior = ult_hmd_solo;
                menor = ult_hmd_solo;
             }

             //adicionar o valor ao array de leituras
             *(readHumidadeSolo + j ) = ult_hmd_solo;

            printf("%6d%%", ult_hmd_solo);
            fprintf(fptr,"%6d%%", ult_hmd_solo);

            if (ult_hmd_solo < minValue || ult_hmd_solo > maxValue){
                errorCount++;
                if (errorCount == maxErrorCount){
                    //return main();
                }
            } else {
                errorCount = 0;
        }
            countBuff++;
        }
        fillSensor((sensoresHumidadeSolo +i), nsensor,(unsigned char)'5', (unsigned short) maxValue,(unsigned short) minValue,(unsigned long) sizeHumidadeSolo,(unsigned long) freqHumidadeSolo, readHumidadeSolo);

        maior = highest(maior,sizeHumidadeSolo,readHumidadeSolo);
        menor = lowest(menor,sizeHumidadeSolo,readHumidadeSolo); 
        soma = average(soma,sizeHumidadeSolo,readHumidadeSolo);

        fprintf(fptr, "\n    ----------------\n");
        printf("%s", "\n    --------------\n");
     }

    // preencher com Média
     *(*(ptrMatrix + 4)+ 0) = soma/(sizeHumidadeSolo * numSensSoil);

    // preencher com Max
     *(*(ptrMatrix + 4)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 4)+ 2) = menor;

}

void readSensoresDirecaoVento(short (*ptrMatrix)[3] ){

    printf("\n\n%s", "-------Sensor de direção vento-------\n");
    fprintf(fptr, "\n\n-------Sensor de direção vento-------\n");
    unsigned short ult_dir_vento = 30;
    printf("******Relativamente a Norte******\n");
    fprintf(fptr,"******Relativamente a Norte******\n");
    fprintf(fptr, "\nLeituras:\n\n");
    printf("\nLeituras:\n");

    int sizeBuff = (2 * numSensDirVento * sizeDirVento);

    unsigned long buffer[sizeBuff];
    unsigned long *ptrBuffer = buffer;
    readRandomNumbers(ptrBuffer,sizeBuff);

    soma = 0;

    countBuff = 0;

    for (i = (numSensTemp + numSensVento + numSensPluvio + numSensAtm + numSensSoil); i < (numSensTemp + numSensVento + numSensPluvio + numSensAtm + numSensSoil + numSensDirVento); i++){

        int nsensor = i - (numSensTemp + numSensVento + numSensPluvio + numSensAtm + numSensSoil) + 1;
        fprintf(fptr, "\n   Sensor nº %d\n\n",nsensor);
        printf("\n  Sensor nº %d\n",nsensor);

        for(j = 0; j < sizeDirVento; j++) {

             state = buffer[countBuff];
             inc = buffer[countBuff + 1];

             ult_dir_vento = sens_dir_vento(ult_dir_vento, (short)pcg32_random_r());

            if( i == (numSensTemp + numSensVento + numSensPluvio + numSensAtm + numSensSoil) && j == 0) { 
                maior = ult_dir_vento;
                menor = ult_dir_vento;
             }

             //adicionar o valor ao array de leituras
             *(readDirVento + j ) = ult_dir_vento;


            printf("%6d°", ult_dir_vento);
            fprintf(fptr,"%6d°", ult_dir_vento);

            if (ult_dir_vento < minValue || ult_dir_vento > maxValue) {
                errorCount++;
                if (errorCount == maxErrorCount){
                    //return main();
                }
            } else {
                errorCount = 0;
            }
            countBuff++;
        }
        fillSensor((sensoresDirVento + i), nsensor,(unsigned char)'6', (unsigned short) maxValue,(unsigned short) minValue,(unsigned long) sizeDirVento,(unsigned long) freqDirVento, readDirVento);

        maior = highest(maior,sizeDirVento,readDirVento);
        menor = lowest(menor,sizeDirVento,readDirVento); 
        soma = average(soma,sizeDirVento,readDirVento);

        fprintf(fptr, "\n    ----------------\n");
        printf("%s", "\n    --------------\n");
    }

    // preencher com Média
     *(*(ptrMatrix + 5)+ 0) = soma/(sizeDirVento * numSensDirVento);

    // preencher com Max
     *(*(ptrMatrix + 5)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 5)+ 2) = menor;
}


//---------------------------------------------------------------------------------------------------------------------------------


// US111 ---------------------------------------------------------------------------

void addSensor(int newNSensores, Sensor *sensores) {

    sensores = realloc(sensores, newNSensores * sizeof(Sensor));
    
    if(sensores == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }
}

void removeSensor(int newNSensores,Sensor *sensores) {

    sensores = realloc(sensores, newNSensores * sizeof(Sensor));
    
    if(sensores == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }
}

//---------------------------------------------------------------------------------

int main(void){

    // USER INPUT ------------------------------------------------------

    printf("=========================================================================\n\n");

    // NUMERO POR TIPO DE SENSOR ------------------------------------------------------
    printf("Número de sensores de temperatura: ");
    scanf("%d", &numSensTemp);
    printf("\n");

    printf("Número de sensores de velocidade do vento: ");
    scanf("%d", &numSensVento);
    printf("\n");

    printf("Número de sensores de pluviosidade: ");
    scanf("%d", &numSensPluvio);
    printf("\n");

    printf("Número de sensores de humidade atmosférica: ");
    scanf("%d", &numSensAtm);
    printf("\n");

    printf("Número de sensores de humidade do solo: ");
    scanf("%d", &numSensSoil);
    printf("\n");

    printf("Número de sensores de direção do vento: ");
    scanf("%d", &numSensDirVento);
    printf("\n");

    // INTERVALO DE ERRO --------------------------------------------------------------
    printf("Introduz o número máximo de leituras consecutivas erradas: ");
    scanf(" %i", &maxErrorCount);

    maxValue = 400;
    minValue = -100;
    errorCount = 0;

    // FREQUENCIA POR TIPO DE SENSOR ----------------------------------------------------
    printf("\nFrequência de leitura do sensor de temperatura (em segundos):");
    scanf("%e", &freqTemperatura);

    printf("\nFrequência de leitura do sensor de velocidade do vento (em segundos):");
    scanf("%e", &freqVelVento);
    
    printf("\nFrequência de leitura do sensor de pluviosidade (em segundos):");
    scanf("%e", &freqPluvio);

    printf("\nFrequência de leitura do sensor de humidade atmosférica(em segundos):");
    scanf("%e", &freqHumidadeAtm);

    printf("\nFrequência de leitura do sensor de humidade do solo(em segundos):");
    scanf("%e", &freqHumidadeSolo);

    printf("\nFrequência de leitura do sensor de direção do vento (em segundos):");
    scanf("%e", &freqDirVento);

    // END OF USER INPUT -------------------------------------------------
    printf("\n=========================================================================\n\n");


    // ------------------------- US103 ------------------------------------------
    // Criação Matriz Estática------------------------------------------------
    short matrix[6][3]; // 6 tipos de sensores, 3 colunas = average, max, min
    short (*ptrMatrix)[3] = matrix;

    // ------------------------- US110 ------------------------------------------

    // ----------------------------- DYNAMIC MEMORY --------------------------------------------
    // Sensor Temperatura
    sensoresTemperatura = (Sensor*) calloc(numSensTemp, sizeof(Sensor));
    if(sensoresTemperatura == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }
    // Sensor Velocidade do Vento
    sensoresVelVento = ( Sensor *) calloc (numSensVento, sizeof(Sensor));
    if(sensoresVelVento == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }

    // Sensor Pluviosidade
    sensoresPluviosidade = ( Sensor *) calloc (numSensPluvio, sizeof(Sensor));
    if(sensoresPluviosidade == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }

    // Sensor Humidade Atmosférica
    sensoresHumidadeAtm = ( Sensor *) calloc (numSensAtm, sizeof(Sensor));
    if(sensoresHumidadeAtm == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }

    // Sensor Humidade do Solo
    sensoresHumidadeSolo = (Sensor *) calloc (numSensSoil, sizeof(Sensor));
    if(sensoresHumidadeSolo == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    }

    // Sensor Direção do Vento
    sensoresDirVento = ( Sensor *) calloc(numSensDirVento, sizeof(Sensor)); 
    if(sensoresDirVento == NULL ){
        printf (" Error reserving memory .\n " ); exit (1);
    } 

    // ----------------------------- END FILLING DYNAMIC MEMORY ---------------------------------

    // ------------------------- US112 ------------------------------------------
    fptr = fopen("sensor_data.csv", "w");
    if (fptr == NULL){
        // Error handling
        printf("Error opening file!\n");
        return 1;
    }

    // Write the sensor data to the CSV file - US112
    fptrM = fopen("daily_matrix.csv", "w");
    if (fptrM == NULL){
        // Error handling
        printf("Error opening file!\n");
        return 1;
    }

    //------------------------- READINGS SIZE FOR FREQUENCY----------------------
    
    sizeTemperatura = readingsperDay(freqTemperatura);
    unsigned short readingsTemp[sizeTemperatura];
    readTemperatura = readingsTemp;

    sizeVento = readingsperDay(freqVelVento);
    unsigned short readingsVento[sizeVento];
    readVento = readingsVento;

    sizePluviosidade = readingsperDay(freqPluvio);
    unsigned short readingsPluviosidade[sizePluviosidade];
    readPluviosidade= readingsPluviosidade;

    sizeHumidadeAtm = readingsperDay(freqHumidadeAtm);
    unsigned short readingsHumidadeAtm[sizeHumidadeAtm];
    readHumidadeAtm = readingsHumidadeAtm;

    sizeHumidadeSolo = readingsperDay(freqHumidadeSolo);
    unsigned short readingsHumidadeSolo[sizeHumidadeSolo];
    readHumidadeSolo = readingsHumidadeSolo;

    sizeDirVento = readingsperDay(freqDirVento);
    unsigned short readingsDirVento[sizeDirVento];
    readDirVento = readingsDirVento;


// ============================== DESORGANIZADO/CAOS ===================================================================

    soma = 0; // soma = soma do numero de leituras dos vários sensores do mesmo tipo
    
// TEMPERATURA ------------------------------------------------------------------------

    fprintf(fptr, "***********Leitura Sensores***********\n\n");

    readSensoresTemperatura(ptrMatrix);

    // preencher com Média
     *(*(ptrMatrix + 0)+ 0) = soma/(sizeTemperatura * numSensTemp);

    // preencher com Max
     *(*(ptrMatrix + 0)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 0)+ 2) = menor;

     printf("Temperatura média: %d °C\n",*(*(ptrMatrix + 0)+ 0));
     printf("Maior temperatura: %d °C\n", *(*(ptrMatrix + 0)+ 1));
     printf("Menor temperatura: %d °C\n\n\n", *(*(ptrMatrix + 0)+ 2));

// VELOCIDADE DO VENTO ------------------------------------------------------------------------

    readSensoresVelVento(ptrMatrix);
    
    // preencher com Média
     *(*(ptrMatrix + 1)+ 0) = soma/(sizeVento * numSensVento);

    // preencher com Max
     *(*(ptrMatrix + 1)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 1)+ 2) = menor;

    printf("Velocidade média do vento: %d km/h\n",*(*(ptrMatrix + 1)+ 0));
    fprintf(fptrM,"Velocidade média do vento: %d km/h\n", *(*(ptrMatrix + 1)+ 0));

    printf("Maior velocidade do vento: %d km/h\n", *(*(ptrMatrix + 1)+ 1));
    fprintf(fptrM,"Maior velocidade do vento: %d km/h \n", *(*(ptrMatrix + 1)+ 1));

    printf("Menor velocidade do vento: %d km/h\n\n\n", *(*(ptrMatrix + 1)+ 2));
    fprintf(fptrM,"Menor velocidade do vento: %d km/h\n\n", *(*(ptrMatrix + 1)+ 2));

 // PLUVIOSIDADE ------------------------------------------------------------------------

    readSensoresPluviosidade(ptrMatrix);

    // preencher com Média
     *(*(ptrMatrix + 2)+ 0) = (soma/(sizePluviosidade * numSensPluvio));

    // preencher com Max
     *(*(ptrMatrix + 2)+ 1) =  maior;

    // preencher com Min
     *(*(ptrMatrix + 2)+ 2) =  menor;

    printf("Pluviosidade média: %d mm\n",*(*(ptrMatrix + 2)+ 0));
    fprintf(fptrM,"Pluviosidade média: %d mm\n", *(*(ptrMatrix + 2)+ 0));

    printf("Maior pluviosidade: %d mm\n", *(*(ptrMatrix + 2)+ 1));
    fprintf(fptrM,"Maior pluviosidade: %d mm \n", *(*(ptrMatrix + 2)+ 1));

    printf("Menor pluviosidade: %d mm\n\n\n", *(*(ptrMatrix + 2)+ 2));
    fprintf(fptrM,"Menor pluviosidade: %d mm\n\n", *(*(ptrMatrix + 2)+ 2));

 // HUMIDADE ATMOSFERICA ----------------------------------------------------------------------------------
    
    readSensoresHumidadeAtmosferica(ptrMatrix);

    // preencher com Média
     *(*(ptrMatrix + 3)+ 0) = soma/(sizeHumidadeAtm * numSensAtm);

    // preencher com Max
     *(*(ptrMatrix + 3)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 3)+ 2) = menor;

    printf("Humidade atmosférica média: %d %%\n",*(*(ptrMatrix + 3)+ 0));
    fprintf(fptrM,"Humidade atmosférica média: %d %%\n", *(*(ptrMatrix + 3)+ 0));

    printf("Maior humidade atmosférica: %d %%\n", *(*(ptrMatrix + 3)+ 1));
    fprintf(fptrM,"Maior humidade atmosférica: %d %% \n", *(*(ptrMatrix + 3)+ 1));

    printf("Menor humidade atmosférica: %d %%\n\n\n", *(*(ptrMatrix + 3)+ 2));
    fprintf(fptrM,"Menor humidade atmosférica: %d %%\n\n", *(*(ptrMatrix + 3)+ 2));

// HUMIDADE SOLO ----------------------------------------------------------

    readSensoresHumidadeSolo(ptrMatrix);

    // preencher com Média
     *(*(ptrMatrix + 4)+ 0) = soma/(sizeHumidadeSolo * numSensSoil);

    // preencher com Max
     *(*(ptrMatrix + 4)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 4)+ 2) = menor;

    printf("Humidade média do solo: %d %%\n",*(*(ptrMatrix + 4)+ 0));
    fprintf(fptrM,"Humidade média do solo: %d %%\n", *(*(ptrMatrix + 4)+ 0));

    printf("Maior humidade do solo: %d %%\n", *(*(ptrMatrix + 4)+ 1));
    fprintf(fptrM,"Maior humidade do solo: %d %% \n", *(*(ptrMatrix + 4)+ 1));

    printf("Menor humidade do solo: %d %%\n\n\n", *(*(ptrMatrix + 4)+ 2));
    fprintf(fptrM,"Menor humidade do solo: %d %%\n\n", *(*(ptrMatrix + 4)+ 2));

// DIREÇAO VENTO ----------------------------------------------------------------------------    

    readSensoresDirecaoVento(ptrMatrix);
    
    // preencher com Média
     *(*(ptrMatrix + 5)+ 0) = soma/(sizeDirVento * numSensDirVento);

    // preencher com Max
     *(*(ptrMatrix + 5)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 5)+ 2) = menor;

    printf("Direção média do vento: %d °\n",*(*(ptrMatrix + 5)+ 0));
    fprintf(fptrM,"Direção média do vento: %d °\n", *(*(ptrMatrix + 5)+ 0));

    printf("Maior direção do vento: %d °\n", *(*(ptrMatrix + 5)+ 1));
    fprintf(fptrM,"Maior direção do vento: %d °\n", *(*(ptrMatrix + 5)+ 1));

    printf("Menor direção do vento: %d °\n\n\n", *(*(ptrMatrix + 5)+ 2));
    fprintf(fptrM,"Menor direção do vento: %d °\n\n", *(*(ptrMatrix + 5)+ 2));


    printf("\n===========================================================================\n\n");

    printf("\n\n");
    fclose(fptr);

// ---------------------------- REALOCAÇÃO DE MEMORIA ------------------------------------------------
    //-------------------------------US 111---------------------------------------------------------------
    printf("Número de sensores de temperatura atual: %d.\n", numSensTemp);
    printf("Deseja acrescentar, remover ou manter? (a/r/m): ");
    scanf(" %c", &answerSensTemp);
    change = 0;

    if(answerSensTemp == 'a'){

        printf("\nQuantos? \n");
        scanf(" %d", &change);

        numSensTemp += change;
        addSensor(numSensTemp,sensoresTemperatura);

    } else if(answerSensTemp == 'r'){

        printf("\nQuantos? \n");
        scanf(" %d", &change);
        
        numSensTemp -= change;
        removeSensor(numSensTemp,sensoresTemperatura);
    }

    printf("\n\nDeseja alterar a frequência dos sensores de temperatura? (s/n): ");
    scanf(" %c", &answerSensTemp);
    printf("\n");

    change = 0;

    if(answerSensTemp == 's'){

        printf("\nQual a nova frequência? \n");
        scanf(" %e", &freqTemperatura);
        printf("\n");

        sizeTemperatura = readingsperDay(freqTemperatura);
        unsigned short readingsTemp[sizeTemperatura];
        readTemperatura = readingsTemp;

    }

    readSensoresTemperatura(ptrMatrix);

    // preencher com Média
     *(*(ptrMatrix + 0)+ 0) = soma/(sizeTemperatura * numSensTemp);

    // preencher com Max
     *(*(ptrMatrix + 0)+ 1) = maior;

    // preencher com Min
     *(*(ptrMatrix + 0)+ 2) = menor;

    fprintf(fptrM,"\n\n************Matriz Diária************\n");

    printf("Temperatura média: %d °C\n",*(*(ptrMatrix + 0)+ 0));
    fprintf(fptrM,"Temperatura média: %d °C\n", *(*(ptrMatrix + 0)+ 0));

    printf("Maior temperatura: %d °C\n", *(*(ptrMatrix + 0)+ 1));
    fprintf(fptrM,"Maior temperatura: %d °C \n", *(*(ptrMatrix + 0)+ 1));

    printf("Menor temperatura: %d °C\n\n\n", *(*(ptrMatrix + 0)+ 2));
    fprintf(fptrM,"Menor temperatura: %d °C\n\n", *(*(ptrMatrix + 0)+ 2));


    printf("================================================================\n");


//------- FREE MEMORY ALLOCATION ---------- 

    free(sensoresTemperatura);
    free(sensoresTemperatura);
    free(sensoresVelVento);
    free(sensoresPluviosidade);
    free(sensoresHumidadeAtm);
    free(sensoresHumidadeSolo);
    free(sensoresDirVento);
    
    return 0;
}


