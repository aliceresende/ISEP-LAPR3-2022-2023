/**
 * Gera o valor de direção do vento com base no último valor de direção do vento.
 * O novo valor a gerar será o incremento ao último valor gerado, adicionado de um valor
 * aleatório (positivo ou negativo).
 *
 * A direção do vento toma valores de 0 a 359, representam graus relativamente ao Norte.
 *
 * A direção do vento não deve variar de forma drástica entre medições consecutivas.
 *
 * @param ult_dir_vento Última direção do vento medida (graus)
 * @param comp_rand Componente aleatório para a geração do novo valor da direção do vento
 *
 * @return A nova medição do valor da direção do vento (graus)
 */
unsigned short sens_dir_vento(unsigned short ult_dir_vento, short comp_rand);

