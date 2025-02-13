/**
 * Gera o valor de pluviosidade com base no último valor de pluviosidade.
 * O novo valor a gerar será o incremento ao último valor gerado, adicionado de um valor
 * de modificação (positivo ou negativo).
 *
 * O valor de modificação terá uma componente aleatória e uma componente relativa à última
 * temperatura registada, que contribuirá para uma maior ou menor alteração à modificação.
 *
 * Assim produz-se o efeito de, com temperaturas altas ser menos provável que chova, e com
 * temperaturas mais baixas ser mais provável que chova.
 *
 * Quando a pluviosidade anterior for nula, se o valor de modificação for negativo a
 * pluviosidade deverá permanecer nula.
 *
 * @param ult_pluvio Último valor de pluviosidade medido (mm)
 * @param ult_temp Último valor de temperatura medido (°C)
 * @param comp_rand Componente aleatório para a geração do novo valor de pluviosidade
 *
 * @return A nova medição do valor de pluviosidade (mm)
 */
unsigned char sens_pluvio(unsigned char ult_pluvio, char ult_temp, char comp_rand);

