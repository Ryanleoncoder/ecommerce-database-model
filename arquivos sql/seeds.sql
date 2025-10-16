-- CLIENTES
INSERT INTO clients (client_type, Fname, Lname, CPF, email, address) VALUES
('PF', 'Joao', 'Silva', '12345678901', 'joao@example.com', 'Rua A, 100'),
('PF', 'Maria', 'Oliveira', '98765432100', 'maria@example.com', 'Rua B, 200'),
('PJ', 'LojaTech', NULL, NULL, 'contato@lojatech.com', 'Av. PX, 500'); -- PJ precisa de CNPJ
UPDATE clients SET CNPJ = '11122233344455' WHERE Fname='LojaTech';

-- PRODUTOS
INSERT INTO product (Pname, classification_kids, category, avaliacao, size) VALUES
('Smartphone X', FALSE, 'Eletronico', 4.5, '6.1'),
('Camiseta Algodao', FALSE, 'Vestimenta', 4.1, 'M'),
('Carrinho Mini', TRUE, 'Brinquedos', 4.8, 'P'),
('Mesa Sala', FALSE, 'Moveis', 4.0, '120x60');

-- FORNECEDORES
INSERT INTO supplier (SocialName, CNPJ, contact) VALUES
('SupplyOne Ltda', '22233344455566', '21999999999'),
('BrinqFornece SA', '33344455566677', '21988888888');

-- VENDEDORES
INSERT INTO seller (SocialName, AbstName, CNPJ, contact) VALUES
('SellerTop', 'SellerTop Ltda', '22233344455566', '21977777777'), -- observe mesmo CNPJ do supplier (vai responder à pergunta)
('VendedorZ', 'VZ Comercio', '44455566677788', '21966666666');

-- PRODUTO <-> FORNECEDOR
INSERT INTO productSupplier (idProduct, idSupplier, supplier_sku) VALUES
(1, 1, 'X-1000'), -- smartphone from SupplyOne
(3, 2, 'BRQ-300'); -- carrinho from BrinqFornece

-- PRODUTO <-> VENDEDOR
INSERT INTO productSeller (idPseller, idProduct, prodQuantity, price) VALUES
(1,1,50, 2500.00),
(2,2,120, 39.90),
(1,3,30, 149.90);

-- ESTOQUE (storages)
INSERT INTO productStorage (storageName, address) VALUES
('CD Rio', 'Av. Estoque, 100'),
('CD SP', 'Av. Estoque, 200');

-- QUANTIDADE EM ESTOQUES
INSERT INTO storageLocation (idLproduct, idLstorage, quantity) VALUES
(1,1,20),
(1,2,30),
(3,1,15),
(2,2,80);

-- PAGAMENTOS (várias formas para um cliente)
INSERT INTO payments (idClient, typePayment, provider, card_last4, limitAvailable) VALUES
(1, 'Cartao', 'Visa', '4242', 8000.00),
(1, 'PIX', 'BancoX', NULL, NULL),
(3, 'Boleto', 'BancoB', NULL, NULL);

-- PEDIDOS
INSERT INTO orders (idOrderClient, delivery_status, tracking_code, sendValue, payment_confirmed) VALUES
(1, 'Enviado', 'TRACK12345', 20.00, TRUE),
(1, 'Pendente', NULL, 15.00, FALSE),
(2, 'Entregue', 'TRACK67890', 12.00, TRUE);

-- ITENS DO PEDIDO
INSERT INTO order_items (idOrder, idProduct, quantity, unit_price) VALUES
(1, 1, 1, 2500.00),
(1, 3, 2, 149.90),
(2, 2, 3, 39.90),
(3, 2, 1, 39.90);

-- Ajuste: se necessário, update de CNPJ do cliente PJ (já inserido em UPDATE acima)
