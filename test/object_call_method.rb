mobiruby_test "Cocoa::object call method" do
  # call class method
  result1 = Cocoa::MobiCocoaTest1._classMethod1
  assert result1.is_a?(Cocoa::Object)
  assert_equal "classMethod1Test", result1._UTF8String.to_s
  
  # create instance
  test1 = Cocoa::MobiCocoaTest1._alloc._init
  assert test1.is_a?(Cocoa::Object)
  
  # call instance method
  result = test1._intToString(CFunc::Int(10))
  assert_equal "value=10", result._UTF8String.to_s
  
  # call instance method with mruby value
  result = test1._uint16ToString(CFunc::SInt8(-1))
  assert_equal "value=255", result._UTF8String.to_s

  # call with block
  block = Cocoa::Block.new(CFunc::Int, [CFunc::Int]) { |i|
    i.value + 1
  }
  test1 = Cocoa::MobiCocoaTest1._alloc._init
  result = test1._testBlocks1 block
  assert_equal 12, result.value
  
  # call with block
  block = Cocoa::Block.new(CFunc::Int, [CFunc::Int]) { |i|
    i.value + 1
  }
  test1 = Cocoa::MobiCocoaTest1._alloc._init
  result = test1._testBlocks2 block
  assert_equal 12, result.value
end
