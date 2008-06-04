require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, "#node_object" do
  it "should be nil if the list is empty" do
    Cry::ParseTree.new.node_object.should be_nil
  end
  
  it "should be nil if the list has one element" do
    Cry::ParseTree.new(:self).node_object.should be_nil
  end
  
  it "should be the second element if the list has more than one element, and it is a terminal" do
    Cry::ParseTree.new(:+, 1, 2).node_object.should == 1
  end
  
  it "should be the second element if the list has more than one element, and it is a Cry::ParseTree" do
    Cry::ParseTree.new(:+, Cry::ParseTree.new(:+, 1, 2), 2).node_object.should == [:+, 1, 2]
  end
end

describe Cry::ParseTree, "#node_object=" do
  it "should be able to set on a new Cry::ParseTree" do
    parse_tree = Cry::ParseTree.new
    parse_tree.node_object = 1
    parse_tree.node_object.should == 1
  end
  
  it "should be able to set when node_object is nil" do
    parse_tree = Cry::ParseTree.new(:+, nil, 2)
    parse_tree.node_object = 1
    parse_tree.node_object.should == 1
  end
  
  it "should be able to set when node_object is already set" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_object = 4
    parse_tree.node_object.should == 4
  end
  
  it "should be able to set with a Cry::ParseTree" do
    parse_tree = Cry::ParseTree.new(:+, nil, 2)
    parse_tree.node_object = Cry::ParseTree.new
    parse_tree.node_object.should == Cry::ParseTree.new
  end
end