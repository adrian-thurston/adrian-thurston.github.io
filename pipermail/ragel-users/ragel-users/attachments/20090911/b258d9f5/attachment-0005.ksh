#include <stdio.h>

%%{
  machine adcpEngine;

  action processCompleteMessage { /*do something*/ }

  action clearAll {samplesPerBlock=0; dataOffset=0;}

  action clearTemp {temp=0; tempMultiplier=0;}

  action accumTemp {temp = temp + (fc << tempMultiplier); tempMultiplier += 8; }

  action storeData { sampleData[dataOffset++]=temp; }

  action dataRemaining { dataOffset < samplesPerBlock }

  action storeSamplesPerBlock { samplesPerBlock=temp; }

  Word16b = extend{2} > clearTemp $ accumTemp ;

  dataBlock = 0 Word16b @storeSamplesPerBlock (Word16b @storeData)* when dataRemaining @processCompleteMessage ;

  main := (dataBlock >clearAll)** ;

  alphtype unsigned char;

  write data;
 
}%%


void main()
{
	//for ragel
	int cs;
	unsigned char *p;
	unsigned char *pe;

	unsigned short int samplesPerBlock;
	unsigned short int sampleData[600];
	unsigned short int dataOffset;
	unsigned long int temp;
	unsigned long int tempMultiplier;
	unsigned char testData[] = {
		// block 0
		0x00,
		0x03, 0x00, // samples per block (little-endian 16-bit)
		0x01, 0x00, // sample 0 == 0x0001
		0x02, 0x00, // sample 1 == 0x0002
		0x03, 0x00, // etc...
		// block 1
		0x00,
		0x03, 0x00,
		0x04, 0x00,
		0x05, 0x00,
		0x06, 0x00,
	};
	unsigned short int testDataIndex;

	%%write init;

	for (testDataIndex = 0; testDataIndex<sizeof(testData); testDataIndex++)
	{
		p = &testData[testDataIndex];
		pe = &testData[testDataIndex]+sizeof(testData[0]);

		%%write exec;
	}
}

