# oficina

# Sistema de Gerenciamento de Ordens de Serviço - Oficina Mecânica

Este projeto tem como objetivo modelar o esquema conceitual de um sistema de controle e gerenciamento de ordens de serviço (OS) em uma oficina mecânica.

## Descrição do Contexto

Clientes levam seus veículos à oficina para consertos ou revisões periódicas. Cada veículo é atribuído a uma equipe de mecânicos que avalia os serviços necessários e preenche uma ordem de serviço (OS) com uma data de entrega estimada. O valor da OS é composto pela soma dos valores dos serviços (com base em uma tabela de mão-de-obra) e das peças utilizadas.

Cada OS só é executada após a autorização do cliente. A equipe que avaliou o serviço também é responsável por sua execução.

## Entidades e Relacionamentos

- Cliente
- Veículo
- Equipe
- Mecânico
- Ordem de Serviço (OS)
- Serviço
- Peça

Além disso, há tabelas associativas para representar os relacionamentos N:N entre ordens de serviço, serviços e peças.

## Observações

- Supôs-se que cada veículo pertence a apenas um cliente.
- As equipes de mecânicos foram modeladas como entidade separada para permitir maior controle sobre as atribuições de OS.
- Os serviços são cadastrados previamente com base em uma tabela de referência de mão-de-obra.

