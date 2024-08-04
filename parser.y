%{
#include <stdio.h>
int yylex();

int syntaxError = 0;
void yyerror(const char *s);
extern FILE *yyin;

%}
%error-verbose
%token LET IF THEN ELSE GOTO OF READ PRINT END ATRIB COLON DOTCOM VIRG
%token PLUS MINUS TIMES DIV EQUAL MORE LESS LPAR RPAR
%token ID NUM

%left PLUS MINUS  
%right TIMES DIV    

%start S

%%

S: programa END {printf ("S -> programa end\n");};

programa : seq_cmd {printf("programa -> sequencia de comandos\n");};

seq_cmd : cmd {printf("sequencia de comandos -> comando\n"); }
    | seq_cmd DOTCOM cmd {printf("sequencia de comandos -> sequencia de comandos ; comando\n"); };

cmd : atribuicao { printf("comando -> atribuicao\n"); }
    | desvio { printf("comando -> desvio\n"); }
    | leitura { printf("comando -> leitura\n"); }
    | impressao { printf("comando -> impressao\n"); }
    | decisao { printf("comando -> decisao\n"); }
    | rotulo COLON cmd { printf("comando -> rotulo : comando\n"); }
    | { printf("comando -> vazio\n"); }
;

atribuicao : LET ID ATRIB expr { printf("atribuicao -> let ID := expr\n"); }
;

expr : expr PLUS termo { printf("expr -> expr + termo\n"); }
     | expr MINUS termo { printf("expr -> expr - termo\n"); }
     | termo { printf("expr -> termo\n"); }
;

termo : termo TIMES fator { printf("termo -> termo * fator\n"); }
      | termo DIV fator { printf("termo -> termo / fator\n"); }
      | fator { printf("termo -> fator\n"); }
;

fator : ID { printf("fator -> ID\n"); }
      | NUM { printf("fator -> numero\n"); }
      | LPAR expr RPAR { printf("fator -> ( expr )\n"); }
;

desvio : GOTO rotulo { printf("desvio -> go to rotulo\n"); }
       | GOTO ID OF lista_de_rotulos { printf("desvio -> go to ID of lista_de_rotulos\n"); }
;

lista_de_rotulos : rotulo { printf("lista_de_rotulos -> rotulo\n"); }
       | lista_de_rotulos VIRG rotulo { printf("lista_de_rotulos -> lista_de_rotulos , rotulo\n"); }
;

rotulo : ID { printf("rotulo -> ID\n"); }
;

leitura : READ list_id { printf("leitura -> READ list_id\n"); }
;

list_id : ID { printf("list_id -> ID\n"); }
        | ID VIRG list_id { printf("list_id -> ID , list_id\n"); }
;

impressao : PRINT list_expr { printf("impressao -> PRINT list_expr\n"); }
;

list_expr : expr { printf("list_expr -> expr\n"); }
          | expr VIRG list_expr { printf("list_expr -> expr , list_expr\n"); }
;

decisao : IF comparacao THEN cmd DOTCOM ELSE cmd DOTCOM { printf("decisao -> IF comparacao; THEN comando; ELSE comando;\n"); }
;

comparacao : expr op_comp expr { printf("comparacao -> expr op_comp expr\n"); }
;

op_comp : MORE { printf("op_comp -> >\n"); }
        | EQUAL { printf("op_comp -> =\n"); }
        | LESS { printf("op_comp -> <\n"); }
;

%%


int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <arquivo_de_entrada>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror(argv[1]);
        return 1;
    }

    yyin = file;

    yyparse();

    fclose(file);

    if (syntaxError == 0) {
        printf("Sintaticamente Correto\n");
    } else {
        printf("Sintaticamente Incorreto\n");
    }

    return syntaxError;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    syntaxError++;
}

int yywrap() {
    return 1;
}