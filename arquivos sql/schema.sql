-- 1. Criação do banco e uso
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;



CREATE TABLE clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    client_type ENUM('PF','PJ') NOT NULL, -- PF = pessoa física, PJ = pessoa jurídica
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    CPF CHAR(11),
    CNPJ CHAR(14),
    email VARCHAR(120),
    address VARCHAR(255),
    CONSTRAINT unique_cpf UNIQUE (CPF),
    CONSTRAINT unique_cnpj_client UNIQUE (CNPJ),
    -- CHECK para garantir que seja PF ou PJ e que CPF/CNPJ estejam consistentes
    CONSTRAINT chk_client_type CHECK (
        (client_type = 'PF' AND CPF IS NOT NULL AND CHAR_LENGTH(CPF)=11 AND (CNPJ IS NULL OR CNPJ='')) OR
        (client_type = 'PJ' AND CNPJ IS NOT NULL AND CHAR_LENGTH(CNPJ)=14 AND (CPF IS NULL OR CPF=''))
    )
);

-- 3. Produtos
CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(100) NOT NULL,
    classification_kids BOOLEAN DEFAULT FALSE,
    category ENUM('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(20)
);

-- 4. Fornecedor
CREATE TABLE supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- 5. Vendedor (seller)
CREATE TABLE seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(14),
    CPF CHAR(11),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_CNPJ_seller UNIQUE (CNPJ),
    CONSTRAINT unique_CPF_seller UNIQUE (CPF)
);

-- 6. Relação productSupplier (um produto pode ter múltiplos fornecedores)
CREATE TABLE productSupplier (
    idProduct INT,
    idSupplier INT,
    supplier_sku VARCHAR(80),
    PRIMARY KEY (idProduct, idSupplier),
    CONSTRAINT fk_ps_product FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_ps_supplier FOREIGN KEY (idSupplier) REFERENCES supplier(idSupplier)
);

-- 7. Relação productSeller (vendedor que vende produto)
CREATE TABLE productSeller (
    idPseller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    price DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- 8. Estoque físico (cada storage representa um depósito/estoque)
CREATE TABLE productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageName VARCHAR(150),
    address VARCHAR(255)
);

-- 9. Ligação produto <-> storage (quantidade em cada storage)
CREATE TABLE storageLocation (
    idLproduct INT,
    idLstorage INT,
    quantity INT DEFAULT 0,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);

-- 10. Pagamentos (cliente pode ter várias formas de pagamento)
CREATE TABLE payments (
    id_payment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    typePayment ENUM('Boleto','Cartao','Cartao+Cartao','PIX') ,
    provider VARCHAR(100),
    card_last4 CHAR(4),
    limitAvailable DECIMAL(12,2),
    CONSTRAINT fk_payment_client FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- 11. Pedidos (orders) com entrega (status e código de rastreio)
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivery_status ENUM('Pendente','Em separacao','Enviado','Entregue','Cancelado') DEFAULT 'Pendente',
    tracking_code VARCHAR(80),
    sendValue DECIMAL(10,2) DEFAULT 10.00, -- frete
    payment_confirmed BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_order_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
);

-- 12. Itens do pedido (order_items) -> registra preço unitário para histórico
CREATE TABLE order_items (
    idOrder INT,
    idProduct INT,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idOrder, idProduct),
    CONSTRAINT fk_items_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder),
    CONSTRAINT fk_items_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
