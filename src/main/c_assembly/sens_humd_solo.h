/**
 * Gera o valor de humidade do solo com base no último valor de humidade do solo.
 * O novo valor a gerar será o incremento ao último valor gerado, adicionado de um valor
 * de modificação (positivo ou negativo).
 *
 * O valor de modificação terá uma componente aleatória e uma componente relativa ao último
 * valor de pluvisiodade registado, que contribuirá para uma maior ou menor alteração à
 * modificação.
 * 
 * A menos que tenha chovido, o valor de modificação não deverá produzir variações drásticas à humidade do
 * solo entre medições consecutivas.
 *
 * @param ult_hmd_solo Última humidade do solo medida (percentagem)
 * @param ult_pluvio Último valor de pluviosidade medido (mm)
 * @param comp_rand Componente aleatório para a geração do novo valor da humidade do solo
 *
 * @return A nova medição do valor da humidade do solo (percentagem)
 */
unsigned char sens_humd_solo(unsigned char ult_hmd_solo, unsigned char ult_pluvio, char comp_rand);
