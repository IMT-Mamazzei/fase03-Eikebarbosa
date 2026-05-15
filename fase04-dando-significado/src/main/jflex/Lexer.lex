package br.maua.cic303;

import java_cup.runtime.Symbol; // Importação necessária para o CUP

%%

%class Lexer
%public
%unicode
%cup       // <-- CRÍTICO: Esta diretiva ativa a integração com o CUP
%line
%column

%{
    // Funções auxiliares para gerar objetos Symbol para o CUP
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/* ========================================================================= */
/* MACROS (Expressões Regulares Auxiliares)                                  */
/* ========================================================================= */
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]

/* TODO 1: Crie a macro para Número (Notação de Engenharia) */
/* Dica: Deve aceitar 7, 3.14, 6.02E23, 6.62e-34 */
Number = [0-9]+(\.[0-9]+)?([Ee][+-]?[0-9]+)?

/* TODO 2: Crie a macro para Identificador */
/* Dica: Letras, seguidas de letras, números ou _. MÁXIMO de 32 caracteres! */
/* Se a macro de max 32 for difícil, use {Letter}({Letter}|{Digit}|_)* e trate o tamanho na regra! */
Letter = [a-zA-Z]
Digit  = [0-9]
Identifier = {Letter}({Letter}|{Digit}|_){0,31}

%%
/* ========================================================================= */
/* REGRAS LÉXICAS (Altere para retornar sym.XXX)                                 */
/* ========================================================================= */

<YYINITIAL> {
    
    /* Regra para ignorar espaços em branco */
    {WhiteSpace}    { /* Não faz nada */ }

    /* TODO 3: Palavras Reservadas (if, then, else, while) */
    "if"            { return symbol(sym.IF); }
    "then"          { return symbol(sym.THEN); }
    /* Adicione as demais aqui... */

    /* TODO 4: Pontuação ( ) { } ; */
    \(              { return symbol(sym.LPAREN); }
    /* Adicione as demais aqui... */

    /* TODO 5: Operadores de Atribuição e Relacionais (=, ==, !=, <, >, <=, >=) */
    /* CUIDADO COM A ORDEM! O JFlex casa a regra que aparece primeiro se houver empate de tamanho. */
    /* Coloque os operadores duplos antes dos simples! */
    "="             { return symbol(sym.ASSIGN); }
    /* Adicione os relacionais aqui e retorne Tag.REL_OP ... */

    /* TODO 6: Operadores Matemáticos (+, -, *, /, %) */
    /* Dica: "+" | "-" retornam Tag.ADD_OP. Os outros retornam Tag.MUL_OP */
    "+" | "-"       { return symbol(sym.ADD_OP, yytext()); }
    /* Adicione as multiplicações aqui... */

    /* Regras para as Macros */
    {Identifier}    { return symbol(sym.ID, yytext()); }
    {Number}        { return symbol(sym.NUMBER, yytext()); }

    /* Identificadores grandes demais (Captura o erro) */
   {OversizedIdentifier} { throw new RuntimeException("Erro Léxico: Identificador gigante -> " + yytext()); }

    /* Fallback: Qualquer outro caractere não reconhecido gera um Erro */
    .   {throw new RuntimeException("Erro Léxico: Caractere Ilegal -> " + yytext()); }
}

/* Regra para o Final do Arquivo */
<<EOF>>             { return symbol(sym.EOF, ""); }