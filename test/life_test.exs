defmodule LifeTest do
  use ExUnit.Case
  doctest Life
  def get do
    receive do
      x -> x
    end
  end

  test "the spot is occupied or not" do
    map = [{:pos, 0,0}, {:pos, 1,0}]
    assert :world.is_occupied([], 0) == :false
    assert :world.is_occupied(map, {:pos, 0, 0}) == :true
    assert :world.is_occupied(map, {:pos, 100, 100}) == :false
  end

  test "position equality" do
    assert :world.pos_eq({:pos, 0, 0}, {:pos, 0, 0}) == :true
    assert :world.pos_eq({:pos, 0, 0}, {:pos, 1, 0}) == :false
  end

  test "point arithmetic" do
    assert :world.add_point({:pos, 0, 0}, {:pos, 0, 0}) == {:pos, 0, 0}
    assert :world.add_point({:pos, 0, 0}, {:pos, 1, 1}) == {:pos, 1, 1}
    assert :world.add_point({:pos, 1, 1}, {:pos, -1, -1}) == {:pos, 0, 0}
    assert :world.add_point({:pos, 1, 1}, {:pos, 1, 1}) == {:pos, 2, 2}
  end

  test "point in map" do
    assert :world.pos_in_map({:pos, 0, 0}) == :true
    assert :world.pos_in_map({:pos, 100, 100}) == :true
    assert :world.pos_in_map({:pos, 101, 101}) == :false
    assert :world.pos_in_map({:pos, -1, 0}) == :false
  end

  test "move in dir" do
    assert :world.move({:pos, 0, 0}, :up) == {:pos, -1, 0}
    assert :world.move({:pos, 0, 0}, :down) == {:pos, 1, 0}
    assert :world.move({:pos, 0, 0}, :left) == {:pos, 0, -1}
    assert :world.move({:pos, 0, 0}, :right) == {:pos, 0, 1}
  end

  test "can deal with one entity" do
    e = spawn fn -> :world.entity(:foo, 0, {:pos, 0, 0}) end
    send(e, {self(), {:get, :pos}})
    receive do
      {:ok, {:pos, 0, 0}} -> assert :true
      _ -> assert :false
    end

    send(e, {self(), {:get, :age}})
    receive do
      {:ok, 0} -> assert :true
      _ -> assert :false
    end

    send(e, {self(), {:action, :do_one_turn}})
    send(e, {self(), {:get, :pos}})
    receive do
      {:ok, {:pos, 0, 0}} -> assert :false
      {:ok, {:pos, _, _}} -> assert :true
      _ -> assert :false
    end
  end

  test "can modify state" do
    w = spawn fn -> :world.world([]) end
    send(w, {self(), {:new_entity, :bar, {:pos, 0, 0}}})
    send(w, {self(), {:get, :state}})
    {:ok, state} = get()
    assert length(state) == 1

    send(w, {self(), {:new_entity, :bar, {:pos, 0, 0}}})
    send(w, {self(), {:get, :state}})
    {:ok, state} = get()
    assert length(state) == 2

    send(w, {self(), {:debug}})
    # We get back 2 things.
    {:ok, _state} = get()
    {:ok, _state} = get()
  end
end
