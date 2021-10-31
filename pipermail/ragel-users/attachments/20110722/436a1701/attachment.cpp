
#line 1 "checker.rl"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <iostream>

using namespace std;


#line 2 "checker.cpp"
static const char _foo_actions[] = {
	0, 1, 0
};

static const char _foo_key_offsets[] = {
	0, 0, 2
};

static const char _foo_trans_keys[] = {
	48, 57, 48, 57, 0
};

static const char _foo_single_lengths[] = {
	0, 0, 0
};

static const char _foo_range_lengths[] = {
	0, 1, 1
};

static const char _foo_index_offsets[] = {
	0, 0, 2
};

static const char _foo_trans_targs[] = {
	2, 0, 2, 0, 0
};

static const char _foo_trans_actions[] = {
	0, 0, 1, 0, 0
};

static const char _foo_eof_actions[] = {
	0, 0, 1
};

static const int foo_start = 1;
static const int foo_first_final = 2;

static const int foo_en_main = 1;


#line 11 "checker.rl"


void parse(char * str)
{
  char *p = str; // data pointer
  char *pe = str + strlen(str); // past end
  int cs;        // machine state
  int len = 0;
  char token[1024];

  
#line 43 "checker.cpp"
	{
	cs = foo_start;
	}

#line 46 "checker.cpp"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_keys = _foo_trans_keys + _foo_key_offsets[cs];
	_trans = _foo_index_offsets[cs];

	_klen = _foo_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (unsigned int)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _foo_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += (unsigned int)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	cs = _foo_trans_targs[_trans];

	if ( _foo_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _foo_actions + _foo_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
#line 27 "checker.rl"
	{
      token[len] = '\0';
	  int digit = (*p) - '0';
      std::cout << "[DIGITS:" << digit << "]";
      len = 0;
    }
	break;
#line 126 "checker.cpp"
		}
	}

_again:
	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	const char *__acts = _foo_actions + _foo_eof_actions[cs];
	unsigned int __nacts = (unsigned int) *__acts++;
	while ( __nacts-- > 0 ) {
		switch ( *__acts++ ) {
	case 0:
#line 27 "checker.rl"
	{
      token[len] = '\0';
	  int digit = (*p) - '0';
      std::cout << "[DIGITS:" << digit << "]";
      len = 0;
    }
	break;
#line 149 "checker.cpp"
		}
	}
	}

	_out: {}
	}

#line 56 "checker.rl"


  printf("\n");
}

int main()
{
  parse("12");
}