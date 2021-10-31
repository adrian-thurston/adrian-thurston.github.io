# line 1 "atoi1_ruby.rl"
#
# @LANG: ruby
# @GENERATED: yes
#

	# line 29 "atoi1_ruby.rl"


	
# line 12 "atoi1_ruby.rb"
class << self
	attr_accessor :_atoi_actions
	private :_atoi_actions, :_atoi_actions=
end
self._atoi_actions = [
	0, 1, 0, 1, 2, 2, 0, 1, 
	2, 0, 2, 2, 3, 4
]

class << self
	attr_accessor :_atoi_key_offsets
	private :_atoi_key_offsets, :_atoi_key_offsets=
end
self._atoi_key_offsets = [
	0, 0, 4, 6, 9
]

class << self
	attr_accessor :_atoi_trans_keys
	private :_atoi_trans_keys, :_atoi_trans_keys=
end
self._atoi_trans_keys = [
	43, 45, 48, 57, 48, 57, 10, 48, 
	57, 0
]

class << self
	attr_accessor :_atoi_single_lengths
	private :_atoi_single_lengths, :_atoi_single_lengths=
end
self._atoi_single_lengths = [
	0, 2, 0, 1, 0
]

class << self
	attr_accessor :_atoi_range_lengths
	private :_atoi_range_lengths, :_atoi_range_lengths=
end
self._atoi_range_lengths = [
	0, 1, 1, 1, 0
]

class << self
	attr_accessor :_atoi_index_offsets
	private :_atoi_index_offsets, :_atoi_index_offsets=
end
self._atoi_index_offsets = [
	0, 0, 4, 6, 9
]

class << self
	attr_accessor :_atoi_trans_targs_wi
	private :_atoi_trans_targs_wi, :_atoi_trans_targs_wi=
end
self._atoi_trans_targs_wi = [
	2, 2, 3, 0, 3, 0, 4, 3, 
	0, 0, 0
]

class << self
	attr_accessor :_atoi_trans_actions_wi
	private :_atoi_trans_actions_wi, :_atoi_trans_actions_wi=
end
self._atoi_trans_actions_wi = [
	1, 5, 8, 0, 3, 0, 11, 3, 
	0, 0, 0
]

class << self
	attr_accessor :atoi_start
end
self.atoi_start = 1;
class << self
	attr_accessor :atoi_first_final
end
self.atoi_first_final = 4;
class << self
	attr_accessor :atoi_error
end
self.atoi_error = 0;

class << self
	attr_accessor :atoi_en_main
end
self.atoi_en_main = 1;

# line 32 "atoi1_ruby.rl"

	def run_machine( data )
		p = 0
		pe = data.length
		eof = data.length
		cs = 0;
	neg = false;
	val = 0;
		val = 0;
		neg = false;

		
# line 112 "atoi1_ruby.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = atoi_start
end
# line 44 "atoi1_ruby.rl"
		
# line 120 "atoi1_ruby.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _atoi_key_offsets[cs]
	_trans = _atoi_index_offsets[cs]
	_klen = _atoi_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _atoi_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _atoi_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _atoi_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _atoi_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _atoi_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	cs = _atoi_trans_targs_wi[_trans]
	if _atoi_trans_actions_wi[_trans] != 0
		_acts = _atoi_trans_actions_wi[_trans]
		_nacts = _atoi_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _atoi_actions[_acts - 1]
when 0 then
# line 8 "atoi1_ruby.rl"
		begin

	        neg = false;
	        val = 0;
	    		end
# line 8 "atoi1_ruby.rl"
when 1 then
# line 12 "atoi1_ruby.rl"
		begin

	        neg = true;
	    		end
# line 12 "atoi1_ruby.rl"
when 2 then
# line 15 "atoi1_ruby.rl"
		begin

	        val = val * 10 + (data[p] - 48);
	    		end
# line 15 "atoi1_ruby.rl"
when 3 then
# line 18 "atoi1_ruby.rl"
		begin

	        if neg
	            val = - 1 * val;
	        end
	    		end
# line 18 "atoi1_ruby.rl"
when 4 then
# line 23 "atoi1_ruby.rl"
		begin

	        print(val);
	        print("\n");
	    		end
# line 23 "atoi1_ruby.rl"
# line 239 "atoi1_ruby.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end
# line 45 "atoi1_ruby.rl"
		if cs >= atoi_first_final
			puts "ACCEPT"
		else
			puts "FAIL"
		end
	end

	inp = [
		"1\n",
		"12\n",
		"222222\n",
		"+2123\n",
		"213 3213\n",
		"-12321\n",
		"--123\n",
		"-99\n",
		" -3000\n",
	]

	inplen = 9;

	inp.each { |str| 
		run_machine(str.unpack("c*"))
	}

=begin _____OUTPUT_____
1
ACCEPT
12
ACCEPT
222222
ACCEPT
2123
ACCEPT
FAIL
-12321
ACCEPT
FAIL
-99
ACCEPT
FAIL
=end _____OUTPUT_____
