use velozcar; 

CREATE TABLE Cliente (
  id_cliente    INT           NOT NULL AUTO_INCREMENT,
  nome          VARCHAR(100)  NOT NULL,
  cpf           VARCHAR(14)   NOT NULL,
  email         VARCHAR(100)  NOT NULL,
  telefone      VARCHAR(15)   NOT NULL,
  cnh           VARCHAR(20)   NOT NULL,
  endereco      VARCHAR(200)  NOT NULL,
  data_cadastro DATE          NOT NULL,
  PRIMARY KEY (id_cliente),
  UNIQUE KEY uq_cliente_cpf   (cpf),
  UNIQUE KEY uq_cliente_email (email),
  UNIQUE KEY uq_cliente_cnh   (cnh)
) ENGINE=InnoDB;

CREATE TABLE Funcionario (
  id_funcionario INT           NOT NULL AUTO_INCREMENT,
  nome           VARCHAR(100)  NOT NULL,
  cpf            VARCHAR(14)   NOT NULL,
  cargo          VARCHAR(50)   NOT NULL,
  email          VARCHAR(100)  NOT NULL,
  telefone       VARCHAR(15)   NOT NULL,
  data_admissao  DATE          NOT NULL,
  salario        DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_funcionario),
  UNIQUE KEY uq_func_cpf   (cpf),
  UNIQUE KEY uq_func_email (email)
) ENGINE=InnoDB;

CREATE TABLE Veiculo (
  id_veiculo     INT           NOT NULL AUTO_INCREMENT,
  placa          VARCHAR(8)    NOT NULL,
  modelo         VARCHAR(80)   NOT NULL,
  marca          VARCHAR(50)   NOT NULL,
  cor            VARCHAR(30)   NOT NULL,
  ano_fabricacao INT           NOT NULL,
  valor_diaria   DECIMAL(10,2) NOT NULL,
  status         VARCHAR(20)   NOT NULL DEFAULT 'Disponível',
  PRIMARY KEY (id_veiculo),
  UNIQUE KEY uq_veiculo_placa (placa)
) ENGINE=InnoDB;

CREATE TABLE Contrato_Aluguel (
  id_contrato    INT           NOT NULL AUTO_INCREMENT,
  id_cliente     INT           NOT NULL,
  id_funcionario INT           NOT NULL,
  id_veiculo     INT           NOT NULL,
  data_inicio    DATE          NOT NULL,
  data_fim       DATE          NOT NULL,
  data_fim_real  DATE,
  valor_total    DECIMAL(10,2) NOT NULL,
  status         VARCHAR(20)   NOT NULL DEFAULT 'Ativo',
  km_saida       INT           NOT NULL,
  km_retorno     INT,
  PRIMARY KEY (id_contrato),
  CONSTRAINT fk_contrato_cliente     FOREIGN KEY (id_cliente)     REFERENCES Cliente     (id_cliente),
  CONSTRAINT fk_contrato_funcionario FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario),
  CONSTRAINT fk_contrato_veiculo     FOREIGN KEY (id_veiculo)     REFERENCES Veiculo     (id_veiculo)
) ENGINE=InnoDB;

CREATE TABLE Pagamento (
  id_pagamento     INT           NOT NULL AUTO_INCREMENT,
  id_contrato      INT           NOT NULL,
  valor            DECIMAL(10,2) NOT NULL,
  data_pagamento   DATE,
  metodo           VARCHAR(20)   NOT NULL,
  status           VARCHAR(20)   NOT NULL DEFAULT 'Pendente',
  desconto         DECIMAL(10,2) DEFAULT 0.00,
  multa            DECIMAL(10,2) DEFAULT 0.00,
  codigo_transacao VARCHAR(60),
  PRIMARY KEY (id_pagamento),
  UNIQUE KEY uq_pagamento_contrato (id_contrato),
  CONSTRAINT fk_pagamento_contrato FOREIGN KEY (id_contrato) REFERENCES Contrato_Aluguel (id_contrato)
) ENGINE=InnoDB;

CREATE TABLE Manutencao (
  id_manutencao  INT           NOT NULL AUTO_INCREMENT,
  id_veiculo     INT           NOT NULL,
  id_funcionario INT           NOT NULL,
  descricao      VARCHAR(300)  NOT NULL,
  tipo           VARCHAR(50)   NOT NULL,
  custo          DECIMAL(10,2) NOT NULL,
  data_inicio    DATE          NOT NULL,
  data_fim       DATE,
  status         VARCHAR(20)   NOT NULL DEFAULT 'Aberta',
  PRIMARY KEY (id_manutencao),
  CONSTRAINT fk_manut_veiculo     FOREIGN KEY (id_veiculo)     REFERENCES Veiculo     (id_veiculo),
  CONSTRAINT fk_manut_funcionario FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario)
) ENGINE=InnoDB;

USE velozcar;

INSERT INTO Funcionario (nome, cpf, cargo, email, telefone, data_admissao, salario) VALUES
('Roberto Carlos Silva',  '111.222.333-44', 'Atendente',     'roberto@velozcar.com',  '83988880001', '2020-01-10', 2800.00),
('Sandra Figueiredo',     '222.333.444-55', 'Gerente',       'sandra@velozcar.com',   '83988880002', '2019-03-15', 5500.00),
('Eduardo Macedo',        '333.444.555-66', 'Mecânico',      'eduardo@velozcar.com',  '83988880003', '2019-09-10', 3500.00),
('Priscila Dantas',       '444.555.666-77', 'Atendente',     'priscila@velozcar.com', '83988880004', '2021-02-20', 2800.00),
('Henrique Melo',         '555.666.777-88', 'Mecânico',      'henrique@velozcar.com', '83988880005', '2022-04-11', 3500.00),
('Camila Vasconcelos',    '666.777.888-99', 'Administrador', 'camila@velozcar.com',   '83988880006', '2018-08-22', 8000.00),
('Leonardo Barros',       '777.888.999-00', 'Atendente',     'leonardo@velozcar.com', '83988880007', '2022-11-01', 2800.00),
('Mariana Lopes',         '888.999.000-11', 'Mecânico',      'mariana@velozcar.com',  '83988880008', '2021-07-14', 3500.00),
('Tiago Cavalcante',      '999.000.111-22', 'Gerente',       'tiago@velozcar.com',    '83988880009', '2020-06-01', 5500.00),
('Roberta Sousa',         '000.111.222-33', 'Atendente',     'roberta@velozcar.com',  '83988880010', '2023-01-05', 2800.00);


INSERT INTO Cliente (nome, cpf, email, telefone, cnh, endereco, data_cadastro) VALUES
('Ana Beatriz Souza',   '123.456.789-01', 'ana.beatriz@email.com',   '83991110001', 'CNH001111', 'Rua das Flores, 10 - João Pessoa/PB',     '2023-01-15'),
('Carlos Eduardo Lima', '234.567.890-12', 'carlos.lima@email.com',   '83991110002', 'CNH002222', 'Av. Epitácio Pessoa, 200 - João Pessoa/PB','2023-02-20'),
('Fernanda Oliveira',   '345.678.901-23', 'fernanda.oli@email.com',  '83991110003', 'CNH003333', 'Rua do Sol, 55 - Campina Grande/PB',       '2023-03-10'),
('Rafael Gomes',        '456.789.012-34', 'rafael.gomes@email.com',  '83991110004', 'CNH004444', 'Rua Nova, 88 - Recife/PE',                 '2023-04-05'),
('Juliana Martins',     '567.890.123-45', 'juliana.mart@email.com',  '83991110005', 'CNH005555', 'Rua Padre Ibiapina, 3 - Natal/RN',         '2023-05-18'),
('Bruno Alves',         '678.901.234-56', 'bruno.alves@email.com',   '83991110006', 'CNH006666', 'Travessa das Mangueiras, 7 - João Pessoa/PB','2023-06-22'),
('Patrícia Costa',      '789.012.345-67', 'patricia.cost@email.com', '83991110007', 'CNH007777', 'Rua da Aurora, 19 - Fortaleza/CE',         '2023-07-30'),
('Diego Ferreira',      '890.123.456-78', 'diego.ferr@email.com',    '83991110008', 'CNH008888', 'Rua do Campo, 42 - Maceió/AL',             '2023-08-14'),
('Larissa Nunes',       '901.234.567-89', 'larissa.nun@email.com',   '83991110009', 'CNH009999', 'Av. Beira Mar, 100 - Teresina/PI',         '2023-09-25'),
('Marcos Paulo Silva',  '012.345.678-90', 'marcos.silv@email.com',   '83991110010', 'CNH010101', 'Rua das Palmeiras, 66 - João Pessoa/PB',   '2023-10-08'),
('Vanessa Rodrigues',   '112.233.445-56', 'vanessa.rod@email.com',   '83991110011', 'CNH011111', 'Rua Pioneiros, 31 - João Pessoa/PB',       '2023-11-12'),
('Thiago Mendes',       '223.344.556-67', 'thiago.mend@email.com',   '83991110012', 'CNH012222', 'Av. Dom Pedro II, 500 - Campina Grande/PB','2023-12-01');

INSERT INTO Veiculo (placa, modelo, marca, cor, ano_fabricacao, valor_diaria, status) VALUES
('ABC1D23', 'Onix',    'Chevrolet', 'Prata',    2022, 130.00, 'Disponível'),
('BCD2E34', 'HB20',    'Hyundai',   'Branco',   2023, 125.00, 'Disponível'),
('CDE3F45', 'Corolla', 'Toyota',    'Preto',    2021, 170.00, 'Disponível'),
('DEF4G56', 'Cruze',   'Chevrolet', 'Prata',    2022, 165.00, 'Disponível'),
('EFG5H67', 'Compass', 'Jeep',      'Cinza',    2023, 230.00, 'Disponível'),
('FGH6I78', 'Tracker', 'Chevrolet', 'Azul',     2022, 220.00, 'Disponível'),
('GHI7J89', 'Hilux',   'Toyota',    'Branco',   2021, 290.00, 'Disponível'),
('HIJ8K90', 'S10',     'Chevrolet', 'Preto',    2022, 280.00, 'Disponível'),
('IJK9L01', 'Model 3', 'Tesla',     'Branco',   2023, 380.00, 'Disponível'),
('JKL0M12', 'Polo',    'VW',        'Cinza',    2022, 128.00, 'Disponível'),
('KLM1N23', 'Virtus',  'VW',        'Azul',     2021, 158.00, 'Disponível'),
('LMN2O34', 'Kicks',   'Nissan',    'Laranja',  2023, 215.00, 'Disponível'),
('MNO3P45', 'GR86',    'Toyota',    'Vermelho', 2022, 520.00, 'Disponível'),
('NOP4Q56', 'Prius',   'Toyota',    'Verde',    2023, 260.00, 'Disponível'),
('OPQ5R67', 'Creta',   'Hyundai',   'Branco',   2023, 210.00, 'Disponível');

INSERT INTO Contrato_Aluguel (id_cliente, id_funcionario, id_veiculo, data_inicio, data_fim, data_fim_real, valor_total, status, km_saida, km_retorno) VALUES
(1,  1, 1,  '2024-01-05', '2024-01-08', '2024-01-08', 390.00,  'Finalizado', 18000, 18350),
(2,  4, 3,  '2024-01-10', '2024-01-12', '2024-01-12', 340.00,  'Finalizado', 32000, 32280),
(3,  1, 5,  '2024-01-15', '2024-01-20', '2024-01-20', 1150.00, 'Finalizado', 5000,  5600),
(4,  7, 7,  '2024-02-01', '2024-02-03', '2024-02-03', 580.00,  'Finalizado', 45000, 45320),
(5,  4, 2,  '2024-02-10', '2024-02-12', '2024-02-12', 250.00,  'Finalizado', 8000,  8280),
(6,  1, 9,  '2024-02-20', '2024-02-22', '2024-02-22', 760.00,  'Finalizado', 3000,  3380),
(7,  7, 4,  '2024-03-01', '2024-03-03', '2024-03-03', 330.00,  'Finalizado', 22000, 22280),
(8,  4, 6,  '2024-03-10', '2024-03-13', '2024-03-13', 660.00,  'Finalizado', 15000, 15380),
(9,  1, 11, '2024-03-20', '2024-03-22', '2024-03-22', 316.00,  'Finalizado', 28000, 28260),
(10, 7, 13, '2024-04-01', '2024-04-02', '2024-04-02', 520.00,  'Finalizado', 12000, 12180),
(11, 4, 15, '2024-04-10', '2024-04-12', '2024-04-12', 420.00,  'Finalizado', 9000,  9260),
(12, 1, 8,  '2024-04-20', '2024-04-23', '2024-04-23', 840.00,  'Finalizado', 30000, 30350),
(1,  7, 10, '2024-05-01', '2024-05-03', NULL,          256.00,  'Atrasado',   14000, NULL),
(2,  4, 12, '2024-05-10', '2024-05-12', NULL,          430.00,  'Ativo',      9000,  NULL),
(3,  1, 14, '2024-05-15', '2024-05-18', NULL,          780.00,  'Ativo',      6000,  NULL);

INSERT INTO Pagamento (id_contrato, valor, data_pagamento, metodo, status, desconto, multa, codigo_transacao) VALUES
(1,  390.00,  '2024-01-08', 'PIX',     'Concluído',  0.00,   0.00,   'TXN-001'),
(2,  340.00,  '2024-01-12', 'Cartão',  'Concluído',  0.00,   0.00,   'TXN-002'),
(3,  1150.00, '2024-01-20', 'PIX',     'Concluído',  50.00,  0.00,   'TXN-003'),
(4,  580.00,  '2024-02-03', 'Boleto',  'Concluído',  0.00,   0.00,   'TXN-004'),
(5,  250.00,  '2024-02-12', 'PIX',     'Concluído',  0.00,   0.00,   'TXN-005'),
(6,  760.00,  '2024-02-22', 'Cartão',  'Concluído',  0.00,   0.00,   'TXN-006'),
(7,  330.00,  '2024-03-03', 'PIX',     'Concluído',  0.00,   0.00,   'TXN-007'),
(8,  660.00,  '2024-03-13', 'Cartão',  'Concluído',  0.00,   0.00,   'TXN-008'),
(9,  316.00,  '2024-03-22', 'Boleto',  'Concluído',  0.00,   0.00,   'TXN-009'),
(10, 520.00,  '2024-04-02', 'PIX',     'Concluído',  0.00,   0.00,   'TXN-010'),
(11, 420.00,  '2024-04-12', 'Cartão',  'Concluído',  0.00,   0.00,   'TXN-011'),
(12, 840.00,  '2024-04-23', 'PIX',     'Concluído',  0.00,   0.00,   'TXN-012'),
(13, 256.00,  NULL,         'PIX',     'Pendente',   0.00,   50.00,  NULL),
(14, 430.00,  NULL,         'Cartão',  'Pendente',   0.00,   0.00,   NULL),
(15, 780.00,  NULL,         'Boleto',  'Pendente',   0.00,   0.00,   NULL);

INSERT INTO Manutencao (id_veiculo, id_funcionario, descricao, tipo, custo, data_inicio, data_fim, status) VALUES
(1,  3, 'Troca de óleo e filtro',          'Preventiva', 250.00,  '2024-01-20', '2024-01-20', 'Concluída'),
(3,  5, 'Revisão dos freios',              'Corretiva',  800.00,  '2024-01-25', '2024-01-26', 'Concluída'),
(5,  3, 'Alinhamento e balanceamento',     'Preventiva', 180.00,  '2024-02-05', '2024-02-05', 'Concluída'),
(7,  8, 'Troca de correia dentada',        'Preventiva', 650.00,  '2024-02-10', '2024-02-11', 'Concluída'),
(2,  5, 'Revisão geral 20.000 km',        'Revisão',    950.00,  '2024-02-20', '2024-02-21', 'Concluída'),
(9,  3, 'Atualização de software',         'Corretiva',  300.00,  '2024-03-05', '2024-03-05', 'Concluída'),
(4,  8, 'Troca de amortecedores',          'Corretiva',  1200.00, '2024-03-15', '2024-03-16', 'Concluída'),
(6,  5, 'Polimento e higienização',        'Estética',   400.00,  '2024-03-25', '2024-03-25', 'Concluída'),
(8,  3, 'Troca de pastilha de freio',      'Corretiva',  350.00,  '2024-04-05', '2024-04-05', 'Concluída'),
(10, 8, 'Revisão elétrica completa',       'Revisão',    500.00,  '2024-04-15', '2024-04-16', 'Concluída'),
(11, 5, 'Troca de pneus',                  'Corretiva',  1400.00, '2024-04-25', '2024-04-25', 'Concluída'),
(12, 3, 'Limpeza de bicos injetores',      'Preventiva', 280.00,  '2024-05-01', '2024-05-01', 'Concluída'),
(13, 8, 'Troca de bateria',                'Corretiva',  450.00,  '2024-05-10', NULL,         'Em Andamento'),
(14, 5, 'Revisão suspensão dianteira',     'Revisão',    700.00,  '2024-05-15', NULL,         'Em Andamento'),
(15, 3, 'Higienização interna completa',   'Estética',   320.00,  '2024-05-20', NULL,         'Aberta');

UPDATE Veiculo SET status = 'Alugado' WHERE id_veiculo IN (10, 12, 14);
UPDATE Veiculo SET status = 'Em Manutenção' WHERE id_veiculo IN (13, 14, 15);

UPDATE Contrato_Aluguel
SET status = 'Atrasado'
WHERE data_fim < CURDATE() AND data_fim_real IS NULL;


SELECT status, COUNT(*) AS total
FROM Contrato_Aluguel
GROUP BY status;

SELECT
AVG(valor_total) AS media,
MIN(valor_total) AS minimo,
MAX(valor_total) AS maximo
FROM Contrato_Aluguel;

SELECT METODO, count(*) AS total_pagamentos, SUM(valor) AS total_arrecadado
FROM Pagamento
GROUP BY metodo;

SELECT status, SUM(multa) AS total_multas
FROM Pagamento
GROUP BY status;

SELECT f.nome, COUNT(c.id_contrato) AS total_contratos
FROM Funcionario f
INNER JOIN Contrato_Aluguel c ON f.id_funcionario = c.id_funcionario
GROUP BY f.nome
ORDER BY total_contratos DESC;

SELECT cl.nome, cl.telefone, ca.status, ca.data_fim
FROM Cliente cl
INNER JOIN Contrato_Aluguel ca ON cl.id_cliente = ca.id_cliente
WHERE ca.status IN ('Ativo', 'Atrasado');

SELECT 
  cl.nome AS cliente,
  v.modelo AS veiculo,
  v.marca,
  ca.data_inicio,
  ca.data_fim,
  ca.valor_total,
  ca.status AS status_contrato,
  p.metodo,
  p.status AS status_pagamento
FROM Contrato_Aluguel ca
INNER JOIN Cliente cl ON ca.id_cliente = cl.id_cliente
INNER JOIN Veiculo v  ON ca.id_veiculo = v.id_veiculo
INNER JOIN Pagamento p ON ca.id_contrato = p.id_contrato;

SELECT v.placa, v.modelo, v.marca,
  COUNT(m.id_manutencao) AS total_manutencoes,
  SUM(m.custo) AS custo_total
FROM Veiculo v
LEFT JOIN Manutencao m ON v.id_veiculo = m.id_veiculo
GROUP BY v.placa, v.modelo, v.marca;

SELECT f.nome, f.cargo, m.descricao, m.tipo, m.custo, m.status
FROM Funcionario f
LEFT JOIN Manutencao m ON f.id_funcionario = m.id_funcionario
ORDER BY f.nome;