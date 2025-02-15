-- US216 – Como Gestor Agrícola, pretendo incluir no meu sistema de análise de produção e vendas,
-- também a dimensão local de recolha (hub). Esta dimensão tem uma hierarquia de agregação com
-- dois níveis: tipo de hub, hub. O tipo de hub é dado pela letra do seu código ClientesProdutores.

-- Critério de Aceitação [BDDAD]

-- 1. Foi adicionada a tabela para a nova dimensão e está devidamente estruturada

-- 2.. As tabelas de factos integram corretamente a dimensão Local de recolha.

-- 3. Um script SQL para carregar o esquema Star/Snowflake com dados suficientes para suportar
-- uma prova de conceito está disponível e é executado sem erros.

-- 4. Um script SQL para consultar o data warehouse e suportar uma prova de conceito está disponível e é
-- executado sem erros. Este script responde as seguintes perguntas:
-- a) Analisar a evolução das vendas mensais por tipo de cultura e hub?
