# MapSet Dialyzer Repro

Minimal reproduction for `MapSet` Dialyzer opacity warnings introduced by
Elixir 1.20. OTP 29 is not required to reproduce it.

## Reproduction

This repository defaults to Elixir 1.20.0-rc.5 on OTP 29:

```sh
elixir --version
```

Expected relevant version shape:

```text
Elixir 1.20.0-rc.5 ... Erlang/OTP 29
```

Run:

```sh
mix deps.get
mix dialyzer
```

## Version Matrix

Verified results:

| Elixir | Erlang/OTP | Result |
| --- | --- | --- |
| 1.20.0-rc.5 | 29 | Reproduces |
| 1.20.0-rc.5 | 28.5 | Reproduces |
| 1.19.5 | 28.5 | Does not reproduce |

The reproducing code is in `lib/demo.ex`:

```elixir
def contains?(ids, id) do
  id_set = MapSet.new(ids)
  MapSet.member?(id_set, id)
end
```

Dialyzer reports `id_set` as `%MapSet{:map => map()}` and rejects it as the first
argument to `MapSet.member?/2`, whose implementation expects a `MapSet.t()` with
opaque `:sets.set(_)` internals.
