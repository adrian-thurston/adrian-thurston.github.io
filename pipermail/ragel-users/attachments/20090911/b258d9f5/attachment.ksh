
/* #line 1 "problemDemo.rl" */
#include <stdio.h>


/* #line 2 "problemDemo.cpp" */
static const char _adcpEngine_actions[] = {
	0, 1, 1, 2, 2, 3, 2, 3, 
	5, 3, 3, 4, 0
};

static const char _adcpEngine_cond_offsets[] = {
	0, 0, 0, 0, 1, 1
};

static const char _adcpEngine_cond_lengths[] = {
	0, 0, 0, 1, 0, 1
};

static const short _adcpEngine_cond_keys[] = {
	0u, 255u, 0u, 255u, 0
};

static const char _adcpEngine_cond_spaces[] = {
	0, 0, 0
};

static const char _adcpEngine_key_offsets[] = {
	0, 0, 0, 0, 2, 3
};

static const short _adcpEngine_trans_keys[] = {
	512u, 767u, 0u, 256u, 512u, 767u, 0
};

static const char _adcpEngine_single_lengths[] = {
	0, 0, 0, 0, 1, 1
};

static const char _adcpEngine_range_lengths[] = {
	0, 0, 0, 1, 0, 1
};

static const char _adcpEngine_index_offsets[] = {
	0, 0, 1, 2, 4, 6
};

static const char _adcpEngine_trans_targs[] = {
	2, 5, 5, 0, 1, 0, 1, 3, 
	0, 0
};

static const char _adcpEngine_trans_actions[] = {
	3, 6, 9, 0, 1, 0, 1, 3, 
	0, 0
};

static const int adcpEngine_start = 4;
static const int adcpEngine_first_final = 4;
static const int adcpEngine_error = 0;

static const int adcpEngine_en_main = 4;


/* #line 30 "problemDemo.rl" */



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

	
/* #line 59 "problemDemo.cpp" */
	{
	cs = adcpEngine_start;
	}

/* #line 62 "problemDemo.rl" */

	for (testDataIndex = 0; testDataIndex<sizeof(testData); testDataIndex++)
	{
		p = &testData[testDataIndex];
		pe = &testData[testDataIndex]+sizeof(testData[0]);

		
/* #line 62 "problemDemo.cpp" */
	{
	int _klen;
	unsigned int _trans;
	short _widec;
	const char *_acts;
	unsigned int _nacts;
	const short *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_widec = (*p);
	_klen = _adcpEngine_cond_lengths[cs];
	_keys = _adcpEngine_cond_keys + (_adcpEngine_cond_offsets[cs]*2);
	if ( _klen > 0 ) {
		const short *_lower = _keys;
		const short *_mid;
		const short *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( _widec < _mid[0] )
				_upper = _mid - 2;
			else if ( _widec > _mid[1] )
				_lower = _mid + 2;
			else {
				switch ( _adcpEngine_cond_spaces[_adcpEngine_cond_offsets[cs] + ((_mid - _keys)>>1)] ) {
	case 0: {
		_widec = (short)(256u + ((*p) - 0u));
		if ( 
/* #line 16 "problemDemo.rl" */
 dataOffset < samplesPerBlock  ) _widec += 256;
		break;
	}
				}
				break;
			}
		}
	}

	_keys = _adcpEngine_trans_keys + _adcpEngine_key_offsets[cs];
	_trans = _adcpEngine_index_offsets[cs];

	_klen = _adcpEngine_single_lengths[cs];
	if ( _klen > 0 ) {
		const short *_lower = _keys;
		const short *_mid;
		const short *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( _widec < *_mid )
				_upper = _mid - 1;
			else if ( _widec > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _adcpEngine_range_lengths[cs];
	if ( _klen > 0 ) {
		const short *_lower = _keys;
		const short *_mid;
		const short *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( _widec < _mid[0] )
				_upper = _mid - 2;
			else if ( _widec > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += ((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	cs = _adcpEngine_trans_targs[_trans];

	if ( _adcpEngine_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _adcpEngine_actions + _adcpEngine_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
/* #line 6 "problemDemo.rl" */
	{ /*do something*/ }
	break;
	case 1:
/* #line 8 "problemDemo.rl" */
	{samplesPerBlock=0; dataOffset=0;}
	break;
	case 2:
/* #line 10 "problemDemo.rl" */
	{temp=0; tempMultiplier=0;}
	break;
	case 3:
/* #line 12 "problemDemo.rl" */
	{temp = temp + ((*p) << tempMultiplier); tempMultiplier += 8; }
	break;
	case 4:
/* #line 14 "problemDemo.rl" */
	{ sampleData[dataOffset++]=temp; }
	break;
	case 5:
/* #line 18 "problemDemo.rl" */
	{ samplesPerBlock=temp; }
	break;
/* #line 183 "problemDemo.cpp" */
		}
	}

_again:
	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	_out: {}
	}

/* #line 69 "problemDemo.rl" */
	}
}

