-- US213 – Como Gestor Agrícola, quero ter acesso a pistas de auditoria das operações agrícolas
-- planeadas ou realizadas em determinado Setor da minha exploração agrícola, ou seja, quero ter
-- acesso a uma lista de todas as alterações realizadas na bse de dados, por ordem cronológica. Para
-- cada alteração quero saber: o utilizador/login que a realizou, a data e hora em que a alteração foi
-- realizada e o tipo de alteração (INSERT, UPDATE, DELETE).

-- Critério de Aceitação [BDDAD]
-- 1. Existe uma tabela para registo de pistas de auditoria, ou seja, para o registo de todas as
-- operações de escrita na base de dados envolvendo um determinado setor da minha exploração
-- agrícola.

--  2. Os mecanismos apropriados para gravação de operações de escrita (INSERT, UPDATE,
-- DELETE) estão implementados.

-- 3. É implementado um processo de consulta de pistas de auditoria simples e eficaz. ?


CREATE TABLE Auditoria (
  audit_id                    number(10) GENERATED AS IDENTITY,
  user_name                   varchar2(50) NOT NULL,
  data_comando                varchar2(50) NOT NULL,
  comando                     varchar2(50),
  OperacaoAgricolaid_operacao number(10) NOT NULL,
  PRIMARY KEY (audit_id));

ALTER TABLE Auditoria ADD CONSTRAINT FKAuditoria609796 FOREIGN KEY (OperacaoAgricolaid_operacao) REFERENCES OperacaoAgricola (id_operacao);


DROP TABLE Auditoria;

create or replace TRIGGER auditoria_das_Operacoes
AFTER INSERT OR DELETE OR UPDATE ON OperacaoAgricola
FOR EACH ROW
DECLARE
    login varchar(50);
    data varchar(50);
BEGIN

SELECT  user, TO_CHAR(systimestamp, 'DD/MM/YYYY HH:MM') INTO login, data FROM dual;

IF INSERTING THEN
    INSERT INTO Auditoria(user_name,data_comando,comando,OperacaoAgricolaid_operacao)
    VALUES (login,data,'INSERT',:new.id_operacao);
ELSIF UPDATING THEN
    INSERT INTO Auditoria(user_name,data_comando,comando,OperacaoAgricolaid_operacao)
    VALUES (login,data,'UPDATE',:old.id_operacao);
ELSIF DELETING THEN
    INSERT INTO Auditoria(user_name,data_comando,comando,OperacaoAgricolaid_operacao)
    VALUES (login,data,'DELETE',:old.id_operacao);
END IF;
END;

-- -----------------------------------------------------------------------------








D;