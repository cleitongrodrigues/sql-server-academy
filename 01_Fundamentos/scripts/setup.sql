-- =============================================================================================
-- || SCRIPT DE SETUP: AcademyDB (Módulo 01 - Fundamentos)                                    ||
-- || Autor: Cleiton Rodrigues (https://www.linkedin.com/in/cleitongrodrigues)                ||
-- || Descrição: Cria o banco de dados e as tabelas de exemplo para os estudos de SQL Server. ||
-- =============================================================================================

-- Criação do Banco de Dados
-- ================================================================================
-- || Sempre que vamos criar uma nova base de dados, utilazamos o comando CREATE ||
-- ================================================================================
CREATE DATABASE AcademyDB;
GO

USE AcademyDB;
GO

-- 1. Tabela de Categorias
-- =========================================================================================
-- || Aqui se repete o comando CREATE, mas dessa vez para criar as tabelas do nosso banco ||
-- =========================================================================================
CREATE TABLE Categorias (CategoriaID   INTEGER IDENTITY(1,1) PRIMARY KEY,
                         NomeCategoria VARCHAR(100) NOT NULL,
                         Ativo         BIT DEFAULT 1);
GO

-- 2. Tabela de Clientes
CREATE TABLE Clientes (ClienteID    INTEGER IDENTITY(1,1) PRIMARY KEY,
                       Nome         VARCHAR(100) NOT NULL,
                       Email        VARCHAR(80)  UNIQUE NOT NULL,
                       Cidade       VARCHAR(100) NOT NULL,
                       Estado       CHAR(2)      NOT NULL,
                       DataCadastro DATETIME DEFAULT GETDATE());
GO

-- 3. Tabela de Produtos
CREATE TABLE Produtos (ProdutoID   INTEGER IDENTITY(1,1) PRIMARY KEY,
                       NomeProduto VARCHAR(100)  NOT NULL,
                       CategoriaID INTEGER,
                       Preco       DECIMAL(10,2) NOT NULL,
                       Estoque     INTEGER       NOT NULL,
                       FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID));
GO

-- 4. Tabela de Pedidos (Cabeçalho)
CREATE TABLE Pedidos (PedidoID     INTEGER     IDENTITY(1,1) PRIMARY KEY,
                      ClienteID    INTEGER,
                      DataPedido   DATETIME    DEFAULT GETDATE(),
                      StatusPedido VARCHAR(50) DEFAULT 'Pendente',
                      FOREIGN KEY (ClienteID)  REFERENCES Clientes(ClienteID));
GO

-- 5. Tabela de Itens do Pedido (Detalhe)
CREATE TABLE ItensPedido (ItemPedidoID  INTEGER IDENTITY(1,1) PRIMARY KEY,
                          PedidoID      INTEGER,
                          ProdutoID     INTEGER,
                          Quantidade    INTEGER       NOT NULL,
                          PrecoUnitario DECIMAL(10,2) NOT NULL,
                          FOREIGN KEY (PedidoID)  REFERENCES Pedidos(PedidoID),
                          FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID));
GO

-- ============================================================================
-- POPULANDO O BANCO DE DADOS COM DADOS FICTÍCIOS
-- ============================================================================

-- Inserindo Categorias
INSERT INTO Categorias (NomeCategoria) 
VALUES ('Eletrônicos'), ('Móveis'), ('Livros'), ('Roupas');
GO

-- Inserindo Clientes
INSERT INTO Clientes (Nome, Email, Cidade, Estado) 
VALUES ('Ana Souza'     , 'ana.souza@email.com'     , 'São Paulo'     , 'SP'),
       ('Carlos Silva'  , 'carlos.silva@email.com'  , 'Rio de Janeiro', 'RJ'),
       ('Mariana Lima'  , 'mariana.lima@email.com'  , 'Belo Horizonte', 'MG'),
       ('Lucas Oliveira', 'lucas.oliveira@email.com', 'Curitiba'      , 'PR'),
       ('Beatriz Costa' , 'beatriz.costa@email.com' , 'Porto Alegre'  , 'RS');
GO

-- Inserindo Produtos
INSERT INTO Produtos (NomeProduto, CategoriaID, Preco, Estoque) 
VALUES ('Smartphone XYZ'            , 1, 2500.00, 15),
       ('Notebook Gamer'            , 1, 5500.00, 8),
       ('Cadeira Ergonômica'        , 2, 1200.00, 20),
       ('Mesa para Escritório'      , 2, 850.00 , 10),
       ('Livro Clean Code'          , 3, 89.90  , 50),
       ('Livro Domain-Driven Design', 3, 119.90 , 30),
       ('Camiseta Básica Algodão'   , 4, 49.90  , 100);
GO

-- Inserindo Pedidos
INSERT INTO Pedidos (ClienteID, DataPedido, StatusPedido) 
VALUES (1, '2026-03-01 10:30:00', 'Concluído'),
       (2, '2026-03-02 14:15:00', 'Concluído'),
       (1, '2026-03-05 09:00:00', 'Processando'),
       (3, '2026-03-10 16:45:00', 'Concluído'),
       (4, '2026-03-12 11:20:00', 'Cancelado');
GO

-- Inserindo Itens dos Pedidos
INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario) 
VALUES (1, 1, 1, 2500.00), -- Pedido 1: 1 Smartphone
       (1, 5, 2, 89.90),   -- Pedido 1: 2 Livros Clean Code
       (2, 3, 1, 1200.00), -- Pedido 2: 1 Cadeira
       (3, 2, 1, 5500.00), -- Pedido 3: 1 Notebook
       (4, 4, 1, 850.00),  -- Pedido 4: 1 Mesa
       (4, 6, 1, 119.90),  -- Pedido 4: 1 Livro DDD
       (5, 7, 3, 49.90);   -- Pedido 5: 3 Camisetas
GO