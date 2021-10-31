#include <stdio.h>
%%{	
    machine TEST;
    alphtype char;

    action pp { printf("%c\n", fc); }

    test := '0123456789ab' >{ printf("new machine\n"); } $pp;
    main := any{12} >{ mark = fpc; } $pp @{ fexec mark; fgoto test; } ;
}%%


void parse(char *p, char *pe) {
    int cs;
    char *mark;

    %% write data;

    %% write init;
    %% write exec;


}

int main() {
    
    const char *t = "0123456789ab";

    parse(t, t + 12);

    return 0;
}
