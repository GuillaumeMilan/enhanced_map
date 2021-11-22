defmodule EnhancedMap.Utils do
  @moduledoc false

  def and_join([g]) do
    g
  end

  def and_join([g1, g2 | rest]) do
    and_join([
      quote do
        unquote(g1) and unquote(g2)
      end
      | rest
    ])
  end

  def do_walk(keys, caller) do
    Macro.prewalk(keys, fn
      {:@, _, [{attribute, _, nil}]} ->
        do_walk(Macro.escape(Module.get_attribute(caller.module, attribute)), caller)

      {:++, _, [list1, list2]} ->
        do_walk(list1, caller) ++ do_walk(list2, caller)
      list when is_list(list) ->
        case Enum.reverse(list) do
          [{:|, _, [elem, list]}| rem] ->
            Enum.reverse(do_walk(rem, caller)) ++ [do_walk(elem, caller) | do_walk(list, caller)]
          l -> l
        end
      o ->
        o
    end)
  end
end
