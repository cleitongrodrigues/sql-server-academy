# ⚙️ Módulo 04: Programação em T-SQL

Este módulo explora a linguagem procedural do SQL Server, permitindo criar lógica de negócios diretamente no banco de dados quando necessário.

---

## 🎯 Objetivos do Módulo
- Escrever scripts estruturados usando variáveis, controle de fluxo e cursores (com cautela).
- Desenvolver Stored Procedures eficientes e seguras (evitando SQL Injection).
- Criar Funções Escalares e de Valor de Tabela (*Table-Valued Functions*).
- Automatizar validações e regras usando Triggers.

---

## 📋 Tópicos Abordados
1. **Variáveis e Controle de Fluxo:** Declaração de variáveis, blocos `IF/ELSE` e loops `WHILE`.
2. **Stored Procedures (SPs):** Parâmetros de entrada/saída, tratamento de erros e boas práticas.
3. **Functions (UDFs):** Diferenças entre *Scalar Functions* e *Inline Table-Valued Functions (iTVF)* e seus impactos de performance.
4. **Triggers (Gatilhos):** Uso correto de `AFTER` e `INSTEAD OF` triggers (e quando **não** usá-las).

---

## 📂 Estrutura da Pasta
```text
04_Programacao_T_Sql/
├── README.md
├── scripts/            # Exemplos de procedures, funções e triggers
├── exercicios/         # Desafios de lógica com T-SQL
└── resolucoes/         # Códigos T-SQL resolvidos e comentados