defmodule Demo do
  @moduledoc """
  Minimal reproduction for MapSet Dialyzer opacity warnings on Elixir 1.20 / OTP 29.
  """

  def contains?(ids, id) do
    id_set = MapSet.new(ids)

    MapSet.member?(id_set, id)
  end
end
