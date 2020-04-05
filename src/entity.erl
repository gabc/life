-module(entity).
-behaviour(gen_server).

-export([start_link/0]).
-export([alloc/0, free/1]).
-export([init/1, handle_call/3, handle_cast/2]).

-compile(export_all).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

alloc() ->
    gen_server:call(entity, alloc).

alloc(_A) ->
    gen_server:call(entity, alloc).

free(Entity) ->
    gen_server:cast(entity, {free, Entity}).

free(Entity, _) ->
    gen_server:cast(entity, {free, Entity}).

init({Type, Age, Pos}) ->
    {ok, {Type, Age, Pos}}.

state(Entity) ->
    gen_server:call(entity, {state, Entity}).

handle_call(state, _From, Entities) ->
    {reply, Entities, Entities};

handle_call(alloc, _From, Entities) ->
    {Entity, Entities2} = alloc(Entities),
    {reply, Entity, Entities2};

handle_call(do_thing, _From, Entities) ->
    {reply, 3, Entities}.
    
handle_cast({free, Entity}, Entities) ->
    Entities2 = free(Entity, Entities),
    {noreply, Entities2}.
