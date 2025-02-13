CREATE TABLE Auditoria (
  audit_id                    number(10) GENERATED AS IDENTITY,
  user_name                   varchar2(50) NOT NULL,
  data                        varchar2(50) NOT NULL,
  comando                     varchar2(50),
  OperacaoAgricolaid_operacao number(10) NOT NULL,
  PRIMARY KEY (audit_id));
CREATE TABLE CadernoCampo (
  cod_plano_rega number(10) GENERATED AS IDENTITY,
  data           date NOT NULL,
  PRIMARY KEY (cod_plano_rega));
CREATE TABLE Categoria (
  cod_categora number(10) GENERATED AS IDENTITY,
  categoria    varchar2(50) NOT NULL,
  PRIMARY KEY (cod_categora));
CREATE TABLE Cliente (
  codigo_interno            number(10) GENERATED AS IDENTITY,
  nome                      varchar2(150) NOT NULL,
  telefone                  number(10) NOT NULL UNIQUE,
  email                     varchar2(10) NOT NULL UNIQUE,
  nif                       number(10) NOT NULL UNIQUE,
  plafond                   number(10) NOT NULL,
  numero_encomendas_anual   number(10) NOT NULL,
  valor_encomendas_anual    number(10) NOT NULL,
  data_ultimo_incidente     date NOT NULL,
  id_morada_entrega         number(10) NOT NULL,
  id_morada_correspondencia number(10) NOT NULL,
  Hubloc_id                 varchar2(6),
  PRIMARY KEY (codigo_interno));
CREATE TABLE Colheita (
  cod_colheita                      number(10) GENERATED AS IDENTITY,
  quantidade_colheita               number(15) NOT NULL,
  data_colheita                     varchar2(50) NOT NULL,
  CadernoCampocod_plano_rega        number(10) NOT NULL,
  Parcela_Culturaid_parcela_cultura number(10) NOT NULL,
  PRIMARY KEY (cod_colheita));
CREATE TABLE Cultura (
  cod_cultura     number(10) GENERATED AS IDENTITY,
  tipo_de_cultura varchar2(150) NOT NULL,
  cultura         varchar2(150) NOT NULL UNIQUE,
  preco_cultura   number(10) NOT NULL,
  PRIMARY KEY (cod_cultura));
CREATE TABLE Elemento (
  cod_elemento          number(10) GENERATED AS IDENTITY,
  substancia            varchar2(50) NOT NULL,
  unidade               varchar2(10) NOT NULL,
  Categoriacod_categora number(10) NOT NULL,
  PRIMARY KEY (cod_elemento));
CREATE TABLE Encomenda (
  num_encomenda     number(10) GENERATED AS IDENTITY,
  registo_encomenda date NOT NULL,
  estado            varchar2(50) NOT NULL,
  data_vencimento   date NOT NULL,
  valor_total       number(10),
  data_pagamento    number(10),
  id_cliente        number(10) NOT NULL,
  Hubloc_id         varchar2(6) NOT NULL,
  PRIMARY KEY (num_encomenda));
CREATE TABLE Entrega (
  id_entrega     number(10) GENERATED AS IDENTITY,
  data           date NOT NULL,
  estado_entrega varchar2(150) NOT NULL,
  num_encomenda  number(10) NOT NULL,
  id_morada      number(10) NOT NULL,
  PRIMARY KEY (id_entrega));
CREATE TABLE FatorDeProducao (
  cod_fator_prod                number(10) GENERATED AS IDENTITY,
  nome_comercial                varchar2(50) NOT NULL,
  formulacao                    varchar2(150) NOT NULL,
  custo                         number(10),
  FichaTecnicacod_ficha_tecnica number(10) NOT NULL,
  PRIMARY KEY (cod_fator_prod));
CREATE TABLE FichaTecnica (
  cod_ficha_tecnica number(10) GENERATED AS IDENTITY,
  tipo_fator        varchar2(50) NOT NULL,
  fornecedor        varchar2(150) NOT NULL,
  PRIMARY KEY (cod_ficha_tecnica));
CREATE TABLE FichaTecnica_Elemento (
  cod_ficha_tecnica   number(10) NOT NULL,
  cod_elemento        number(10) NOT NULL,
  quantidade_elemento number(10),
  PRIMARY KEY (cod_ficha_tecnica,
  cod_elemento));
CREATE TABLE Hub (
  loc_id     varchar2(6) NOT NULL,
  latitude   number(10) NOT NULL,
  longitude  number(10) NOT NULL,
  codigo_hub number(10) NOT NULL,
  PRIMARY KEY (loc_id));
CREATE TABLE Incidente (
  id_incidente    number(10) GENERATED AS IDENTITY,
  valor           number(10) NOT NULL,
  data_ocorrencia date NOT NULL,
  data_correcao   varchar2(10) NOT NULL,
  num_encomenda   number(10) NOT NULL,
  PRIMARY KEY (id_incidente));
CREATE TABLE Leitura (
  id_leitura       number(15) GENERATED AS IDENTITY,
  valor            number(10) NOT NULL,
  instante_leitura date NOT NULL,
  Sensorid_sensor  number(10) NOT NULL,
  PRIMARY KEY (id_leitura));
CREATE TABLE Morada (
  id_morada     number(10) GENERATED AS IDENTITY,
  codigo_postal varchar2(210) NOT NULL,
  rua           varchar2(210) NOT NULL,
  numero        number(10) NOT NULL,
  data_entrega  date,
  PRIMARY KEY (id_morada));
CREATE TABLE OperacaoAgricola (
  id_operacao                          number(10) GENERATED AS IDENTITY,
  data_planeada                        date NOT NULL,
  data_execucao                        date,
  estado                               varchar2(50),
  TipoOperacaoAgricolaid_tipo_operacao number(10) NOT NULL,
  Parcela_Culturaid_parcela_cultura    number(10) NOT NULL,
  PRIMARY KEY (id_operacao));
CREATE TABLE OperacaoAgricola_FatorDeProducao (
  id_op_fator_prod                number(10) GENERATED AS IDENTITY,
  quantidade_aplicada             number(10) NOT NULL,
  id_operacao                     number(10) NOT NULL,
  cod_fator_prod                  number(10) NOT NULL,
  Tipo_Aplicacaoid_tipo_aplicacao number(10) NOT NULL,
  PRIMARY KEY (id_op_fator_prod));
CREATE TABLE Parcela (
  cod_parcela     number(10) GENERATED AS IDENTITY,
  area            number(10) NOT NULL,
  designacao      varchar2(250) NOT NULL,
  zona_geografica varchar2(250) NOT NULL,
  PRIMARY KEY (cod_parcela));
CREATE TABLE Parcela_Cultura (
  id_parcela_cultura number(10) GENERATED AS IDENTITY,
  data_inicio        date,
  data_fim           date,
  Culturacod_cultura number(10) NOT NULL,
  Parcelacod_parcela number(10) NOT NULL,
  PRIMARY KEY (id_parcela_cultura));
CREATE TABLE Parcela_FatorDeProducao (
  cod_parcela    number(10) NOT NULL,
  cod_fator_prod number(10) NOT NULL,
  PRIMARY KEY (cod_parcela,
  cod_fator_prod));
CREATE TABLE Plano_Rega (
  cod_stm_rega               number(10) GENERATED AS IDENTITY,
  quantidade_agua            number(10) NOT NULL,
  tipo_de_rega               varchar2(50) NOT NULL,
  distribuicao               varchar2(50) NOT NULL,
  data_realizacao            date,
  data_inicio_plano          number(10),
  data_fim_plano             number(10),
  CadernoCampocod_plano_rega number(10) NOT NULL,
  PRIMARY KEY (cod_stm_rega));
CREATE TABLE Produto (
  id_produto           number(10) GENERATED AS IDENTITY,
  nome_produto         number(10),
  quantidade_produto   number(10),
  preço_produto        number(10),
  Colheitacod_colheita number(10) NOT NULL,
  PRIMARY KEY (id_produto));
CREATE TABLE Produto_Encomenda (
  Produtoid_produto      number(10) NOT NULL,
  Encomendanum_encomenda number(10) NOT NULL,
  qtd_venda              number(10),
  PRIMARY KEY (Produtoid_produto,
  Encomendanum_encomenda));
CREATE TABLE Rega_por_Parcela (
  cod_plano_rega             number(10) GENERATED AS IDENTITY,
  tempo_rega                 number(10) NOT NULL,
  periocidade                number(10) NOT NULL,
  Parcelacod_parcela         number(10) NOT NULL,
  CadernoCampocod_plano_rega number(10) NOT NULL,
  PRIMARY KEY (cod_plano_rega));
CREATE TABLE RestricaoFatorProducao (
  id_restricao                  number(10) GENERATED AS IDENTITY,
  data_inicio                   date,
  data_fim                      date,
  zona_geografica               varchar2(150),
  FatorDeProducaocod_fator_prod number(10) NOT NULL,
  PRIMARY KEY (id_restricao));
CREATE TABLE Sensor (
  id_sensor                number(10) GENERATED AS IDENTITY,
  valor_referencia         number(10) NOT NULL UNIQUE,
  Parcelacod_parcela       number(10) NOT NULL,
  TipoSensorid_tipo_sensor number(10) NOT NULL,
  Plano_Regacod_stm_rega   number(10) NOT NULL,
  PRIMARY KEY (id_sensor));
CREATE TABLE Tipo_Aplicacao (
  id_tipo_aplicacao number(10) GENERATED AS IDENTITY,
  tipo_aplicacao    varchar2(50) NOT NULL,
  designacao        varchar2(250) NOT NULL,
  PRIMARY KEY (id_tipo_aplicacao));
CREATE TABLE TipoOperacaoAgricola (
  id_tipo_operacao number(10) GENERATED AS IDENTITY,
  tipo_operacao    varchar2(50) NOT NULL,
  designacao       varchar2(50) NOT NULL,
  PRIMARY KEY (id_tipo_operacao));
CREATE TABLE TipoSensor (
  id_tipo_sensor number(10) GENERATED AS IDENTITY,
  tipo_sensor    number(10),
  PRIMARY KEY (id_tipo_sensor));
ALTER TABLE Parcela_Cultura ADD CONSTRAINT FKParcela_Cu152855 FOREIGN KEY (Parcelacod_parcela) REFERENCES Parcela (cod_parcela);
ALTER TABLE Parcela_Cultura ADD CONSTRAINT FKParcela_Cu543988 FOREIGN KEY (Culturacod_cultura) REFERENCES Cultura (cod_cultura);
ALTER TABLE Parcela_FatorDeProducao ADD CONSTRAINT FKParcela_Fa649898 FOREIGN KEY (cod_parcela) REFERENCES Parcela (cod_parcela);
ALTER TABLE Parcela_FatorDeProducao ADD CONSTRAINT FKParcela_Fa20274 FOREIGN KEY (cod_fator_prod) REFERENCES FatorDeProducao (cod_fator_prod);
ALTER TABLE Rega_por_Parcela ADD CONSTRAINT FKRega_por_P663939 FOREIGN KEY (Parcelacod_parcela) REFERENCES Parcela (cod_parcela);
ALTER TABLE Entrega ADD CONSTRAINT FKEntrega281427 FOREIGN KEY (num_encomenda) REFERENCES Encomenda (num_encomenda);
ALTER TABLE Encomenda ADD CONSTRAINT FKEncomenda651155 FOREIGN KEY (id_cliente) REFERENCES Cliente (codigo_interno);
ALTER TABLE FatorDeProducao ADD CONSTRAINT FKFatorDePro868567 FOREIGN KEY (FichaTecnicacod_ficha_tecnica) REFERENCES FichaTecnica (cod_ficha_tecnica);
ALTER TABLE Entrega ADD CONSTRAINT FKEntrega127448 FOREIGN KEY (id_morada) REFERENCES Morada (id_morada);
ALTER TABLE Incidente ADD CONSTRAINT FKIncidente855851 FOREIGN KEY (num_encomenda) REFERENCES Encomenda (num_encomenda);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente287721 FOREIGN KEY (id_morada_entrega) REFERENCES Morada (id_morada);
ALTER TABLE Produto_Encomenda ADD CONSTRAINT FKProduto_En96050 FOREIGN KEY (Produtoid_produto) REFERENCES Produto (id_produto);
ALTER TABLE FichaTecnica_Elemento ADD CONSTRAINT FKFichaTecni43548 FOREIGN KEY (cod_ficha_tecnica) REFERENCES FichaTecnica (cod_ficha_tecnica);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente392703 FOREIGN KEY (id_morada_correspondencia) REFERENCES Morada (id_morada);
ALTER TABLE FichaTecnica_Elemento ADD CONSTRAINT FKFichaTecni728765 FOREIGN KEY (cod_elemento) REFERENCES Elemento (cod_elemento);
ALTER TABLE Colheita ADD CONSTRAINT FKColheita187659 FOREIGN KEY (CadernoCampocod_plano_rega) REFERENCES CadernoCampo (cod_plano_rega);
ALTER TABLE Rega_por_Parcela ADD CONSTRAINT FKRega_por_P843893 FOREIGN KEY (CadernoCampocod_plano_rega) REFERENCES CadernoCampo (cod_plano_rega);
ALTER TABLE Sensor ADD CONSTRAINT FKSensor276527 FOREIGN KEY (TipoSensorid_tipo_sensor) REFERENCES TipoSensor (id_tipo_sensor);
ALTER TABLE Produto_Encomenda ADD CONSTRAINT FKProduto_En88166 FOREIGN KEY (Encomendanum_encomenda) REFERENCES Encomenda (num_encomenda);
ALTER TABLE Elemento ADD CONSTRAINT FKElemento568746 FOREIGN KEY (Categoriacod_categora) REFERENCES Categoria (cod_categora);
ALTER TABLE Plano_Rega ADD CONSTRAINT FKPlano_Rega748792 FOREIGN KEY (CadernoCampocod_plano_rega) REFERENCES CadernoCampo (cod_plano_rega);
ALTER TABLE Produto ADD CONSTRAINT FKProduto440113 FOREIGN KEY (Colheitacod_colheita) REFERENCES Colheita (cod_colheita);
ALTER TABLE Sensor ADD CONSTRAINT FKSensor260940 FOREIGN KEY (Parcelacod_parcela) REFERENCES Parcela (cod_parcela);
ALTER TABLE Sensor ADD CONSTRAINT FKSensor273052 FOREIGN KEY (Plano_Regacod_stm_rega) REFERENCES Plano_Rega (cod_stm_rega);
ALTER TABLE OperacaoAgricola ADD CONSTRAINT FKOperacaoAg910885 FOREIGN KEY (TipoOperacaoAgricolaid_tipo_operacao) REFERENCES TipoOperacaoAgricola (id_tipo_operacao);
ALTER TABLE Colheita ADD CONSTRAINT FKColheita62952 FOREIGN KEY (Parcela_Culturaid_parcela_cultura) REFERENCES Parcela_Cultura (id_parcela_cultura);
ALTER TABLE OperacaoAgricola ADD CONSTRAINT FKOperacaoAg72803 FOREIGN KEY (Parcela_Culturaid_parcela_cultura) REFERENCES Parcela_Cultura (id_parcela_cultura);
ALTER TABLE OperacaoAgricola_FatorDeProducao ADD CONSTRAINT FKOperacaoAg144825 FOREIGN KEY (id_operacao) REFERENCES OperacaoAgricola (id_operacao);
ALTER TABLE OperacaoAgricola_FatorDeProducao ADD CONSTRAINT FKOperacaoAg368228 FOREIGN KEY (cod_fator_prod) REFERENCES FatorDeProducao (cod_fator_prod);
ALTER TABLE OperacaoAgricola_FatorDeProducao ADD CONSTRAINT FKOperacaoAg195664 FOREIGN KEY (Tipo_Aplicacaoid_tipo_aplicacao) REFERENCES Tipo_Aplicacao (id_tipo_aplicacao);
ALTER TABLE RestricaoFatorProducao ADD CONSTRAINT FKRestricaoF355343 FOREIGN KEY (FatorDeProducaocod_fator_prod) REFERENCES FatorDeProducao (cod_fator_prod);
ALTER TABLE Encomenda ADD CONSTRAINT FKEncomenda727251 FOREIGN KEY (Hubloc_id) REFERENCES Hub (loc_id);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente925466 FOREIGN KEY (Hubloc_id) REFERENCES Hub (loc_id);
ALTER TABLE Leitura ADD CONSTRAINT FKLeitura432575 FOREIGN KEY (Sensorid_sensor) REFERENCES Sensor (id_sensor);
ALTER TABLE Auditoria ADD CONSTRAINT FKAuditoria609796 FOREIGN KEY (OperacaoAgricolaid_operacao) REFERENCES OperacaoAgricola (id_operacao);
