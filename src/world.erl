-module(world).

-compile(export_all).

make() ->
    [].

make(X, Y) ->
    X+Y.

-record(entity, {type, age, health, pos}).

make_entity(Type) ->
    #entity{type=Type, age=0, health=100, pos={pos, 0, 0}}.

add_entity(L, E) ->
    L ++ [E].

entity_at([], _) ->
    none;
entity_at([E|Es], Pt) ->
    Eq = pos_eq(E, Pt),
    if
	Eq ->
	    E;
	true ->
	    entity_at(Es, Pt)
    end.

is_occupied([], _) ->
    false;    
is_occupied([M|Ms], Pt) ->
    Eq = pos_eq(Pt, M),
    if 
	Eq ->
	    true;
	true ->
	    is_occupied(Ms, Pt)
    end.

pos_eq(Pos1, Pos2) ->
    {pos, X,Y} = Pos1,
    {pos, X1, Y1} = Pos2,
    X == X1 andalso Y == Y1.
    

add_point(Pt1, Pt2) ->
    {pos, X,Y} = Pt1,
    {pos, X1, Y1} = Pt2,
    {pos, X+X1, Y+Y1}.
