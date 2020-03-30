-module(world).

-compile(export_all).

make() ->
    [].

make(X, Y) ->
    X+Y.

-record(entity, {type, age, health, pos}).

add_entity(L, E) ->
    L ++ [E].

is_occupied([], _) ->
    false;    
is_occupied([M|Ms], Pt) ->
    {pos, X,Y} = Pt,
    {pos, X1, Y1} = M,
    if 
	X == X1 andalso Y == Y1 ->
	    true;
	true ->
	    is_occupied(Ms, Pt)
    end.

add_point(Pt1, Pt2) ->
    {pos, X,Y} = Pt1,
    {pos, X1, Y1} = Pt2,
    {pos, X+X1, Y+Y1}.
