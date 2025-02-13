INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('permanente','tomates',4.20);
INSERT INTO parcela(area,designacao)VALUES(14.30,'campo');
INSERT INTO parcela_cultura(parcelacod_parcela,culturacod_cultura)VALUES(1,1);

INSERT INTO rega_por_parcela(periocidade,tempo_rega,parcelacod_parcela,CadernoCampocod_plano_rega)VALUES('diario','2 minutos',1,1);
INSERT INTO fichatecnica(fornecedor)VALUES('João Lopes');
INSERT INTO tipofatorproducao(tipo_fator_prod)VALUES('frutos');
INSERT INTO aplicaçao(tipo_aplicação)VALUES(1);
INSERT INTO fatordeproducao(nome_comercial,formulacao,fichatecnicacod_ficha_tecnica,tipofatorproducaoid_tipo,Aplicaçaoid_aplicacao)VALUES('tomate','a',1,1,1);
INSERT INTO Parcela_FatorDeProducao(Parcelacod_parcela,FatorProducaocod_fator_prod)VALUES(1,1);
INSERT INTO categoria(categoria)VALUES('Elemento organica');
INSERT INTO elemento(substancia,unidade,Categoriacod_categora)VALUES('azoto','10',1);
INSERT INTO fichatecnica_elemento(FichaTecnicacod_ficha_tecnica,Elementocod_elemento,quantidade_elemento)VALUES(1,1,30);
INSERT INTO colheita(quantidade_colheita,data_colheita,Parcela_CulturaParcelacod_parcela,Parcela_CulturaCulturacod_cultura,CadernoCampocod_plano_rega)VALUES(20,20122020,1,1,1);
INSERT INTO Plano_Rega(quantidade_agua,tipo_de_rega,distribuicao,data_realizacao,data_inicio_plano,data_fim_plano,CadernoCampocod_plano_rega)VALUES(100,'gota a gota','a',TO_DATE('21/10/2022', 'DD/MM/YYYY'),TO_DATE('20/10/2022', 'DD/MM/YYYY'),TO_DATE('20/11/2022', 'DD/MM/YYYY'),1);
INSERT INTO tiposensor(tipo_sensor)VALUES('atmosferico');
INSERT INTO sensor(valor,valor_referencia,instante_leitura,SistemaDeRegacod_stm_rega,TipoSensorid_tipo_sensor,Parcelacod_parcela)VALUES(10,1,TO_DATE('20/11/2022', 'DD/MM/YYYY'),1,1,1);
INSERT INTO Produto(nome_produto,quantidade_produto,preço_produto,Colheitacod_colheita)VALUES('Maçã',13,3,1);
INSERT INTO Produto(nome_produto,quantidade_produto,preço_produto,Colheitacod_colheita)VALUES('Pêra',12,2,1);
INSERT INTO Produto(nome_produto,quantidade_produto,preço_produto,Colheitacod_colheita)VALUES('Tomates',14,4,1);
INSERT INTO Produto(nome_produto,quantidade_produto,preço_produto,Colheitacod_colheita)VALUES('Cerejas',15,3,1);
INSERT INTO Produto(nome_produto,quantidade_produto,preço_produto,Colheitacod_colheita)VALUES('Morango',16,2,1);
INSERT INTO morada(codigo_postal,rua,numero,data_entrega)VALUES('4420-362','rua padre abadeu',99,TO_DATE('22/11/2022', 'DD/MM/YYYY'));
INSERT INTO morada(codigo_postal,rua,numero,data_entrega)VALUES('4320-322','rua das arrotinhas',12,TO_DATE('20/12/2022', 'DD/MM/YYYY'));
INSERT INTO morada(codigo_postal,rua,numero,data_entrega)VALUES('4520-332','rua da santa catarina',1,TO_DATE('05/12/2022', 'DD/MM/YYYY'));
INSERT INTO morada(codigo_postal,rua,numero,data_entrega)VALUES('4620-312','rua do amial',15,TO_DATE('12/12/2022', 'DD/MM/YYYY'));
INSERT INTO cliente(nome,nivel,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,numero_incidente,data_incidente,id_morada_entrega,id_morada_correspondencia)VALUES('Pedro Silva','A',917654321,'pSilva@gmail.com',97654321,150.2,1,100.20,1,TO_DATE('20/11/2022', 'DD/MM/YYYY'),1,2);
INSERT INTO cliente(nome,nivel,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,numero_incidente,data_incidente,id_morada_entrega,id_morada_correspondencia)VALUES('Joana Alves','A',927654321,'Joana@gmail.com',87654321,102.20,1,100.20,1,TO_DATE('15/11/2022', 'DD/MM/YYYY'),1,3);
INSERT INTO cliente(nome,nivel,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,numero_incidente,data_incidente,id_morada_entrega,id_morada_correspondencia)VALUES('Rita Lima','A',937654321,'Lima@gmail.com',77654321,110.20,1,100.20,1,TO_DATE('02/12/2022', 'DD/MM/YYYY'),1,4);
INSERT INTO cliente(nome,nivel,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,numero_incidente,data_incidente,id_morada_entrega,id_morada_correspondencia)VALUES('Pedro Soares','A',947654321,'Soares@gmail.com',67654321,130.20,1,100.20,1,TO_DATE('03/12/2022', 'DD/MM/YYYY'),1,1);
INSERT INTO cliente(nome,nivel,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,numero_incidente,data_incidente,id_morada_entrega,id_morada_correspondencia)VALUES('Antonio Andrade','A',958654321,'Aandrade@gmail.com',52345678,400.20,2,500.20,1,TO_DATE('13/12/2022', 'DD/MM/YYYY'),1,1);
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente)VALUES(TO_DATE('23/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('05/12/2022', 'DD/MM/YYYY'),60.25,TO_DATE('07/12/2022', 'DD/MM/YYYY'),1);
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente)VALUES(TO_DATE('30/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('02/12/2022', 'DD/MM/YYYY'),40.25,TO_DATE('06/12/2022', 'DD/MM/YYYY'),2);
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente)VALUES(TO_DATE('12/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('30/11/2022', 'DD/MM/YYYY'),20.75,TO_DATE('01/12/2022', 'DD/MM/YYYY'),3);
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente)VALUES(TO_DATE('03/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('22/11/2022', 'DD/MM/YYYY'),19.99,TO_DATE('30/11/2022', 'DD/MM/YYYY'),4);
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente)VALUES(TO_DATE('01/12/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('05/12/2022', 'DD/MM/YYYY'),50.05,TO_DATE('10/12/2022', 'DD/MM/YYYY'),1);
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente)VALUES(TO_DATE('02/12/2022', 'DD/MM/YYYY'),'paga',TO_DATE('19/12/2022', 'DD/MM/YYYY'),12.2,TO_DATE('20/12/2022', 'DD/MM/YYYY'),2);
INSERT INTO entrega(data,estado_entrega,num_encomenda,id_morada)VALUES(TO_DATE('01/12/2022', 'DD/MM/YYYY'),'entregue',1,1);
INSERT INTO entrega(data,estado_entrega,num_encomenda,id_morada)VALUES(TO_DATE('01/12/2022', 'DD/MM/YYYY'),'entregue',2,2);
INSERT INTO entrega(data,estado_entrega,num_encomenda,id_morada)VALUES(TO_DATE('01/12/2022', 'DD/MM/YYYY'),'entregue',3,3);
INSERT INTO entrega(data,estado_entrega,num_encomenda,id_morada)VALUES(TO_DATE('01/12/2022', 'DD/MM/YYYY'),'entregue',4,1);
INSERT INTO entrega(data,estado_entrega,num_encomenda,id_morada)VALUES(TO_DATE('01/11/2022', 'DD/MM/YYYY'),'entregue',5,2);
INSERT INTO entrega(data,estado_entrega,num_encomenda,id_morada)VALUES(TO_DATE('01/11/2020', 'DD/MM/YYYY'),'pendente',6,4);
INSERT INTO Produto_Encomenda(Produtoid_produto,Encomendanum_encomenda,qtd_venda)VALUES(1,1,5);
INSERT INTO Produto_Encomenda(Produtoid_produto,Encomendanum_encomenda,qtd_venda)VALUES(2,2,15);
INSERT INTO Produto_Encomenda(Produtoid_produto,Encomendanum_encomenda,qtd_venda)VALUES(3,3,3);
INSERT INTO Produto_Encomenda(Produtoid_produto,Encomendanum_encomenda,qtd_venda)VALUES(4,4,11);
INSERT INTO Produto_Encomenda(Produtoid_produto,Encomendanum_encomenda,qtd_venda)VALUES(5,5,7);
INSERT INTO Produto_Encomenda(Produtoid_produto,Encomendanum_encomenda,qtd_venda)VALUES(1,6,10);
INSERT INTO incidente(valor,data_ocorrencia,data_correcao,num_encomenda)VALUES(60.25,TO_DATE('05/12/2022', 'DD/MM/YYYY'),TO_DATE('07/12/2022', 'DD/MM/YYYY'),1);
INSERT INTO incidente(valor,data_ocorrencia,data_correcao,num_encomenda)VALUES(40.25,TO_DATE('02/12/2022', 'DD/MM/YYYY'),TO_DATE('06/12/2022', 'DD/MM/YYYY'),2);
INSERT INTO incidente(valor,data_ocorrencia,data_correcao,num_encomenda)VALUES(20.75,TO_DATE('30/11/2022', 'DD/MM/YYYY'),TO_DATE('01/12/2022', 'DD/MM/YYYY'),3);
INSERT INTO incidente(valor,data_ocorrencia,data_correcao,num_encomenda)VALUES(19.99,TO_DATE('22/11/2022', 'DD/MM/YYYY'),TO_DATE('30/11/2022', 'DD/MM/YYYY'),4);
INSERT INTO incidente(valor,data_ocorrencia,data_correcao,num_encomenda)VALUES(160.20,TO_DATE('05/12/2022', 'DD/MM/YYYY'),TO_DATE('10/12/2022', 'DD/MM/YYYY'),1);
INSERT INTO incidente(valor,data_ocorrencia,data_correcao,num_encomenda)VALUES(50.05,TO_DATE('19/12/2022', 'DD/MM/YYYY'),TO_DATE('20/12/2022', 'DD/MM/YYYY'),2);


----------------------------US210 Bootstrap--------------------------------------------
INSERT INTO parcela(area,designacao,zona_geografica)VALUES(14.30,'Parcela A','Alquerubim');
INSERT INTO parcela(area,designacao,zona_geografica)VALUES(30,'Parcela B','Ovar');
INSERT INTO parcela(area,designacao,zona_geografica)VALUES(15.5,'Parcela C','Ovar');
INSERT INTO parcela(area,designacao,zona_geografica)VALUES(17,'Parcela D','Alquerubim');
INSERT INTO parcela(area,designacao,zona_geografica)VALUES(14,'Parcela E','Ovar');
INSERT INTO fichatecnica(tipo_fator,fornecedor)VALUES('fertilizante','João L.');
INSERT INTO fichatecnica(tipo_fator,fornecedor)VALUES('adubo','Rita Silva');
INSERT INTO fichatecnica(tipo_fator,fornecedor)VALUES('fitofármico','Manuel P.');
INSERT INTO fatordeproducao(nome_comercial,formulacao,custo,fichatecnicacod_ficha_tecnica)VALUES('Fertilizante composto','granulado',15,1);
INSERT INTO fatordeproducao(nome_comercial,formulacao,custo,fichatecnicacod_ficha_tecnica)VALUES('Adubo orgânico','pó',12,2);
INSERT INTO fatordeproducao(nome_comercial,formulacao,custo,fichatecnicacod_ficha_tecnica)VALUES('Herbicida','líquido',11,3);
INSERT INTO fatordeproducao(nome_comercial,formulacao,custo,fichatecnicacod_ficha_tecnica)VALUES('Adubo químico','líquido',10,2);
INSERT INTO fatordeproducao(nome_comercial,formulacao,custo,fichatecnicacod_ficha_tecnica)VALUES('Insecticida','líquido',9.5,3);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(1,1);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(1,2);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(2,1);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(2,3);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(2,4);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(3,4);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(3,3);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(3,5);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(4,1);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(4,4);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(4,5);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(5,1);
INSERT INTO Parcela_FatorDeProducao(cod_parcela,cod_fator_prod)VALUES(5,5);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('permanente','macieira',15.5);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('temporária','milho',5.5);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('temporária','feijoeira',3);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('temporária','alface',4.5);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('permanente','pereira',20.5);
INSERT INTO parcela_cultura(data_inicio,data_fim,parcelacod_parcela,culturacod_cultura)VALUES('2022-09-10','2022-12-12',1,3);
INSERT INTO parcela_cultura(data_inicio,data_fim,parcelacod_parcela,culturacod_cultura)VALUES('2022-07-10','2022-09-12',2,2);
INSERT INTO parcela_cultura(data_inicio,data_fim,parcelacod_parcela,culturacod_cultura)VALUES('2022-11-11','2022-12-11',3,4);
INSERT INTO parcela_cultura(parcelacod_parcela,culturacod_cultura)VALUES(4,1);
INSERT INTO parcela_cultura(parcelacod_parcela,culturacod_cultura)VALUES(4,5);
INSERT INTO parcela_cultura(parcelacod_parcela,culturacod_cultura)VALUES(5,1);
INSERT INTO parcela_cultura(parcelacod_parcela,culturacod_cultura)VALUES(5,5);
INSERT INTO TipoOperacaoAgricola(tipo_operacao,designacao)VALUES('irrigacao','rega artificial de terras');
INSERT INTO TipoOperacaoAgricola(tipo_operacao,designacao)VALUES('adubação','efeito de adubar');
INSERT INTO TipoOperacaoAgricola(tipo_operacao,designacao)VALUES('aplicação fator de produção','composto por capital, terra, trabalho');
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-09-21','2022-09-21',1,3);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-10-01','2022-10-01',1,2);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-11-20','2022-09-20',2,1);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-07-20','2022-07-25',2,3);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-08-02','2022-08-02',3,1);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-12-05','2022-12-05',1,4);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-09-20','2022-09-20',3,5);
INSERT INTO OperacaoAgricola(data_planeada,data_execucao,TipoOperacaoAgricolaid_tipo_operacao, Parcela_CulturaId_Parcela_Cultura)VALUES('2022-09-20','2022-09-20',2,4);
INSERT INTO Tipo_Aplicacao(tipo_aplicacao,designacao)VALUES('foliar','nas folhas');
INSERT INTO Tipo_Aplicacao(tipo_aplicacao,designacao)VALUES('fertirrega','técnica de adubação');
INSERT INTO Tipo_Aplicacao(tipo_aplicacao,designacao)VALUES('solo','aplicação no solo');
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2020-09-12','2023-01-15','Ovar',1);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-09-12','2022-09-13','Ovar',1);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-07-10','2022-07-10','Alquerubim',2);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-12-31','2023-01-01','Eixo',3);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-12-30','2022-12-31','Aveiro',3);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-12-31','2022-12-31','Alquerubim',4);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2023-01-01','2023-01-02','Ovar',4);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-09-12','2022-09-13','Ovar',5);
INSERT INTO RestricaoFatorProducao(data_inicio,data_fim,zona_geografica,FatorDeProducaoCod_Fator_Prod)VALUES('2022-09-11','2022-09-12','Ovar',5);

--------------------------- US213 -----------------------------------
INSERT INTO Input_hub VALUES('CT1;40.6389;-8.6553;C1');
INSERT INTO Input_hub VALUES('CT2;38.0333;-7.8833;C2');
INSERT INTO Input_hub VALUES('CT14;38.5243;-8.8926;E1');
INSERT INTO Input_hub VALUES('CT11;39.3167;-7.4167;E2');
INSERT INTO Input_hub VALUES('CT10;39.7444;-8.8072;P3');

---------------------------------------------------------
-- CADERNOCAMPO
INSERT INTO cadernocampo(data)VALUES(TO_DATE('20/12/2020', 'DD/MM/YYYY'));
-- CATEGORIA (fator produção)
INSERT INTO categoria(categoria)VALUES('Substância Orgância');
INSERT INTO categoria(categoria)VALUES('Elemento Nutritivo Orgânico');
-- CLIENTE
INSERT INTO cliente(nome,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,data_ultimo_incidente,id_morada_entrega,id_morada_correspondencia,hub_id)VALUES('Pedro Silva',917654321,'pSilva@gmail.com',97654321,150.2,1,100.20,TO_DATE('20/11/2022', 'DD/MM/YYYY'),1,2,'CT11');
INSERT INTO cliente(nome,telefone,email,nif,plafond,numero_encomendas_anual,valor_encomendas_anual,data_ultimo_incidente,id_morada_entrega,id_morada_correspondencia,hub_id)VALUES('Joana Alves',927654321,'Joana@gmail.com',87654321,102.20,1,100.20,TO_DATE('15/11/2022', 'DD/MM/YYYY'),1,3, 'CT10');
-- COLHEITA
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente,hub_id)VALUES(TO_DATE('23/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('05/12/2022', 'DD/MM/YYYY'),60.25,TO_DATE('07/12/2022', 'DD/MM/YYYY'),3,'CT14');
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente,hub_id)VALUES(TO_DATE('23/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('05/12/2022', 'DD/MM/YYYY'),60.25,TO_DATE('07/12/2022', 'DD/MM/YYYY'),4,NULL);
--


