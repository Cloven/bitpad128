-module(bit_example).

-export([bmake128/1,test/0]).

-spec bmake128(Bin :: binary() | bitstring()) -> binary().
bmake128(Bin) when bit_size(Bin) > 128 ->
  btrunc(Bin, 128);
bmake128(Bin) when bit_size(Bin) < 128 ->
  brpad(Bin, 128);
bmake128(Bin) ->
  Bin.

-spec btrunc(Bin :: binary() | bitstring(), Size :: integer()) -> binary().
btrunc(Bin, Size) ->
  <<Save:Size/bitstring, _Rest/bitstring>> = Bin,
  Save.

-spec brpad(Bin :: binary() | bitstring(), Pad :: pos_integer()) -> binary().
brpad(Bin, Pad) ->
  BinSize = bit_size(Bin),
  Difference = Pad - BinSize,
  <<Bin/bitstring, 0:Difference>>.

test() ->
  X = <<1:128>>,
  A = bmake128(X),
  io:format("~p ~p~n",[A,bit_size(A)]),
  Y = <<1:53>>,
  B = bmake128(Y),
  io:format("~p ~p~n",[B,bit_size(B)]),
  Z = <<1:1>>,
  C = bmake128(Z),
  io:format("~p ~p~n",[C,bit_size(C)]).
