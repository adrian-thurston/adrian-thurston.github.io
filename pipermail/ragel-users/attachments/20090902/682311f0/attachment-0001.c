#include <stdio.h>

%%{
  machine adcpData;

  action clear {temp=0;}

  action accum {temp = (temp << 8) + fc;}

  Word8b = extend > clear $ accum ;

  Word16b = extend{2} > clear $ accum ;

  Word32b = extend{4} > clear $ accum ;

  dataBlock = Word8b @{a8=temp;} Word8b @{b8=temp;} Word16b @{a16=temp;} Word16b @{b16=temp;} Word32b @{a32=temp;} Word32b @{b32=temp;} ;

  main := dataBlock* ;

  write data;
 
}%%

int main( )
{
  //for ragel
  int cs;
  char *p;
  char *pe;

  //for my use
  unsigned short int a8, b8, a16, b16 = 0;
  unsigned int a32, b32 = 0;
  unsigned int temp = 0;
  unsigned char data[14] = {0x01,
                           0xff,
                           0x00,0x02,
                           0x00,0xfe,
                           0x00,0x00,0x00,0x03,
                           0x00,0x00,0x00,0xfd};
  int offset = 0;

  p = data;
  pe = data + sizeof(data);
  %%write init;
  %%write exec;
  printf("a8 %x b8 %x a16 %x b16 %x a32 %x b32 %x \n",a8,b8,a16,b16,a32,b32);
  return 0;
}

