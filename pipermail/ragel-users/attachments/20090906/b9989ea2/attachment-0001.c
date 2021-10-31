/*
 * This header is here just to make sure that the line 9 is not code!
 *
 *
 *
 *
 *
 * 
 *
 */
void test() {
    int cs;
    const char *p = "FOO\n", *pe = p + 4, *eof;
%%{
  machine test;

  include common "common.rl";

  main := "FOO" . LF;

  write data;
  write init;
  write exec;
}%%
}
