# ⚡ Módulo 05: Performance e Índices

O módulo definitivo para desenvolvedores que querem entender como otimizar consultas lentas, evitar *table scans* e entender o motor do SQL Server.

---

## 🎯 Objetivos do Módulo
- Entender como o SQL Server armazena e busca dados nos bastidores.
- Criar e gerenciar Índices Clustered e Non-Clustered de forma inteligente.
- Aprender a ler e interpretar um Plano de Execução (*Execution Plan*).
- Identificar e corrigir os gargalos mais comuns em aplicações.

---

## 📋 Tópicos Abordados
1. **Anatomia de um Índice:** Como funcionam as árvores B-Tree (*Balanced Trees*).
2. **Índices Clustered vs. Non-Clustered:** Quando criar e quais colunas escolher.
3. **Índices com Colunas Incluídas (`INCLUDE`):** Evitando *Key Lookups*.
4. **Planos de Execução:** Identificação de *Table Scan*, *Index Seek* e *Index Scan*.
5. **Dicas para Desenvolvedores:** O perigo do `SELECT *`, funções em colunas indexadas (`SARGability`) e o uso consciente de `NOLOCK`.

---

## 📂 Estrutura da Pasta
```text
05_Performance_e_Indice/
├── README.md
├── scripts/            # Cenários de testes de performance e criação de índices
├── exercicios/         # Consultas lentas para otimização
└── resolucoes/         # Queries tunadas e justificativas de índices