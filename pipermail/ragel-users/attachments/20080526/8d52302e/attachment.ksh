
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    char *scheme;
    char *hostname;
    char *service;
    char *path;
    char *uri;
} suj_url;

%%{
    machine uri_parser;
    
# Actions
    action scheme_start { scheme_start = fpc; }
    action scheme_end   { scheme_end   = fpc; }
    action host_start   { host_start   = fpc; }
    action host_end     { host_end     = fpc; }
    action port_start   { port_start   = fpc; }
    action port_end     { port_end     = fpc; }
    action path_start   { path_start   = fpc; }
    action path_end     { path_end     = fpc; }

    action scheme_write { 
        size_t len = scheme_end - scheme_start + 1;
        url->scheme = calloc(len+1,sizeof(char));
        strncpy(url->scheme, scheme_start, len);
        url->scheme[len]='\0';
        //printf("scheme: %s\n",url->scheme); 
    }

    action host_write { 
        size_t len = host_end - host_start + 1;
        url->hostname = calloc(len+1,sizeof(char));
        strncpy(url->hostname, host_start, len);
        url->hostname[len]='\0';
        //printf("host: %s\n",url->hostname); 
    }

    action port_write { 
        size_t len = port_end - port_start + 1;
        url->service = calloc(len+1,sizeof(char));
        strncpy(url->service, port_start, len);
        url->service[len]='\0';
        //printf("service: %s\n",url->service); 
    }

    action path_write { 
        size_t len = path_end - path_start + 1;
        url->path = calloc(len+1,sizeof(char));
        strncpy(url->path, path_start, len);
        url->path[len]='\0';
        //printf("path: %s\n",url->path); 
    }

# Grammar (RFC 1738 section 5)
    safe           = ("$" | "-" | "_" | "." | "+");
    extra          = ("!" | "*" | "'" | "(" | ")" | ",");
    punctuation    = ("<" | ">" | "#" | "%" | "\"");
    reserved       = (";" | "/" | "?" | ":" | "@" | "&" | "=");
    unsafe         = (cntrl | " " | "\"" | "#" | "%" | "<" | ">");
    escape         = ("%" xdigit xdigit);
    national       = any -- (alpha | digit | reserved | extra | safe | unsafe);
    unreserved     = (alpha | digit | safe | extra);
    uchar          = (unreserved | escape);
    xchar          = (unreserved | reserved | escape);
 
    toplabel       = (alpha | alpha (alnum | "-")* alnum);
    domainlabel    = (alnum | alnum (alnum | "-")* alnum);
    hostnumber     = (digit+ "." digit+ "." digit+ "." digit+);
    hostname       = ((domainlabel ".")* toplabel);
    host           = (hostname | hostnumber) >host_start @host_end %host_write;
    user           = (uchar | ";" | "?" | "&" | "=")*;
    password       = (uchar | ";" | "?" | "&" | "=")*;
    port           = digit+ >port_start @port_end %port_write;
    hostport       = (host (":" port)?);
    login          = ((user (":" password) "@") hostport);
#    scheme         = (lower | digit | "+" | "-" | ".")+ >mark @scheme;
#    urlpath        = (xchar*);
#    schemepart     = ("//" login ("/" urlpath));
#    genericurl     = scheme ":" schemepart;

    hsegment       = (uchar | ";" | ":" | "@" | "&" | "=");
    search         = hsegment;
    hpath          = (hsegment ("/" hsegment)*) >path_start @path_end %path_write;
    httpurl        = ("http" >scheme_start @scheme_end %scheme_write "://" hostport (("/" hpath)? ("?" search)));
    
    rtspurl        = ("rtsp" >scheme_start @scheme_end %scheme_write "://" hostport ("/" hpath)?);
    rtpurl         = ("rtp"  >scheme_start @scheme_end %scheme_write "://" hostport ("/" hpath)?);


# Main
    #main := (httpurl | rtspurl | rtpurl) >eof{printf("Reached eof\n");}; 
    main := ("http") $eof{ printf("Reached eof\n"); };

}%%

%%write data;

suj_url * suj_url_new_ragel(char *uri) 
{
    suj_url *url;
    char *scheme_start, *host_start, *port_start, *path_start;
    char *scheme_end, *host_end, *port_end, *path_end;

    url = (suj_url *)calloc(1,sizeof(suj_url));
    bzero(url, sizeof(url));

    url->uri = (char *)calloc(strlen(uri)+1,sizeof(char));
    strncpy(url->uri,uri, strlen(uri));
    url->uri[strlen(uri)] = '\0';

    printf("Parsing url %s\n", url->uri);

    int cs;

    %% write init;

    char *p = uri;
    char *pe = p + strlen(uri);
    char *eof = pe;

    %% write exec;

    return url;
}


int main(int argc, char **argv) 
{
    suj_url *url;

    if(argc < 2) { 
        printf("url1 [url]\n");
        exit(0);
    }

    url = suj_url_new_ragel(argv[1]);

    suj_url_dump(url);
    suj_url_clear(url);

}

