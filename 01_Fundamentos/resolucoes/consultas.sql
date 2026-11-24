USE AcademyDB;
GO

-- 1. Selecione somente as colunas necessarias.
SELECT NomeProduto,
       Preco,
       Estoque
FROM dbo.Produtos;
GO

-- Você pode utilizar alias para melhorar a visualização
SELECT NomeProduto AS Nome_Produto,
       Preco       AS Preco_Produto,
       Estoque     AS Estoque_Produto
FROM dbo.Produtos;
GO

-- 2. IN representa alternativas para a mesma coluna.
-- Usamos IN quando temos mais de um condição de comparação para a mesma coluna
SELECT Nome,
       Cidade,
       Estado
FROM dbo.Clientes
WHERE Estado IN ('SP', 'RJ')
ORDER BY Estado, Nome;
GO

-- 3. BETWEEN inclui o limite inferior e o superior.
SELECT NomeProduto,
       Preco
FROM dbo.Produtos
WHERE Preco BETWEEN 50 AND 1000
ORDER BY Preco, NomeProduto;
GO

-- 4. % representa zero ou mais caracteres.
-- Observe que o '%' ficou após o livro e não no início
SELECT NomeProduto
FROM dbo.Produtos
WHERE NomeProduto LIKE 'Livro%'
ORDER BY NomeProduto;
GO

-- 5. Um intervalo semiaberto inclui todos os horarios do dia final.
SELECT PedidoID,
       DataPedido,
       StatusPedido
FROM dbo.Pedidos
WHERE DataPedido >= '20260301'
  AND DataPedido <  '20261231'
ORDER BY DataPedido, PedidoID;
GO

-- Poderia ser feito com BETWEEN também. Este é mais utilizado porque faz uso dos índices que veremos mais a frente
SELECT PedidoID,
       DataPedido,
       StatusPedido
FROM dbo.Pedidos
WHERE DataPedido BETWEEN '20260301' AND '20261231'
ORDER BY DataPedido, PedidoID;
GO

-- 6. LEFT JOIN preserva clientes sem pedido; para esses, PedidoID e StatusPedido
--    aparecem como NULL.
SELECT c.ClienteID,
       c.Nome AS Cliente,
       p.PedidoID,
       p.StatusPedido
FROM dbo.Clientes AS c
     LEFT JOIN dbo.Pedidos AS p
     ON p.ClienteID = c.ClienteID
ORDER BY c.ClienteID, p.PedidoID;
GO

-- 7. Relacione pedidos, itens e produtos para calcular o subtotal.
SELECT ItensPedido.PedidoID,
       pr.NomeProduto,
       ItensPedido.Quantidade,
       ItensPedido.PrecoUnitario,
       ItensPedido.Quantidade * ItensPedido.PrecoUnitario AS Subtotal
FROM dbo.ItensPedido 
     INNER JOIN dbo.Produtos AS pr
     ON pr.ProdutoID = ItensPedido.ProdutoID
ORDER BY ItensPedido.PedidoID, pr.NomeProduto;
GO

-- 8. SUM agrega os subtotais de cada grupo de itens.
SELECT PedidoID,
       SUM(Quantidade * PrecoUnitario) AS ValorPedido
FROM dbo.ItensPedido
GROUP BY PedidoID
ORDER BY PedidoID;
GO

-- 9. Use LEFT JOIN para manter categorias sem produtos.
--    COUNT(coluna) ignora NULL, portanto categorias sem correspondencia contam zero.
SELECT c.CategoriaID,
       c.NomeCategoria,
       COUNT(p.ProdutoID) AS QuantidadeProdutos
FROM dbo.Categorias AS c
     LEFT JOIN dbo.Produtos AS p
     ON p.CategoriaID = c.CategoriaID
GROUP BY c.CategoriaID, c.NomeCategoria
ORDER BY c.CategoriaID;
GO

-- 10. HAVING filtra os grupos depois de calcular COUNT.
SELECT StatusPedido,
       COUNT(*) AS QuantidadePedidos
FROM dbo.Pedidos
GROUP BY StatusPedido
HAVING COUNT(*) >= 2
ORDER BY StatusPedido;
GO

-- 11. OFFSET pula a primeira pagina; ORDER BY inclui o ID como desempate unico.
SELECT ProdutoID,
       NomeProduto,
       Preco
FROM dbo.Produtos
ORDER BY Preco DESC, ProdutoID
OFFSET 3 ROWS
FETCH NEXT 3 ROWS ONLY;
GO

-- 12. NULL deve ser comparado com IS NULL, nunca com = NULL.
SELECT ProdutoID,
       NomeProduto
FROM dbo.Produtos
WHERE CategoriaID IS NULL;
GO
