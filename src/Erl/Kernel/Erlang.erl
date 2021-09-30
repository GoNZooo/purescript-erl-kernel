-module(erl_kernel_erlang@foreign).

-export([ makeRef/0
        , sleep/1
        , utcNowMs/0
        , vmNowMs/0
        , utcNowUs/0
        , vmNowUs/0
        , termToString/1
        , eqFfi/2
        , monitor/2
        , monotonicTime_/1
        , strictlyMonotonicInt_/1
        , currentTimeOffset_/1
        , nativeTimeToMilliseconds_/1
        ]).

makeRef() ->
  fun() ->
      make_ref()
  end.

sleep(Ms) ->
  fun() ->
      timer:sleep(Ms),
      unit
  end.

utcNowMs() ->
  fun() ->
      erlang:system_time(millisecond)
  end.

vmNowMs() ->
  fun() ->
      erlang:monotonic_time(millisecond)
  end.

utcNowUs() ->
  fun() ->
      erlang:system_time(microsecond)
  end.

vmNowUs() ->
  fun() ->
      erlang:monotonic_time(microsecond)
  end.

termToString(Term) ->
    iolist_to_binary(io_lib:format("~p.", [Term])).

eqFfi(A,B) -> A == B.

monitor(Type, Item) ->
  fun() ->
    erlang:monitor(Type, Item)
  end.

monotonicTime_(Ctor) ->
  fun() ->
      Ctor(erlang:monotonic_time())
  end.

strictlyMonotonicInt_(Ctor) ->
  fun() ->
    Ctor(erlang:unique_integer([monotonic]))
  end.

currentTimeOffset_(Ctor) ->
  fun() ->
    Ctor(erlang:time_offset())
  end.

nativeTimeToMilliseconds_(Time) ->
  erlang:convert_time_unit(Time, native, millisecond).
