require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, "#inspect, distinguishing itself from Array#inspect" do
  it "should use parantheses instead of brackets" do
    p = Cry::ParseTree.new(:+, 1, 2)
    p.inspect.should == "(:+, 1, 2)"
  end
  
  it "should work with Arrays" do
    p = Cry::ParseTree.new(:+, 1, [2, 3])
    p.inspect.should == "(:+, 1, [2, 3])"
  end
  
  it "should work with nested Cry::ParseTrees" do
    p = Cry::ParseTree.new(:+, 1, Cry::ParseTree.new(:+, 2, 3))
    p.inspect.should == "(:+, 1, (:+, 2, 3))"
  end
end