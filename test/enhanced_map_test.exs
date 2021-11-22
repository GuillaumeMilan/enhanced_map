defmodule EnhancedMapTest do
  use ExUnit.Case
  doctest EnhancedMap

  test "validate map that has just keys" do
    require EnhancedMap
    assert EnhancedMap.has_keys(%{toto: nil, titi: nil}, [:toto, :titi])
  end

  test "validate map that has more keys" do
    require EnhancedMap
    assert EnhancedMap.has_keys(%{toto: nil, titi: nil, tata: nil}, [:toto, :titi])
  end

  test "validate map that miss some keys" do
    require EnhancedMap

    assert not EnhancedMap.has_keys(%{toto: nil, titi: nil, tata: nil}, [
             :toto,
             :titi,
             :tata,
             :tutu
           ])
  end

  test "validate guard behavior" do
    require EnhancedMap

    res =
      case %{toto: nil, titi: nil, tata: nil} do
        map when EnhancedMap.has_keys(map, [:toto, :titi, :tata]) -> true
        _ -> false
      end

    assert res
  end

  test "validate guard behavior in module" do
    assert EnhancedMapTest.WithAttributes.proceed_attribute_keys_test()
  end

  test "validate concatenation" do
    assert EnhancedMapTest.WithAttributes.proceed_concat_keys_test()
  end

  test "validate comprehension" do
    assert EnhancedMapTest.WithAttributes.proceed_comprehension_keys_test()
  end

  test "validate when key is map" do
    assert EnhancedMap.has_keys(%{%{} => nil}, [%{}])
  end
end
