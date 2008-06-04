require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, "#node_method" do
  it "should be nil if the list is empty" do
    Cry::ParseTree.new.node_method.should be_nil
  end
  
  it "should be the first element as a symbol if the list has one element" do
    Cry::ParseTree.new("self").node_method.should == :self
  end
  
  it "should be the first element as a symbol if the list has more than one element" do
    Cry::ParseTree.new(:+, 1, 2).node_method.should == :+
  end
end

describe Cry::ParseTree, "#node_method=" do
  it "should be able to set on a new Cry::ParseTree" do
    parse_tree = Cry::ParseTree.new
    parse_tree.node_method = :+
    parse_tree.node_method.should == :+
  end
  
  it "should be able to set when node_method is nil" do
    parse_tree = Cry::ParseTree.new(nil, 1, 2)
    parse_tree.node_method = :+
    parse_tree.node_method.should == :+
  end
  
  it "should be able to set when node_method is already set" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_method = :*
    parse_tree.node_method.should == :*
  end
end