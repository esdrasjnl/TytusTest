/**
 * Gramática Ascendente para XML
 */

/* Definición Léxica */
%{
    let $cad = "";
%}

%lex

%options case-insensitive
%s STRING

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

["]                           {    string = ""; this.begin("STRING"); }
[']                           {    string = ""; this.begin("STRING"); }
<STRING>\"                   %{    this.begin('INITIAL'); yytext=""; yytext=string;  return 'cadena'; %}      
<STRING>[\']                 %{    this.begin('INITIAL'); yytext=""; yytext=string;  return 'cadena'; %}      
<STRING>[^\n\r\"\\']+        %{    string+=yytext;  %}
<STRING>'\t'                 %{    string+="\t";    %}
<STRING>'\n'                 %{    string+="\n";    %}
<STRING>'\r'                 %{    string+="\r";    %}
<STRING>'\\"'                %{    string+='\"';    %}
<STRING>'\\'                 %{    string+='\\';    %}


<<EOF>>                 return 'EOF';

.                       { document.getElementById("console").value += 'Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column + '\n'; }

/lex

%{
	let raiz;
    let string = "";
%}

/* Asociación de operadores y precedencia */

%left 'MAS' 'MENOS'
%left 'POR' 'DIVIDIDO'
%left UMENOS
%left 'menorq' 'mayorq'
%left 'div'
%left UMINUS

%start START 

%% /* Definición de la gramática */

START : L_OBJETO EOF { raiz = $$; return raiz; }
;

L_OBJETO: L_OBJETO OBJETO   { $$ = $1; $$.getHijos().push($2); }
    | OBJETO                { $$ = new L_Objeto("LISTA_OBJETOS"); $$.getHijos().push($1); }
;
//<?xml version="1.0" encoding="UTF-8"?>
//TESTVERSION : menorq interc xmlR versionR igual cadena interc mayorq
//TESTVERSION : menorq interc ATRIB_VERS interc mayorq


//ATRIB_VERS: xmlR versionR igual cadena encodingR igual cadena
//;

OBJETO : menorq identificador LATRIBUTOS OBJ_ETQ    { $$ = new Objeto($2); $$.getHijos().push($3); }
    | error { document.getElementById("console").value += 'Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column + '\n'; }
;

OBJ_ETQ: div mayorq  //< identificador LATRIBUTOS / >
    | mayorq  menorq div identificador LATRIBUTOS mayorq //< identificador LATRIBUTOS >  < / identificador >
    | mayorq LISTA_ID_OBJETO menorq div identificador LATRIBUTOS mayorq //< identificador LATRIBUTOS > LISTA_ID_OBJETO < / identificador >
    | mayorq OBJETOS menorq div identificador LATRIBUTOS mayorq //< identificador LATRIBUTOS > OBJETOS < / identificador >
    | 
;

LATRIBUTOS: ATRIBUTOS   { $$ = $1; }
           |            { $$ = new L_Atributo(); }
;

ATRIBUTOS: ATRIBUTOS ATRIBUTO   { $$ = $1; $$.getHijos().push($2); }
    | ATRIBUTO  { $$ = new L_Atributo(); $$.getHijos().push($1); }
;

ATRIBUTO: identificador igual StringLiteral { 
                                                $$ = new Atributo(); 
                                                $$.getHijos().push(new Identificador(@1.first_line, @1.first_column, $1));
                                                $$.getHijos().push(new Cadena(@3.first_line, @3.first_column, $3.substring(1,$3.length-1)));
                                            } //Identificador = "cadena"
;

LISTA_ID_OBJETO: LISTA_ID_OBJETO identificador
    | identificador
    | DECIMAL
    | ENTERO
;