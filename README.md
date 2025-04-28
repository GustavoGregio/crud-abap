# Sistema de Gerenciamento de Clientes em ABAP

Este projeto tem como objetivo criar um sistema completo de gerenciamento de clientes, implementado em ABAP, com operações de criação, modificação, consulta e exclusão de registros.

## Funcionalidades

- Cadastrar clientes
- Modificar dados de clientes
- Excluir clientes
- Consultar clientes com filtros avançados e exibição em ALV

## Estrutura de Dados

**Tabela:** `ZSD_CLIENTE`

| Campo           | Tipo        | Chave | Descrição            |
|-----------------|-------------|-------|----------------------|
| MANDT           | MANDT       | Sim   | Mandante             |
| ZCLINR          | INT         | Sim   | Código do Cliente    |
| ERDAT           | ERDAT       | Não   | Data de Criação      |
| ERZET           | ERZET       | Não   | Hora de Criação      |
| NOME            | CHAR(180)   | Não   | Nome do Cliente      |
| EMAIL           | CHAR(255)   | Não   | Email do Cliente     |
| LIMITE_CREDITO  | DEC(18,2)   | Não   | Limite de Crédito    |
| STATUS          | CHAR(1)     | Não   | Status (A = Ativo, B = Bloqueado) |

**Observação:**  
O campo `STATUS` é definido como Ativo (A) por padrão.

## Transações Criadas

| Transação | Descrição                             |
|-----------|---------------------------------------|
| ZSD001    | Criar Cliente                         |
| ZSD002    | Modificar Cliente                     |
| ZSD003    | Excluir Cliente                       |
| ZSD004    | Consultar Cliente (com ALV interativo) |

### Detalhes das Transações

- **ZSD001 – Criar Cliente**  
  Tela para cadastro de novos clientes. Data e hora de criação preenchidas automaticamente pelo sistema.

- **ZSD002 – Modificar Cliente**  
  Tela para buscar e modificar dados de um cliente já existente. Código do cliente é bloqueado para edição. Data e hora de criação permanecem inalteradas.

- **ZSD003 – Excluir Cliente**  
  Tela simples para informar o código de cliente a ser excluído. O sistema realiza a exclusão se o cliente existir.

- **ZSD004 – Consultar Cliente**  
  Tela de seleção avançada permitindo filtros por todos os campos.  
  Resultado exibido em ALV com botões para:
  - Criar novo cliente
  - Editar cliente existente
  - Excluir cliente

## Tecnologias Utilizadas

- ABAP (Reports, Dynpros, ALV Grid Display)
- ABAP Dictionary (Tabelas e Estruturas)
