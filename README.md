# E-commerce — Modelagem Lógica e SQL

## Descrição
Projeto que replica o modelo lógico de um cenário de E-commerce. O esquema contempla:
- Clientes (PF ou PJ — exclusividade entre PF e PJ),
- Produtos,
- Fornecedores e Vendedores,
- Estoque distribuído (storages),
- Pagamentos (múltiplas formas por cliente),
- Pedidos com itens e dados de entrega (status e código de rastreio),
- Mapas de relacionamento entre produto-fornecedor e produto-vendedor.

## Tecnologias
- MySQL

## Como executar
1. Importar/rodar o script `schema.sql` no MySQL (o arquivo contido no repositório).
2. Rodar o script `seed.sql` para inserir dados de exemplo.
3. Executar queries em `respostas.sql` para testes e análises.

## Pontos modelados / regras de negócio
- Um cliente pode ser PF ou PJ (atributo `client_type`), e apenas os campos correspondentes (CPF ou CNPJ) são válidos por CHECK constraint.
- Um cliente pode ter múltiplas formas de pagamento (`payments`).
- Pedidos possuem `delivery_status` e `tracking_code`.
- Historico de itens do pedido grava `unit_price` por item (bom para auditoria).

