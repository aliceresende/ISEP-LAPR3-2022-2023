/**
 * Gera o valor de temperatura com base no último valor de temperatura.
 * O novo valor a gerar será o incremento ao último valor gerado, adicionado de um valor
 * aleatório (positivo ou negativo).
 *
 * A componente aleatória não deverá produzir variações drásticas à temperatura entre medições consecutivas.
 *
 * @param ult_temp Último valor de temperatura medido (°C)
 * @param comp_rand Componente aleatório para a geração do novo valor da temperatura
 *
 * @return A nova medição do valor da temperatura (°C)
 */

char sens_temp(char ult_temp, char comp_rand);
