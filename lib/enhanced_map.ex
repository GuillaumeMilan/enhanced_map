defmodule EnhancedMap do
  @moduledoc """
  Provide additional features to handle some specific cases more easily.
  """


  @doc """
  This macro provide a simple way to handle keys verification inside a map. This can also be used inside a pattern match.

  ## Examples

      iex> require EnhancedMap
      iex> EnhancedMap.has_keys(%{toto: nil, titi: nil}, [:toto, :titi])
      true

      iex> require EnhancedMap
      iex> EnhancedMap.has_keys(%{toto: nil, titi: nil}, [:toto, :titi, :tata])
      false

      iex> require EnhancedMap
      iex> case %{toto: nil, titi: nil} do
      ...>   map when EnhancedMap.has_keys(map, [:toto, :titi, :tata]) -> :will_not_match
      ...>   map when EnhancedMap.has_keys(map, [:toto, :titi]) -> :will_match
      iex> end
      :will_match
  """
  defmacro has_keys(term, keys) do
    keys = EnhancedMap.Utils.do_walk(keys, __CALLER__)

    keys
    |> Enum.map(fn k ->
      quote do
        :erlang.is_map_key(unquote(k), unquote(term))
      end
    end)
    |> EnhancedMap.Utils.and_join()
  end
end
