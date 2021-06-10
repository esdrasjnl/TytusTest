/**
 * Gramática Ascendente para XML
 */

/* Definición Léxica */
%{
    let $cad = "";
%}

%lex

%options case-insensitive
%x STRING

escapechar                          [\'\"\\bfnrtv]
escape                              \\{escapechar}
acceptedcharsdouble                 [^\"\\]+
stringdouble                        {escape}|{acceptedcharsdouble}
stringliteral                       \"{stringdouble}*\"


%%

";"                 return 'PTCOMA';
"("                 return 'PARIZQ';
")"                 return 'PARDER';
"["                 return 'CORIZQ';
"]"                 return 'CORDER';
"<"                 return 'menorq';
">"                 return 'mayorq';

"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'por';
"/"                 return 'div';
"="                 return 'igual';
"?"                 return 'interc';
"xml"               return 'xmlR';
"versionR"           return 'versionR';
"encoding"          return 'encodingR';

/* Espacios en blanco */
[ \r\t]+            {};
\n                  {};

[0-9]+("."[0-9]+)?\b                return 'DECIMAL';
[0-9]+\b                            return 'ENTERO';
[a-zA-Z_][a-zA-Z0-9_ñÑ]*            return 'identificador';

{stringliteral}                     return 'StringLiteral';


["]                           {    $cad = ""; this.begin("STRING"); }
[']                           {    $cad = ""; this.begin("STRING"); }
<STRING>\"                   %{    this.begin('INITIAL'); yytext=""; yytext=$cad;  return 'cadena'; %}      
<STRING>[\']                 %{    this.begin('INITIAL'); yytext=""; yytext=$cad;  return 'cadena'; %}      
<STRING>[^\n\r\"\\']+        %{    $cad+=yytext;  %}
<STRING>'\t'                 %{    $cad+="\t";    %}
<STRING>'\n'                 %{    $cad+="\n";    %}
<STRING>'\r'                 %{    $cad+="\r";    %}
<STRING>'\\"'                %{    $cad+='\"';    %}
<STRING>'\\'                 %{    $cad+='\\';    %}


<<EOF>>                 return 'EOF';

.                       { document.getElementById("console").value += 'Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column + '\n'; }

/lex

/* Asociación de operadores y precedencia */

%left 'MAS' 'MENOS'
%left 'POR' 'DIVIDIDO'
%left UMENOS
%left 'menorq' 'mayorq'
%left 'div'
%left UMINUS

%start START 

%% /* Definición de la gramática */

START : L_OBJETO EOF
;

L_OBJETO: L_OBJETO OBJETO
    | OBJETO
;
//<?xml version="1.0" encoding="UTF-8"?>
//TESTVERSION : menorq interc xmlR versionR igual cadena interc mayorq
//TESTVERSION : menorq interc ATRIB_VERS interc mayorq


//ATRIB_VERS: xmlR versionR igual cadena encodingR igual cadena
//;

OBJETO : menorq identificador LATRIBUTOS OBJ_ETQ
    | error { document.getElementById("console").value += 'Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column + '\n'; }
;

OBJ_ETQ: div mayorq  //< identificador LATRIBUTOS / >
    | mayorq  menorq div identificador LATRIBUTOS mayorq //< identificador LATRIBUTOS >  < / identificador >
    | mayorq LISTA_ID_OBJETO menorq div identificador LATRIBUTOS mayorq //< identificador LATRIBUTOS > LISTA_ID_OBJETO < / identificador >
    | mayorq OBJETOS menorq div identificador LATRIBUTOS mayorq //< identificador LATRIBUTOS > OBJETOS < / identificador >
    | 
;

LATRIBUTOS: ATRIBUTOS
           |
;

ATRIBUTOS: ATRIBUTOS ATRIBUTO
    | ATRIBUTO
;

ATRIBUTO: identificador igual StringLiteral //Identificador = "cadena"
;

OBJETOS: OBJETOS OBJETO
	| OBJETO
;

LISTA_ID_OBJETO: LISTA_ID_OBJETO identificador
    | identificador
;