CREATE DATABASE SmartCarbo;

USE SmartCarbo;
GO

SELECT * FROM usuario;

SELECT * FROM atividade_fisica;

SELECT * FROM registro_alimentacao;

-- Verificar tableas existentes
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
    'Usuario',
    'AtividadeFisica',
    'RegistroAlimentacao'
)
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- Conferir tabela usuario
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'usuario'
ORDER BY ORDINAL_POSITION;

-- Conferir tabela atividade_fisica
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'atividade_fisica'
ORDER BY ORDINAL_POSITION;

-- Conferir tabela registro_alimentacao
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'registro_alimentacao'
ORDER BY ORDINAL_POSITION;

-- Chaves primárias
SELECT
    tc.TABLE_NAME,
    kcu.COLUMN_NAME,
    tc.CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY tc.TABLE_NAME;

-- Chaves estrangeiras
SELECT
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Tabela,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS Coluna,
    OBJECT_NAME(fk.referenced_object_id) AS TabelaReferenciada,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ColunaReferenciada
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id;

-- Criar a FK
ALTER TABLE registro_alimentacao
ADD CONSTRAINT FK_RegistroAlimentacao_Usuario
FOREIGN KEY (usuario_id)
REFERENCES usuario(id);
GO

SELECT
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Tabela,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS Coluna,
    OBJECT_NAME(fk.referenced_object_id) AS TabelaReferenciada,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ColunaReferenciada
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id;

-- Verificar e-mail duplicado
SELECT 
    email,
    COUNT(*) AS quantidade
FROM usuario
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;

ALTER TABLE usuario
ADD CONSTRAINT UQ_Usuario_Email UNIQUE (email);

SELECT 
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'usuario'
ORDER BY tc.CONSTRAINT_TYPE, tc.CONSTRAINT_NAME;

-- Verificar se existem usuários atuais com algum desses campos vazios

SELECT
    id,
    nome, 
    email,
    senha
FROM usuario
WHERE nome IS NULL
    OR email  IS NULL
    OR senha IS NULL;

ALTER TABLE usuario
ALTER COLUMN nome VARCHAR(255) NOT NULL;

ALTER TABLE usuario
ALTER COLUMN senha VARCHAR(255) NOT NULL;

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'usuario'
  AND COLUMN_NAME IN ('nome', 'email', 'senha')
ORDER BY ORDINAL_POSITION;

-- Removendo temporariamente a constraint
ALTER TABLE usuario
DROP CONSTRAINT UQ_Usuario_Email;

-- Alterando campo
ALTER TABLE usuario
ALTER COLUMN email VARCHAR(255) NOT NULL;

ALTER TABLE usuario
ADD CONSTRAINT UQ_Usuario_Email UNIQUE (email);

-- Conferindo
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'usuario'
  AND COLUMN_NAME IN ('nome', 'email', 'senha')
ORDER BY ORDINAL_POSITION;

-- atividade_fisica

-- Procurando registros com nome

SELECT
    id,
    nome,
    descricao,
    duracao,
    calorias
FROM atividade_fisica
WHERE nome IS NULL
    OR duracao IS NULL
    OR calorias IS NULL;

    ALTER TABLE atividade_fisica
    ALTER COLUMN nome VARCHAR(255) NOT NULL;

    ALTER TABLE atividade_fisica
    ALTER COLUMN duracao INT NOT NULL;

    ALTER TABLE atividade_fisica
    ALTER COLUMN calorias INT NOT NULL;

    SELECT
        COLUMN_NAME,
        DATA_TYPE,
        IS_NULLABLE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'atividade_fisica'
    ORDER BY ORDINAL_POSITION;

    -- registro_alimentacao

    -- Buscando registros existentes

    SELECT
        id,
        usuario_id,
        nome_alimento,
        quantidade,
        tipo_refeicao,
        calorias,
        carboidratos,
        proteinas,
        gorduras,
        fibras,
        sodio,
        data_hora
FROM registro_alimentacao

ALTER TABLE registro_alimentacao
ALTER COLUMN usuario_id BIGINT NOT NULL;

ALTER TABLE registro_alimentacao
ALTER COLUMN nome_alimento VARCHAR(255) NOT NULL;

ALTER TABLE registro_alimentacao
ALTER COLUMN quantidade FLOAT NOT NULL;

ALTER TABLE registro_alimentacao
ALTER COLUMN tipo_refeicao VARCHAR(255) NOT NULL;

ALTER TABLE registro_alimentacao
ALTER COLUMN calorias FLOAT NOT NULL;

ALTER TABLE registro_alimentacao
ALTER COLUMN carboidratos FLOAT NOT NULL;

ALTER TABLE registro_alimentacao
ALTER COLUMN data_hora DATETIME2 NOT NULL;

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'registro_alimentacao'
ORDER BY ORDINAL_POSITION;

-- Adicionar algumas atividades
INSERT INTO atividade_fisica
(nome, descricao, duracao, calorias)
VALUES 
('Corrida Leve', 'Corrida em ritmo leve', 30, 250),
('Bicicleta', 'Pedalada em intensidade moderada', 40, 300),
('Musculação', 'Treino de força', 50, 280)

-- Adicionar registros de alimentação

INSERT INTO registro_alimentacao
(
    nome_alimento,
    quantidade,
    tipo_refeicao,
    calorias,
    carboidratos,
    proteinas,
    gorduras,
    fibras,
    sodio,
    data_hora,
    usuario_id
)
VALUES
(
    'Arroz integral',
    120,
    'Almoço',
    150,
    31,
    3.5,
    0.5,
    2,
    2,
    '2026-10-08T12:30:00',
    3
),
(
    'Feijão carioca',
    100,
    'Almoço',
    76,
    14,
    4.8,
    0.5,
    8.5,
    2,
    '2026-10-08T12:30:00',
    3
),
(
    'Banana',
    90,
    'Café da manhã',
    80,
    21,
    1.0,
    0.2,
    2.3,
    1,
    '2026-10-08T08:00:00',
    3
);


-- Conferir o relacionamento
SELECT
    ra.id,
    u.nome AS usuario,
    ra.nome_alimento,
    ra.quantidade,
    ra.tipo_refeicao,
    ra.calorias,
    ra.data_hora

FROM registro_alimentacao ra
INNER JOIN usuario u
    ON ra.usuario_id = u.id;

-- Verificação
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Teste 1 - FK

INSERT INTO registro_alimentacao
(
    nome_alimento,
    quantidade,
    tipo_refeicao,
    calorias,
    carboidratos,
    data_hora,
    usuario_id
)
VALUES
(
    'Teste FK',
    100,
    'Teste',
    100,
    20,
    GETDATE(),
    999999
);

-- Teste 2 - e-mail único

INSERT INTO usuario
(
    nome,
    email,
    senha
)
VALUES
(
    'Usuario Teste Duplicado',
    'teste@smartcarbo.com',
    '123456'
);