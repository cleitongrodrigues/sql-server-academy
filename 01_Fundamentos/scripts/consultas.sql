USE AcademyDB;
GO

-- SELECT: consulte todas as colunas ou escolha apenas as que precisa.
SELECT *
FROM dbo.Clientes;

SELECT Nome AS NomeCliente,
       Cidade,
       Estado
FROM dbo.Clientes;
GO

-- WHERE e ORDER BY: filtre linhas e defina uma ordem explícita.
SELECT NomeProduto,
       Preco,
       Estoque
FROM dbo.Produtos
WHERE Preco >= 1000
ORDER BY Preco DESC, NomeProduto ASC;
GO

-- AND, OR e parênteses: deixe clara a precedência das condições.
SELECT NomeProduto,
       Preco,
       Estoque
FROM dbo.Produtos
WHERE (Preco < 100 OR Estoque > 40)
  AND CategoriaID IS NOT NULL
ORDER BY NomeProduto;
GO

-- IN, BETWEEN e LIKE.
SELECT Nome,
       Cidade,
       Estado
FROM dbo.Clientes
WHERE Estado IN ('SP', 'RJ')
ORDER BY Estado, Nome;

SELECT NomeProduto,
       Preco
FROM dbo.Produtos
WHERE Preco BETWEEN 50 AND 1000
ORDER BY Preco;

SELECT NomeProduto
FROM dbo.Produtos
WHERE NomeProduto LIKE 'Livro%';
GO

-- NULL deve ser comparado com IS NULL / IS NOT NULL.
-- O conjunto inicial não tem produtos sem categoria; esta consulta retorna zero linhas.
SELECT ProdutoID,
       NomeProduto
FROM dbo.Produtos
WHERE CategoriaID IS NULL;
GO

-- INNER JOIN: somente pedidos que possuem cliente correspondente.
SELECT p.PedidoID,
       c.Nome AS Cliente,
       p.DataPedido,
       p.StatusPedido
FROM dbo.Pedidos AS p
     INNER JOIN dbo.Clientes AS c
     ON c.ClienteID = p.ClienteID
ORDER BY p.PedidoID;

-- LEFT JOIN: todos os clientes, inclusive os que ainda não fizeram pedidos.
SELECT c.ClienteID,
       c.Nome AS Cliente,
       p.PedidoID,
       p.StatusPedido
FROM dbo.Clientes AS c
     LEFT JOIN dbo.Pedidos AS p
     ON p.ClienteID = c.ClienteID
ORDER BY c.ClienteID, p.PedidoID;

-- RIGHT JOIN: preserva todos os pedidos; neste exemplo equivale ao INNER JOIN
-- porque cada pedido possui um cliente.
SELECT c.Nome AS Cliente,
       p.PedidoID,
       p.StatusPedido
FROM dbo.Clientes AS c
     RIGHT JOIN dbo.Pedidos AS p
     ON p.ClienteID = c.ClienteID
ORDER BY p.PedidoID;

-- FULL OUTER JOIN: preserva linhas sem correspondência dos dois lados.
SELECT c.Nome AS Cliente,
       p.PedidoID,
       p.StatusPedido
FROM dbo.Clientes AS c
     FULL OUTER JOIN dbo.Pedidos AS p
     ON p.ClienteID = c.ClienteID
ORDER BY c.ClienteID, p.PedidoID;

-- CROSS JOIN: combina cada categoria com cada status encontrado.
SELECT cat.NomeCategoria,
       s.StatusPedido
FROM dbo.Categorias AS cat
     CROSS JOIN (SELECT DISTINCT StatusPedido
                 FROM dbo.Pedidos) AS s
ORDER BY cat.NomeCategoria, s.StatusPedido;
GO

-- JOIN de várias tabelas: calcule o subtotal de cada item do pedido.
SELECT p.PedidoID,
       c.Nome AS Cliente,
       pr.NomeProduto,
       ip.Quantidade,
       ip.PrecoUnitario,
       ip.Quantidade * ip.PrecoUnitario AS Subtotal
FROM dbo.Pedidos AS p
     INNER JOIN dbo.Clientes AS c
     ON c.ClienteID = p.ClienteID
     INNER JOIN dbo.ItensPedido AS ip
     ON ip.PedidoID = p.PedidoID
     INNER JOIN dbo.Produtos AS pr
     ON pr.ProdutoID = ip.ProdutoID
ORDER BY p.PedidoID, pr.NomeProduto;
GO

-- Agregações e GROUP BY: conte pedidos por status.
SELECT StatusPedido,
       COUNT(*) AS QuantidadePedidos
FROM dbo.Pedidos
GROUP BY StatusPedido
ORDER BY QuantidadePedidos DESC, StatusPedido;

-- Agrupe por categoria e use HAVING para filtrar grupos após a agregação.
SELECT cat.NomeCategoria,
       COUNT(pr.ProdutoID) AS QuantidadeProdutos,
       AVG(pr.Preco) AS PrecoMedio,
       MIN(pr.Preco) AS MenorPreco,
       MAX(pr.Preco) AS MaiorPreco
FROM dbo.Categorias AS cat
     LEFT JOIN dbo.Produtos AS pr
     ON pr.CategoriaID = cat.CategoriaID
GROUP BY cat.CategoriaID, cat.NomeCategoria
HAVING COUNT(pr.ProdutoID) >= 1
ORDER BY cat.NomeCategoria;

-- SUM sobre o valor dos itens de cada pedido.
SELECT ip.PedidoID,
       SUM(ip.Quantidade * ip.PrecoUnitario) AS ValorPedido
FROM dbo.ItensPedido AS ip
GROUP BY ip.PedidoID
ORDER BY ip.PedidoID;
GO

-- Intervalo de datas semiaberto: inclui todo o dia 10, mesmo com horário.
SELECT PedidoID,
       DataPedido,
       StatusPedido
FROM dbo.Pedidos
WHERE DataPedido >= '20260301'
  AND DataPedido <  '20260311'
ORDER BY DataPedido, PedidoID;
GO

-- Paginação: use uma ordem estável e uma chave única como desempate.
DECLARE @NumeroPagina INT = 1;
DECLARE @TamanhoPagina INT = 3;

SELECT ClienteID,
       Nome,
       Cidade,
       Estado
FROM dbo.Clientes
ORDER BY Nome, ClienteID
OFFSET (@NumeroPagina - 1) * @TamanhoPagina ROWS
FETCH NEXT @TamanhoPagina ROWS ONLY;
GO
