defmodule LifeTest do
  use ExUnit.Case
  doctest Life

  test "greets the world" do
    assert Life.hello() == :world
    assert :foo.bar(0) == 0
  end

  test "the spot is occupied or not" do
    map = [{:pos, 0,0}, {:pos, 1,0}]
    assert :world.is_occupied([], 0) == :false
    assert :world.is_occupied(map, {:pos, 0, 0}) == :true
    assert :world.is_occupied(map, {:pos, 100, 100}) == :false
  end
end
