-- 1. Recuperação Simples com SELECT:
SELECT * FROM Clientes;

-- 2. Filtros com WHERE:
SELECT * FROM Pedidos WHERE Status = 'Confirmado';

-- 3. Calculando o total de vendas de cada produto usando a tabela produtos_terceiros:
SELECT P.`Name`, P.Price, PT.Qtd,
       P.Price * PT.Qtd AS TotalSales FROM produtos P
JOIN produtos_terceiros PT ON P.id = PT.fk_idProduct;

-- 4. Ordenação com ORDER BY:
SELECT `Name`, Price FROM produtos ORDER BY Price DESC;

-- 5. Condição de filtro de grupo com HAVING:
SELECT fk_idProduct, SUM(Qtd) AS TotalQtd FROM produtos_estoques GROUP BY fk_idProduct HAVING TotalQtd > 100;

-- 6. Junção entre tabelas para perspectiva mais complexa:
SELECT C.Pname AS Cliente, FP.PayType
FROM Pedidos P
JOIN Clientes C ON P.fk_idClient = C.idClient
JOIN Formas_Pagamentos FP ON P.fk_idPayType = FP.id;

-- 7. Recuperar o nome e a quantidade total de produtos vendidos por categoria, ordenados pela quantidade decrescente:
SELECT P.Category, SUM(PP.Qtd) AS TotalQuantity
FROM produtos P
JOIN pedidos_produtos PP ON P.id = PP.fk_idProduct
GROUP BY P.Category
ORDER BY TotalQuantity DESC;

-- 8. Contagem de pedidos por cliente:
SELECT fk_idClient, COUNT(*) AS TotalPedidos FROM Pedidos GROUP BY fk_idClient;

-- 9. Recuperação de produtos com estoque esgotado:
SELECT PP.`Name` FROM produtos PP
LEFT JOIN produtos_estoques PE ON PP.id = PE.fk_idProduct
WHERE PE.Qtd IS NULL OR PE.Qtd = 0;

-- 10. Pedidos com valor acima de uma média:
SELECT * FROM Pedidos WHERE TotalValue > (SELECT AVG(TotalValue) FROM Pedidos);

-- 11. Valor total de pedidos por status:
SELECT `Status`, SUM(TotalValue) AS TotalPedido FROM Pedidos GROUP BY `Status`;

-- 12. Média de avaliação dos produtos por categoria:
SELECT Category, AVG(Rating) AS MediaAvaliacao FROM produtos GROUP BY Category;

-- 13. Pedidos dos clientes:
SELECT
    C.Pname AS Cliente,
    P.id AS Pedido_ID,
    P.`Status`,
    P.`Date`,
    P.TotalValue
FROM
    Clientes C
JOIN Pedidos P ON C.idClient = P.fk_idClient
ORDER BY Cliente, Pedido_ID;

-- 14. Produtos vendidos por vendedor:
SELECT V.SocialName, PP.`Name`, PT.Qtd FROM vendedores V
JOIN produtos_terceiros PT ON V.id = PT.fk_idSeller
JOIN produtos PP ON PT.fk_idProduct = PP.id;

-- 15. Produtos que não têm nenhum registro de vendas:
SELECT `Name` FROM produtos
LEFT JOIN produtos_terceiros PT ON produtos.id = PT.fk_idProduct
WHERE PT.fk_idProduct IS NULL;



-- OBJETIVOS

-- 1. Já respondida acima
-- 2. Algum vendedor também é fornecedor?
SELECT V.`SocialName` AS Vendedor, F.`SocialName` AS Fornecedor
FROM vendedores V
JOIN Fornecedores F ON V.`SocialName` = F.`SocialName`;

-- 3. Relação de produtos fornecedores e estoques:
SELECT P.`Name` AS Produto, F.`SocialName` AS Fornecedor, E.`Local` AS Estoque
FROM produtos P
JOIN fornecedores_produtos FP ON P.id = FP.fk_idProduct
JOIN Fornecedores F ON FP.fk_idSupplier = F.id
JOIN produtos_estoques PE ON P.id = PE.fk_idProduct
JOIN estoques E ON PE.fk_idStorage = E.id;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos:
SELECT F.`SocialName` AS Fornecedor, P.`Name` AS Produto
FROM Fornecedores F
JOIN fornecedores_produtos FP ON F.id = FP.fk_idSupplier
JOIN produtos P ON FP.fk_idProduct = P.id;
