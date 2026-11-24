# Módulo 01: Fundamentos de SQL Server

Este módulo apresenta as consultas essenciais para explorar dados relacionais no SQL Server. Os exemplos usam o banco fictício `AcademyDB`, criado pelo script de configuração desta pasta.

## Objetivos

- Consultar colunas e linhas com `SELECT`.
- Filtrar e ordenar resultados com `WHERE` e `ORDER BY`.
- Combinar condições e trabalhar com listas, intervalos, padrões e valores nulos.
- Relacionar tabelas com os diferentes tipos de `JOIN`.
- Resumir dados com funções de agregação, `GROUP BY` e `HAVING`.
- Paginar resultados de forma previsível com `OFFSET` e `FETCH NEXT`.

## Conteúdo

```text
01_Fundamentos/
├── README.md
├── scripts/
│   ├── setup.sql          # Cria e popula o banco AcademyDB (executar uma vez)
│   └── consultas.sql      # Exemplos dos tópicos deste módulo
├── exercicios/
│   └── consultas.sql      # Desafios para praticar
└── resolucoes/
    └── consultas.sql      # Respostas comentadas dos desafios
```

## Como começar

1. Abra `scripts/setup.sql` no SQL Server Management Studio ou Azure Data Studio e execute-o uma vez. Ele cria o banco `AcademyDB` e popula as tabelas com dados fictícios.
2. Execute `scripts/consultas.sql` para acompanhar os exemplos.
3. Tente resolver `exercicios/consultas.sql` antes de consultar `resolucoes/consultas.sql`.

O script de configuração usa `CREATE DATABASE AcademyDB`; se o banco já existir, remova-o por sua ferramenta de administração ou escolha outro nome antes de executar novamente. Os scripts de consulta e exercícios pressupõem que o banco e os dados de exemplo já foram criados.

## Observações

- `ORDER BY` é necessário para garantir a ordem dos resultados. Para paginação consistente, ordene também por uma coluna única como critério de desempate.
- `BETWEEN` inclui os dois limites. Para intervalos de data/hora, prefira limites explícitos quando precisar controlar com precisão o instante final.
- `NULL` representa ausência de valor e deve ser testado com `IS NULL` ou `IS NOT NULL`, não com `= NULL`.
- `LEFT`, `RIGHT` e `FULL OUTER JOIN` preservam linhas sem correspondência; as colunas do outro lado aparecem como `NULL`.
- `OFFSET` e `FETCH NEXT` exigem `ORDER BY` e estão disponíveis no SQL Server 2012 ou superior.
