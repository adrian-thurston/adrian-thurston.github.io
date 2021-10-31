#include <stdlib.h>
#include <stdio.h>
#include <libdaemon/daemon.h> 

#include "enum_fsm.h"

%%{
	machine Enumerator;
	access state->;
	
	include Enumerator "enum_fsm_actions.rl";

	new_session_complete='C';
	new_session_incomplete='I';
	complete_session_table='T';
	session_table_empty='E';
	new_session='N';	
	unack_discover='D';
	block_timeout='b';
	hello_timeout='h';
	hello='1';

### state chart
	Enumerator = (
## label "start" indicate our starting state
		start:
		Quiescent: ( unack_discover -> Pausing |
		    new_session_complete -> Wait
		),

		Pausing: ( new_session -> Pausing |
		    hello -> Pausing |
		    hello_timeout -> Pausing |
		    block_timeout -> Pausing |
		    session_table_empty -> Quiescent |
		    complete_session_table -> Wait
		),

		Wait: ( session_table_empty -> Quiescent |
		     new_session_incomplete -> Pausing
		)
	    ) >begin @!error;

	main := ( Enumerator % { daemon_log(LOG_INFO, "Enumerator FSM finished."); } ) *;
}%%

%% write data;

int Enumerator_init(Enumerator *state)
{
//  assert_mem(state);
//  assert(state->next == NULL && "attempt to init an active state");

  %% write init;
  
  return 1;
}

inline int Enumerator_invariant(Enumerator *state, Enum_Event event)
{
//  assert_mem(state);

  if ( state->cs == Enumerator_error ) {
    daemon_log(LOG_ERR, "Error in connection state with event '%c'", event);
    return -1;
  }

  if ( state->cs >= Enumerator_first_final )
    return 1;
  
  return 0;
}

int Enumerator_done(Enumerator *state)
{
//  assert_mem(state);
  return state->cs == Enumerator_error || state->cs == Enumerator_first_final;
}

int Enumerator_exec(Enumerator *state, Enum_Event event)
{
//  assert_mem(state);

  const char * p = (const char *) & event;
  const char * pe = p + 1;

  if(Enumerator_done(state)) return -1; 

  %% write exec;

  return Enumerator_invariant(state, event);
}

int Enumerator_finish(Enumerator *state)
{
//  assert_mem(state);

  int rc = Enumerator_invariant(state, 0);


  return rc; 
}

