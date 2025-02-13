/**
 * Gera o valor de humidade atmosférica com base no último valor de humidade atmosférica.
 * O novo valor a gerar será o incremento ao último valor gerado, adicionado de um valor
 * de modificação (positivo ou negativo).
 *
 * O valor de modificação terá uma componente aleatória e uma componente relativa ao último
 * valor de pluvisiodade registado, que contribuirá para uma maior ou menor alteração à
 * modificação.
 *
 * A menos que tenha chovido, o valor de modificação não deverá produzir variações drásticas à humidade
 * atmosférica entre medições consecutivas.
 *
 * @param ult_hmd_atm Última humidade atmosférica medida (percentagem)
 * @param ult_pluvio Último valor de pluviosidade medido (mm)
 * @param comp_rand Componente aleatório para a geração do novo valor da humidade atmosférica
 *
 * @return A nova medição do valor da humidade atmosférica (percentagem)
 */
unsigned char sens_humd_atm(unsigned char ult_hmd_atm, unsigned char ult_pluvio, char comp_rand);
