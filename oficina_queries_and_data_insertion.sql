-- inserção de dados e queries
-- drop database oficina;
use oficina;
show tables;

-- Clientes
INSERT INTO Cliente (nome, telefone, endereco) VALUES
('João Silva', '11999998888', 'Rua das Flores, 123'),
('Maria Oliveira', '11888887777', 'Av. Brasil, 456'),
('Carlos Souza', '11777776666', 'Rua Central, 789');

-- Veículos
INSERT INTO Veiculo (placa, marca, modelo, ano, id_cliente) VALUES
('ABC1234', 'Ford', 'Fiesta', 2010, 1),
('XYZ5678', 'Chevrolet', 'Onix', 2018, 2),
('JKL3456', 'Toyota', 'Corolla', 2022, 3);

-- Equipes
INSERT INTO Equipe (nome) VALUES ('Equipe Alfa'), ('Equipe Beta');

-- Mecânicos
INSERT INTO Mecanico (nome, endereco, especialidade, id_equipe) VALUES
('Pedro Lima', 'Rua A, 100', 'Suspensão', 1),
('Lucas Rocha', 'Rua B, 200', 'Motor', 1),
('Ana Souza', 'Rua C, 300', 'Freios', 2);

-- Serviços
INSERT INTO Servico (descricao, valor_mao_obra) VALUES
('Troca de óleo', 100.00),
('Alinhamento e balanceamento', 150.00),
('Troca de pastilhas de freio', 200.00);

-- Peças
INSERT INTO Peca (nome, descricao, valor) VALUES
('Óleo 10W40', 'Lubrificante sintético', 80.00),
('Pastilhas de freio', 'Jogo dianteiro', 120.00),
('Filtro de óleo', 'Filtro compatível com veículos Ford', 30.00);

-- Ordens de Serviço
INSERT INTO OrdemServico (data_emissao, data_conclusao, status, valor_total, autorizada, id_veiculo, id_equipe) VALUES
('2025-04-10', '2025-04-12', 'Concluído', 330.00, TRUE, 1, 1),
('2025-04-11', NULL, 'Em andamento', NULL, FALSE, 2, 2);

-- Serviços por OS
INSERT INTO OS_Servico (id_os, id_servico, quantidade) VALUES
(1, 1, 1),
(1, 2, 1);

-- Peças por OS
INSERT INTO OS_Peca (id_os, id_peca, quantidade) VALUES
(1, 1, 1),
(1, 3, 1);

-- --------------------------------------------------
-- Consultas úteis (business queries)
-- --------------------------------------------------

-- Ordens autorizadas e concluídas
SELECT os.id_os, c.nome AS cliente, os.status, os.data_conclusao
FROM OrdemServico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Cliente c ON v.id_cliente = c.id_cliente
WHERE os.autorizada = TRUE AND os.status = 'Concluído';

-- Serviços realizados em uma OS
SELECT s.descricao, oss.quantidade, s.valor_mao_obra
FROM OS_Servico oss
JOIN Servico s ON oss.id_servico = s.id_servico
WHERE oss.id_os = 1;

-- Peças utilizadas em uma OS
SELECT p.nome, op.quantidade, p.valor,
       (op.quantidade * p.valor) AS total_peca
FROM OS_Peca op
JOIN Peca p ON op.id_peca = p.id_peca
WHERE op.id_os = 1;

-- Mecânicos por equipe
SELECT e.nome AS equipe, m.nome AS mecanico, m.especialidade
FROM Mecanico m
JOIN Equipe e ON m.id_equipe = e.id_equipe
ORDER BY e.nome;

-- Veículos de um cliente específico
SELECT v.placa, v.marca, v.modelo, v.ano
FROM Veiculo v
JOIN Cliente c ON v.id_cliente = c.id_cliente
WHERE c.nome = 'Maria Oliveira';

-- Valor estimado de uma OS
SELECT os.id_os,
       SUM(DISTINCT s.valor_mao_obra) AS total_servicos,
       SUM(p.valor * op.quantidade) AS total_pecas,
       SUM(DISTINCT s.valor_mao_obra) + SUM(p.valor * op.quantidade) AS valor_estimado
FROM OrdemServico os
JOIN OS_Servico oss ON os.id_os = oss.id_os
JOIN Servico s ON oss.id_servico = s.id_servico
JOIN OS_Peca op ON os.id_os = op.id_os
JOIN Peca p ON op.id_peca = p.id_peca
WHERE os.id_os = 1
GROUP BY os.id_os;
