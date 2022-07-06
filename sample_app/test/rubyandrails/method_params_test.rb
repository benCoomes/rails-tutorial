class MethodParamsTest < ActiveSupport::TestCase
  test "must give labels to named params" do
    assert_raises(ArgumentError) do
      named_param_method(1, 2, 3, 4)
    end
    
    assert_raises(ArgumentError) do 
      named_param_method(1, two: 2, three: 3, four: 4)
    end

    r = named_param_method(one: 1, two: 2, three: 3, four: 4)
    assert_equal([1, 2, 3, 4], r)
  end

  test "order of named arguments does not matter" do
    r = named_param_method(four: 4, two: 2, three: 3, one: 1)
    assert_equal([1, 2, 3, 4], r)
  end

  test "named params do not accept hash" do
    hash = {:one => 1, :two => 2, :three => 3, :four => 4}
    assert_raises(ArgumentError) do
      named_param_method(hash)
    end
  end

  test "redefined methods are overwritten and params do not matter" do
    r = redefined_method
    assert_equal("third", r)
  end

  test "arguments are passed by reference" do
    original = "original"
    passed = "original"
    assert_equal(original, passed)

    returned = modifiying_method(passed)
    
    assert_not_equal(original, passed)
    assert_equal(passed, returned)
  end

  test "double splat takes arbirary args as hash" do
    hash = {:one => 1, :two => 2, :three => 3}
    r = double_splat_method(uno: 1, dos: 2, tres: 3)
    assert_equal([1, 2, 3], r)
  end

  test "double splat does not take unnamed hash" do
    hash = {:one => 1, :two => 2, :three => 3}
    assert_raises do
      r = double_splat_method(hash)
    end
  end

  test "double splat takes named hash" do
    hash = {:one => 1, :two => 2, :three => 3}
    r = double_splat_method(randomsymbol: hash)
    assert_equal([{:one => 1, :two => 2, :three => 3}], r)
  end

  test "double splat multiple hashes merges them" do
    h1 = {:dup_same => 0, :dup_diff => 1, :unique1 => 2}
    h2 = {:dup_same => 0, :dup_diff => 3, :unique2 => 4}
    
    r1 = double_splat_method(**h1, **h2)
    r2 = double_splat_method(**h2, **h1)
    
    assert_equal([0, 3, 2, 4], r1)
    assert_equal([0, 1, 4, 2], r2)
  end

  def named_param_method(one:, two:, three:, four:)
    return [one, two, three, four]
  end

  def redefined_method()
    "first"
  end

  def redefined_method()
    "second"
  end

  def redefined_method(param: "third")
    param
  end

  def modifiying_method(param)
    param.to_s.upcase!
  end

  def double_splat_method(**somehash)
    somehash.values
  end
end