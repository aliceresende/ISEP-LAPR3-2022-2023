/**
 * Gera o valor de velocidade do vento com base no último valor de velocidade do vento.
 * O novo valor a gerar será o incremento ao último valor gerado, adicionado de um valor
 * aleatório (positivo ou negativo).
 *
 * A componente aleatória pode produzir variações altas entre medições consecutivas, simulando assim o efeito
 * de rajadas de vento.
 *
 * @param ult_velc_vento Última velocidade do vento medida (km/h)
 * @param comp_rand Componente aleatório para a geração do novo valor da velocidade do vento
 *
 * @return O novo medição do valor da velocidade do vento (km/h)
 */
unsigned char sens_velc_vento(unsigned char ult_velc_vento, char comp_rand);

