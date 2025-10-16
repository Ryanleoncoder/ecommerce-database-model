-- 1 Pergunta: Quais são todos os produtos cadastrados?
SELECT idProduct, Pname, category, classification_kids, avaliacao, size
FROM product;

-- 2 Pergunta: Quais produtos para crianças estão cadastrados?
SELECT idProduct, Pname, category
FROM product
WHERE classification_kids = TRUE;

-- 3 Pergunta: Produtos da categoria 'Vestimenta' com avaliação >= 4.0
SELECT idProduct, Pname, avaliacao
FROM product
WHERE category = 'Vestimenta' AND avaliacao >= 4.0;

-- 4 Pergunta: Valor total de cada pedido (soma de itens + frete) — atributo derivado.
SELECT
  o.idOrder,
  o.idOrderClient,
  SUM(oi.quantity * oi.unit_price) AS items_total,
  o.sendValue AS freight,
  SUM(oi.quantity * oi.unit_price) + o.sendValue AS order_total
FROM orders o
JOIN order_items oi ON o.idOrder = oi.idOrder
GROUP BY o.idOrder, o.idOrderClient, o.sendValue;

-- 5 Pergunta: Quais os pedidos ordenados pelo maior valor total?
SELECT
  o.idOrder,
  o.idOrderClient,
  SUM(oi.quantity * oi.unit_price) + o.sendValue AS order_total
FROM orders o
JOIN order_items oi ON o.idOrder = oi.idOrder
GROUP BY o.idOrder
ORDER BY order_total DESC;

--  6 Pergunta: Quais clientes fizeram mais de 1 pedido?
SELECT c.idClient, c.Fname, COUNT(o.idOrder) AS total_pedidos
FROM clients c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
HAVING COUNT(o.idOrder) > 1;

-- 7 Pergunta: Clientes cujo gasto total (soma de todos os pedidos) é maior que R$ 2000
SELECT c.idClient, c.Fname,
       SUM(oi.quantity * oi.unit_price) + IFNULL(SUM(o.sendValue),0) AS total_gasto
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient
JOIN order_items oi ON o.idOrder = oi.idOrder
GROUP BY c.idClient
HAVING total_gasto > 2000;

