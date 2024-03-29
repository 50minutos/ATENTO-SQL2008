USE master 

IF EXISTS(SELECT * FROM sys.databases WHERE name='ATENTO')
	DROP DATABASE ATENTO
	
CREATE DATABASE ATENTO
GO

USE ATENTO

CREATE TABLE CATEGORIA
(
	COD_CATEGORIA INT IDENTITY PRIMARY KEY, 
	DESCRICAO_CATEGORIA VARCHAR(50)
)

CREATE TABLE PRODUTO
(
	COD_PRODUTO INT IDENTITY PRIMARY KEY, 
	DESCRICAO_PRODUTO VARCHAR(50), 
	PRECO_PRODUTO DEC(9,2),
	QTD_ESTOQUE_PRODUTO INT, 
	COD_CATEGORIA INT REFERENCES CATEGORIA
)

INSERT CATEGORIA 
VALUES ('FERRAMENTAS'), 
	('MATERIAIS DE ESCRIT�RIO'), 
	('CAMA E BANHO') 

INSERT PRODUTO
VALUES ('MARTELO', 12, 100, 1), 
	('MARRETA', 19, 90, 1), 
	('GRAMPEADOR 25/5', 5, 23, 2), 
	('SERROTE', 25, 8, 1), 
	('ARCO DE SERRA', 19.54, 2, 1), 
	('BLOCO DE ANOTA��ES', 3.92, 1000, 2), 
	('TOALHA DE MESA 1,8M X 3,20M', 98.43, 12, NULL), 
	('FURADEIRA DE IMPACTO', 280.57, 9, 1), 
	('PARAFUSADEIRA', 50, 7, 1), 
	('AGENDA 2012', 0.51, 1234, 2), 
	('ALMOFADA PARA CARIMBO', 2.5, 21, 2)

SELECT *
FROM CATEGORIA

SELECT * 
FROM PRODUTO

SELECT P.*, 
	C.DESCRICAO_CATEGORIA 
FROM PRODUTO P 
INNER JOIN CATEGORIA C 
	ON P.COD_CATEGORIA = C.COD_CATEGORIA
WHERE C.DESCRICAO_CATEGORIA = 'FERRAMENTAS'

--COLUNA VIRTUAL
SELECT P.*, 
	P.QTD_ESTOQUE_PRODUTO * P.PRECO_PRODUTO AS 'VALOR_TOTAL_ESTOQUE', 
	C.DESCRICAO_CATEGORIA 
FROM PRODUTO P 
INNER JOIN CATEGORIA C 
	ON P.COD_CATEGORIA = C.COD_CATEGORIA
WHERE C.DESCRICAO_CATEGORIA = 'FERRAMENTAS'

--COUNT - QTD DE REGISTROS
SELECT COUNT(*)
FROM CATEGORIA

SELECT COUNT(*), COUNT(COD_CATEGORIA) 
FROM PRODUTO 

--SUM - SOMA DE VALORES DE UMA OU MAIS COLUNAS
SELECT SUM(QTD_ESTOQUE_PRODUTO) AS 'QTD_TOTAL_ESTOQUE', 
	SUM(QTD_ESTOQUE_PRODUTO * PRECO_PRODUTO) AS 'VALOR_TOTAL_ESTOQUE'
FROM PRODUTO

--AVG - M�DIA DE VALORES DE UMA OU MAIS COLUNAS
SELECT AVG(PRECO_PRODUTO)
FROM PRODUTO

--MIN - MENOR VALOR DE UMA OU MAIS COLUNAS
SELECT MIN(PRECO_PRODUTO)
FROM PRODUTO

--MAX - MAIOR VALOR DE UMA OU MAIS COLUNAS
SELECT MAX(PRECO_PRODUTO)
FROM PRODUTO

--ORDENACAO
SELECT *
FROM PRODUTO

SELECT *
FROM PRODUTO
ORDER BY DESCRICAO_PRODUTO

SELECT *
FROM PRODUTO
ORDER BY COD_CATEGORIA, DESCRICAO_PRODUTO

SELECT TOP 1 *
FROM PRODUTO
ORDER BY PRECO_PRODUTO

SELECT TOP 1 *
FROM PRODUTO
ORDER BY PRECO_PRODUTO DESC

SELECT TOP 1 *
FROM PRODUTO
WHERE COD_CATEGORIA = 1
ORDER BY PRECO_PRODUTO

UPDATE PRODUTO 
SET PRECO_PRODUTO = 5 
WHERE COD_PRODUTO IN (6, 11)

SELECT *
FROM PRODUTO 
ORDER BY PRECO_PRODUTO

SELECT TOP 2 *
FROM PRODUTO 
ORDER BY PRECO_PRODUTO

SELECT TOP 2 WITH TIES *
FROM PRODUTO 
ORDER BY PRECO_PRODUTO

SELECT COD_CATEGORIA FROM PRODUTO 
SELECT COD_CATEGORIA FROM PRODUTO GROUP BY COD_CATEGORIA 
SELECT MIN(PRECO_PRODUTO) FROM PRODUTO

--MENOR, MAIOR E M�DIA DE PRECO DE PRODUTO POR CATEGORIA
SELECT COD_CATEGORIA, 
	MIN(PRECO_PRODUTO), 
	MAX(PRECO_PRODUTO), 
	AVG(PRECO_PRODUTO)
FROM PRODUTO
GROUP BY COD_CATEGORIA

SELECT ISNULL(DESCRICAO_CATEGORIA, 'SEM CATEGORIA') AS 'CATEGORIA', 
	MIN(PRECO_PRODUTO) AS 'MIN_PRECO_PRODUTO', 
	MAX(PRECO_PRODUTO) AS 'MAX_PRECO_PRODUTO', 
	AVG(PRECO_PRODUTO) AS 'AVG_PRECO_PRODUTO'
FROM PRODUTO P 
LEFT JOIN CATEGORIA C 
	ON P.COD_CATEGORIA = C.COD_CATEGORIA
GROUP BY DESCRICAO_CATEGORIA

CREATE TABLE UF
(
	SIGLA_UF CHAR(2) PRIMARY KEY, 
	NOME_UF VARCHAR(30)
)

CREATE TABLE CIDADE
(
	COD_CIDADE INT IDENTITY PRIMARY KEY, 
	NOME_CIDADE VARCHAR(50),
	SIGLA_UF CHAR(2) REFERENCES UF
)

CREATE TABLE CLIENTE
(
	COD_CLIENTE INT IDENTITY PRIMARY KEY, 
	NOME_CLIENTE VARCHAR(50),
	COD_CIDADE INT REFERENCES CIDADE 
)

--DROP TABLE PEDIDO

CREATE TABLE PEDIDO
(
	COD_PEDIDO INT IDENTITY PRIMARY KEY, 
	COD_CLIENTE INT REFERENCES CLIENTE 
)

CREATE TABLE ITEM_PEDIDO
(
	COD_ITEM_PEDIDO INT IDENTITY PRIMARY KEY, 
	COD_PRODUTO INT REFERENCES PRODUTO, 
	QTD_ITEM_PEDIDO INT, 
	PRECO_ITEM_PEDIDO DEC(9, 2), 
	COD_PEDIDO INT REFERENCES PEDIDO 
)

INSERT UF 
VALUES ('SP', 'S�O PAULO'),
	('MG', 'MINAS GERAIS'),
	('ES', 'ESP�RITO SANTO'),
	('RJ', 'RIO DE JANEIRO')

INSERT CIDADE 
VALUES ('S�O PAULO', 'SP'), 
	('BERZONTE', 'MG'), 
	('VIT�RIA', 'ES'), 
	('GUARAPARI', 'ES'), 
	('CAMPINAS', 'SP'), 
	('NITER�I', 'RJ'), 
	('BERABA', 'MG'), 
	('BERL�NDIA', 'MG'), 
	('SOROCABA', 'SP'), 
	('S�O JO�O DA BOA VISTA', 'SP'), 
	('JAGUARI�NA', 'SP')

INSERT CLIENTE
VALUES ('AGNALDO', 1), 
	('Z�', 3), 
	('CHICO', 3), 
	('TI�O', 1), 
	('ANA', 1), 
	('MARIA', 2), 
	('ANA MARIA', 7), 
	('MARIANA', 1), 
	('MARINA', 10), 
	('MARIA JOS�', 10), 
	('MARIA DO HELP', 2)
	
INSERT PEDIDO
VALUES (1), (1), (2), (3), (8), (9), (11), (2), (1), (1), (4)

INSERT ITEM_PEDIDO
VALUES (1, 10, 0, 7), 
	(2, 5, 0, 7), 
	(3, 2, 0, 7), 
	(3, 1, 0, 2), 
	(4, 2, 0, 3), 
	(5, 3, 0, 3), 
	(6, 5, 0, 3), 
	(7, 3, 0, 4), 
	(1, 2, 0, 4), 
	(8, 1, 0, 4), 
	(9, 1, 0, 5), 
	(10, 1, 0, 5), 
	(11, 3, 0, 5), 
	(1, 3, 0, 5), 
	(2, 3, 0, 5), 
	(3, 3, 0, 6), 
	(8, 4, 0, 6), 
	(1, 5, 0, 7), 
	(9, 6, 0, 8), 
	(10, 1, 0, 9), 
	(11, 5, 0, 10), 
	(1, 2, 0, 11)

SELECT * FROM UF
SELECT * FROM CIDADE
SELECT * FROM CLIENTE
SELECT * FROM PEDIDO
SELECT * FROM ITEM_PEDIDO
SELECT * FROM PRODUTO

--SELECT *
UPDATE IP
SET IP.PRECO_ITEM_PEDIDO = PR.PRECO_PRODUTO
FROM ITEM_PEDIDO IP
INNER JOIN PRODUTO PR ON PR.COD_PRODUTO = IP.COD_PRODUTO

--UF QUE N�O TEM CIDADE ASSOCIADA
SELECT U.*
FROM UF U
LEFT JOIN CIDADE C 
	ON U.SIGLA_UF = C.SIGLA_UF
WHERE C.COD_CIDADE IS NULL

--UF QUE TEM CIDADE ASSOCIADA
SELECT DISTINCT U.*
FROM UF U --U � UM ALIAS PARA UF
INNER JOIN CIDADE C 
	ON U.SIGLA_UF = C.SIGLA_UF

--UF QUE N�O TEM CLIENTES QUE COMPRARAM
SELECT U.*
FROM UF U
LEFT JOIN CIDADE C 
	ON U.SIGLA_UF = C.SIGLA_UF
LEFT JOIN CLIENTE CL 
	ON C.COD_CIDADE = CL.COD_CIDADE
LEFT JOIN PEDIDO P 
	ON CL.COD_CLIENTE = P.COD_CLIENTE
GROUP BY U.SIGLA_UF, U.NOME_UF
HAVING COUNT(P.COD_PEDIDO) = 0

--CIDADE QUE N�O TEM CLIENTES 
SELECT C.*
FROM CIDADE C 
LEFT JOIN CLIENTE CL 
	ON C.COD_CIDADE = CL.COD_CIDADE
WHERE CL.COD_CLIENTE IS NULL

--CLIENTES QUE N�O FIZERAM PEDIDO
SELECT C.*
FROM CLIENTE C
LEFT JOIN PEDIDO P 
	ON C.COD_CLIENTE = P.COD_CLIENTE
WHERE P.COD_PEDIDO IS NULL

--VALOR TOTAL DE CADA PEDIDO
SELECT COD_PEDIDO, 
	SUM(QTD_ITEM_PEDIDO * PRECO_ITEM_PEDIDO) AS 'VALOR_TOTAL_PEDIDO'
FROM ITEM_PEDIDO
GROUP BY COD_PEDIDO

--PRODUTOS QUE N�O FORAM VENDIDOS
SELECT *
FROM PRODUTO P 
LEFT JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE IP.COD_ITEM_PEDIDO IS NULL

--PRODUTO MAIS CARO QUE FOI VENDIDO 
SELECT TOP 1 P.COD_PRODUTO, 
	P.DESCRICAO_PRODUTO
FROM PRODUTO P 
INNER JOIN ITEM_PEDIDO IP
	ON P.COD_PRODUTO = IP.COD_PRODUTO
GROUP BY P.COD_PRODUTO, P.DESCRICAO_PRODUTO, IP.PRECO_ITEM_PEDIDO
ORDER BY IP.PRECO_ITEM_PEDIDO DESC

--PRODUTOS QUE TEM PRECO DIFERENTE DOS PRECOS DE ITEM_PEDIDO
SELECT *
FROM PRODUTO P
INNER JOIN ITEM_PEDIDO IP ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE P.PRECO_PRODUTO <> IP.PRECO_ITEM_PEDIDO

UPDATE ITEM_PEDIDO
SET PRECO_ITEM_PEDIDO = PRECO_ITEM_PEDIDO * 1.1
WHERE COD_PEDIDO IN (1,3,5,7)

SELECT P.*, 
	IP.PRECO_ITEM_PEDIDO
FROM PRODUTO P
INNER JOIN ITEM_PEDIDO IP ON P.COD_PRODUTO = IP.COD_PRODUTO
WHERE P.PRECO_PRODUTO <> IP.PRECO_ITEM_PEDIDO

--MAIOR PEDIDO EM VALOR E EM QUANTIDADE
--VALOR
SELECT TOP 1 WITH TIES COD_PEDIDO, 
	SUM(QTD_ITEM_PEDIDO * PRECO_ITEM_PEDIDO) AS 'TOTAL'
FROM ITEM_PEDIDO 
GROUP BY COD_PEDIDO
ORDER BY TOTAL DESC

--QTD
SELECT TOP 1 WITH TIES COD_PEDIDO, 
	SUM(QTD_ITEM_PEDIDO) AS 'TOTAL'
FROM ITEM_PEDIDO 
GROUP BY COD_PEDIDO
ORDER BY TOTAL DESC

--CLIENTE QUE MAIS COMPROU (VALOR E QUANTIDADE DE PEDIDOS)
--VALOR
SELECT TOP 1 WITH TIES CLIENTE.COD_CLIENTE, 
	NOME_CLIENTE, 
	SUM(QTD_ITEM_PEDIDO * PRECO_ITEM_PEDIDO) AS 'TOTAL'
FROM ITEM_PEDIDO 
INNER JOIN PEDIDO ON PEDIDO.COD_PEDIDO = ITEM_PEDIDO.COD_PEDIDO
INNER JOIN CLIENTE ON CLIENTE.COD_CLIENTE = PEDIDO.COD_CLIENTE
GROUP BY CLIENTE.COD_CLIENTE, NOME_CLIENTE
ORDER BY TOTAL DESC

--QTD
SELECT TOP 1 WITH TIES CLIENTE.COD_CLIENTE, 
	NOME_CLIENTE, 
	COUNT(*) AS 'TOTAL'
FROM PEDIDO 
INNER JOIN CLIENTE ON CLIENTE.COD_CLIENTE = PEDIDO.COD_CLIENTE
GROUP BY CLIENTE.COD_CLIENTE, NOME_CLIENTE
ORDER BY TOTAL DESC

----------------------

SELECT COD_PEDIDO, 
	SUM(PRECO_ITEM_PEDIDO * QTD_ITEM_PEDIDO) AS 'TOTAL'
FROM ITEM_PEDIDO
GROUP BY COD_PEDIDO
WITH ROLLUP

SELECT COD_PEDIDO, 
	SUM(PRECO_ITEM_PEDIDO * QTD_ITEM_PEDIDO)
FROM ITEM_PEDIDO
GROUP BY COD_PEDIDO
WITH CUBE

DROP TABLE ITEM_PEDIDO
DROP TABLE PEDIDO

CREATE TABLE PEDIDO
(
	CLIENTE VARCHAR(50), 
	CIDADE VARCHAR(50), 
	UF CHAR(2), 
	VALOR DEC(9,2)
)

INSERT INTO PEDIDO
VALUES ('AGNALDO','SPO','SP', 1000), 
	('AGNALDO','RJO','RJ', 500), 
	('AGNALDO','SPO','SP', 1000), 
	('ZE','SOROCABA','SP', 120), 
	('TIAO','SOROCABA','SP', 1250)

SELECT UF, 
	CIDADE, 
	CLIENTE, 
	SUM(VALOR) AS 'COMPRAS', 
	COUNT(*) AS 'QTD' 
FROM PEDIDO
GROUP BY UF, CIDADE, CLIENTE
WITH ROLLUP

SELECT UF, 
	CIDADE, 
	CLIENTE, 
	SUM(VALOR) AS 'COMPRAS', 
	COUNT(*) AS 'QTD' 
FROM PEDIDO
GROUP BY UF, CIDADE, CLIENTE
WITH CUBE

SELECT *
FROM PEDIDO
COMPUTE SUM(VALOR)

SELECT *
FROM PEDIDO
ORDER BY CLIENTE
COMPUTE SUM(VALOR) BY CLIENTE

SELECT *
FROM PEDIDO
ORDER BY UF, CIDADE, CLIENTE
COMPUTE SUM(VALOR) BY UF, CIDADE, CLIENTE
COMPUTE SUM(VALOR) BY UF, CIDADE
COMPUTE SUM(VALOR) BY UF
COMPUTE SUM(VALOR) 

SELECT *,
	RANK() OVER (ORDER BY PRECO_PRODUTO) AS 'RANK', 
	DENSE_RANK() OVER (ORDER BY PRECO_PRODUTO) AS 'DENSE_RANK', 
	ROW_NUMBER() OVER (ORDER BY PRECO_PRODUTO) AS 'ROW_NUMBER', 
	NTILE(2) OVER (ORDER BY PRECO_PRODUTO) AS 'NTILE'
FROM PRODUTO

SELECT *
FROM PRODUTO

SELECT *,
	ROW_NUMBER() 
		OVER (PARTITION BY COD_CATEGORIA ORDER BY PRECO_PRODUTO) 
			AS LINHA
FROM PRODUTO

CREATE TABLE NUMEROS
(
	VALOR INT 
)

INSERT NUMEROS 
VALUES (1), 
	(2), 
	(32), 
	(2), 
	(3), 
	(NULL), 
	(NULL), 
	(12), 
	(-1)

SELECT COUNT(*) AS 'COUNT(*)', 
	COUNT(VALOR) AS 'COUNT(CAMPO)', 
	AVG(VALOR) AS 'AVG', 
	MIN(VALOR) AS 'MIN', 
	MAX(VALOR) AS 'MAX', 
	SUM(VALOR) AS 'SUM', 
	SUM(VALOR)/COUNT(VALOR) AS 'MEDIA'
FROM NUMEROS

SELECT COUNT(*) AS 'COUNT(*)', 
	COUNT(VALOR) AS 'COUNT(CAMPO)', 
	AVG(CAST(VALOR AS DEC(9,2))) AS 'AVG', 
	MIN(VALOR) AS 'MIN', 
	MAX(VALOR) AS 'MAX', 
	SUM(VALOR) AS 'SUM', 
	SUM(CAST(VALOR AS DEC(9,2)))/COUNT(VALOR) AS 'MEDIA'
FROM NUMEROS



