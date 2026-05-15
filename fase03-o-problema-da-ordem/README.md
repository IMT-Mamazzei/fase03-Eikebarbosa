# 🌳 Fase 3: O Problema da Ordem (Análise Sintática com CUP)

O nosso Analisador Léxico (Fase 2) está funcionando perfeitamente! Mas temos um problema: se você digitar `+ = while 3`, o Lexer vai reconhecer todos os tokens como válidos. Ele não faz ideia de que a ordem das palavras está errada.

Além disso, como o computador sabe que na expressão `2 + 3 * 4`, a multiplicação deve acontecer antes da soma? O Lexer não tem "memória" para resolver isso.

Bem-vindo à **Análise Sintática**! Nosso objetivo agora é validar a estrutura gramatical do código usando o gerador de parsers **CUP** (baseado em algoritmos ascendentes LALR).

## 🎯 O Desafio
Você deve converter a gramática da linguagem **JACA** para o formato do CUP no arquivo `src/main/cup/parser.cup`.

**As Regras da JACA:**
1. Um programa é uma lista de comandos.
2. Um comando pode ser: atribuição, `if`, `while`, bloco de comandos ou um comando nulo `;`.
3. Atribuição: `ID = expressao ;`
4. Estrutura If: `if ( expressao ) then bloco [else bloco]`
5. Estrutura While: `while ( expressao ) bloco`
6. Bloco: `{ lista_de_comandos }`
7. Expressão: Matemática (`+`, `-`, `*`, `/`, `%`) ou Relacional (`==`, `>`, etc), e parênteses.

⚠️ **Atenção (O Pulo do Gato):**
A especificação acima permite repetições e itens opcionais (EBNF). O CUP aceita **apenas BNF puro**! 
Você não pode usar `[ ]` ou `{ }` no CUP. Você terá que pesquisar como transformar listas usando **recursão à esquerda** (ex: `lista ::= lista item | item`).

## 🛠️ Como fazer?
1. Complete o arquivo `Lexer.lex` fornecido e complete as etapas indicadas com `/* TODO */`.
2. Abra o arquivo `parser.cup` e implemente as regras gramaticais nos espaços marcados com `/* TODO */`.
3. Resolva as precedências matemáticas (`*` é resolvido antes de `+`) declarando as diretivas `%left` e `%right` no topo do arquivo.

## Como ficará a estrutura ##

```
/fase03-a-arvore-sintatica
 ├── README.md
 ├── pom.xml
 └── /src
      ├── /main
      │    ├── /jflex
      │    │    └── Lexer.lex                   <-- (Você deve copiar da Fase 2)
      │    ├── /cup
      │    │    └── parser.cup                  <-- Esqueleto fornecido para você utilizar
      └── /test
           └── /java
                └── /br/maua/cic303
                     └── ValidadorFase3Test.java <-- O Juiz Automático
```

## 🚦 O Juiz Automático
Rode o verificador para ver se a sua gramática aceita códigos válidos e rejeita absurdos:
```bash
mvn test
```


*Dica:* Se o terminal mostrar Warning : *** Shift/Reduce conflict found, sua gramática está ambígua! Você deve consertar a precedência!
