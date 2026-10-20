# ✍️ Módulo 03: Manipulação e DML (Data Manipulation Language)

Este módulo aborda como inserir, atualizar, remover e consultar dados em massa, além de gerenciar transações para garantir consistência nas operações.

---

## 🎯 Objetivos do Módulo
- Dominar os comandos de manipulação de dados (`INSERT`, `UPDATE`, `DELETE`, `MERGE`).
- Compreender o comportamento de transações (`BEGIN TRANSACTION`, `COMMIT`, `ROLLBACK`).
- Evitar armadilhas comuns que travam tabelas em ambientes concorridos.

---

## 📋 Tópicos Abordados
1. **INSERT Avançado:** Inserção múltipla, `INSERT INTO ... SELECT` e uso de `OUTPUT`.
2. **UPDATE e DELETE com Segurança:** Uso de `WHERE` adequado, joins em updates e cuidados com locks.
3. **O Comando MERGE (Upsert):** Como inserir ou atualizar registros condicionalmente em uma única instrução.
4. **Transações (ACID):** Como gerenciar blocos de transação e tratamento básico de erros (`TRY...CATCH`).

---

## 📂 Estrutura da Pasta
```text
03_Modelagem_e_DML/
├── README.md
├── scripts/            # Scripts demonstrativos de DML e transações
├── exercicios/         # Casos de uso e cenários de manipulação de dados
└── resolucoes/         # Resoluções com as queries de manipulação