CREATE TABLE cliente (
	cod INTEGER,
	nome VARCHAR(40),
	salario REAL,
	cidade VARCHAR(50),
	
	CONSTRAINT pk_cliente PRIMARY KEY (cod)
);
--trigger
--torna processos automáticos em insert update delete
--procedure(função) <- trigger

CREATE FUNCTION cliente_trigger() RETURNS TRIGGER AS $cliente_trigger$
BEGIN
	--verificação d nome de usuário
	IF new.nome IS null THEN
		RAISE EXCEPTION
			'o nome não foi informado';
	END IF;
		
	RETURN NEW;
END;
$cliente_trigger$ LANGUAGE plpgsql;
--criação de trigger associado á tablea
CREATE TRIGGER cliente_trigger BEFORE
	INSERT OR UPDATE ON cliente
	FOR EACH ROW EXECUTE  PROCEDURE 
		cliente_trigger();
--dando insert para dar erro
INSERT INTO cliente VALUES (1, null, 2500, 'votuporanga');
--retorno:
--ERROR:  o nome não foi informado
--CONTEXT:  PL/pgSQL function cliente_trigger() line 5 at RAISE
--SQL state: P0001