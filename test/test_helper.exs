ExUnit.start()

defmodule EnhancedMapTest.WithAttributes do
  require EnhancedMap
  @mandatory_keys [:toto, :titi, :tata]

  def proceed_attribute_keys_test do
    case %{toto: nil, titi: nil, tata: nil} do
      map when EnhancedMap.has_keys(map, @mandatory_keys) -> true
      _ -> false
    end
  end

  def proceed_concat_keys_test do
    case %{toto: nil, titi: nil, tata: nil, tutu: nil} do
      map when EnhancedMap.has_keys(map, @mandatory_keys ++ [:tutu]) -> true
      _ -> false
    end
  end

  def proceed_comprehension_keys_test do
    case %{toto: nil, titi: nil, tata: nil, tutu: nil} do
      map when EnhancedMap.has_keys(map, [:tutu | @mandatory_keys]) -> true
      _ -> false
    end
  end

  def proceed_multi_comprehension_keys_test do
    case %{toto: nil, titi: nil, tata: nil, tutu: nil, tyty: nil} do
      map when EnhancedMap.has_keys(map, [:tutu, :tyty | @mandatory_keys]) -> true
      _ -> false
    end
  end
end
