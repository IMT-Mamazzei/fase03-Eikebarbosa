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

/* Número: inteiro, decimal, notação científica (ex: 7, 3.14, 6.02E23, 6.62e-34) */
Number = [0-9]+(\.[0-9]+)?([Ee][+-]?[0-9]+)?

/* Identificador: letra seguida de até 31 letras/dígitos/underscore (máx 32 chars) */
Letter = [a-zA-Z]
Digit  = [0-9]
Identifier = {Letter}({Letter}|{Digit}|_){0,31}
OversizedIdentifier = {Letter}({Letter}|{Digit}|_)+

%%
/* ========================================================================= */
/* REGRAS LÉXICAS                                                             */
/* ========================================================================= */

<YYINITIAL> {
    
    /* Ignorar espaços em branco */
    {WhiteSpace}    { /* Não faz nada */ }

    /* Palavras Reservadas — devem vir ANTES da regra de Identifier */
    "if"            { return symbol(sym.IF); }
    "then"          { return symbol(sym.THEN); }
    "else"          { return symbol(sym.ELSE); }
    "while"         { return symbol(sym.WHILE); }

    /* Pontuação */
    "("              { return symbol(sym.LPAREN); }
    ")"              { return symbol(sym.RPAREN); }
    "{"             { return symbol(sym.LBRACE); }
    "}"              { return symbol(sym.RBRACE); }
    ";"             { return symbol(sym.SEMI); }

    /* Operadores Relacionais — duplos ANTES do simples "=" */
    "=="            { return symbol(sym.REL_OP, yytext()); }
    "!="            { return symbol(sym.REL_OP, yytext()); }
    "<="            { return symbol(sym.REL_OP, yytext()); }
    ">="            { return symbol(sym.REL_OP, yytext()); }
    "<"             { return symbol(sym.REL_OP, yytext()); }
    ">"             { return symbol(sym.REL_OP, yytext()); }

    /* Atribuição — depois dos relacionais para não conflitar */
    "="             { return symbol(sym.ASSIGN); }

    /* Operadores Aditivos */
    "+" | "-"       { return symbol(sym.ADD_OP, yytext()); }

    /* Operadores Multiplicativos */
    "*" | "/" | "%" { return symbol(sym.MUL_OP, yytext()); }

    /* Identificadores grandes demais (erro léxico) */
    {OversizedIdentifier} { throw new RuntimeException("Erro Léxico: Identificador muito longo -> " + yytext()); }

    /* Identificadores e palavras não reservadas */
    {Identifier}    { return symbol(sym.ID, yytext()); }

    /* Números */
    {Number}        { return symbol(sym.NUMBER, yytext()); }

    /* Fallback: caractere não reconhecido */
    .   { throw new RuntimeException("Erro Léxico: Caractere Ilegal -> " + yytext()); }
}

/* Final do Arquivo */
<<EOF>>             { return symbol(sym.EOF); }
