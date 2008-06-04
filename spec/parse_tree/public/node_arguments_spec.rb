require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, "#node_arguments" do
  it "should be empty if the list is empty" do
    Cry::ParseTree.new.node_arguments.should be_empty
  end
  
  it "should be emtpy if the list has one element" do
    Cry::ParseTree.new(:self).node_arguments.should be_empty
  end
  
  it "should be empty if the list has two elements" do
    Cry::ParseTree.new(:to_s, 1).node_arguments.should be_empty
  end
  
  it "should return an Array" do
    Cry::ParseTree.new(:+, 1, 2).node_arguments.class.should == Array
  end
  
  it "should return the single element remainder if the list has more than two elements, and its elements only have terminals" do
    Cry::ParseTree.new(:+, 1, 2).node_arguments.should == [2]
  end
  
  it "should return the multiple element remainder if the list has more than two elements, and its elements only have terminals" do
    Cry::ParseTree.new(:new, Array, 2, 1).node_arguments.should == [2, 1]
  end
  
  it "should return the remainder of the elements if the list has more than two elements, and its elements have Cry::ParseTrees" do
    Cry::ParseTree.new(:new, Array, 2, Cry::ParseTree.new(:+, 1, 2)).node_arguments.should == [2, [:+, 1, 2]]
  end
end

describe Cry::ParseTree, "#node_arguments=" do
  it "should be able to set on a new Cry::ParseTree" do
    parse_tree = Cry::ParseTree.new
    parse_tree.node_arguments = [1]
    parse_tree.node_arguments.should == [1]
  end
  
  it "should be able to set when node_arguments is emtpy" do
    parse_tree = Cry::ParseTree.new(:+, 1)
    parse_tree.node_arguments = [2]
    parse_tree.node_arguments.should == [2]
  end
  
  it "should be able to set with a single object" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_arguments = 5
    parse_tree.node_arguments.should == [5]
  end
  
  it "should be able to set with a single element Array" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_arguments = [5]
    parse_tree.node_arguments.should == [5]
  end
  
  it "should be able to set with a multiple element Array" do
    parse_tree = Cry::ParseTree.new(:new, Array)
    parse_tree.node_arguments = [2, 1]
    parse_tree.node_arguments.should == [2, 1]
  end
  
  it "should be able to set when node_object is already set" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_arguments = [4]
    parse_tree.node_arguments.should == [4]
  end
  
  it "should be able to set with a Cry::ParseTree" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_arguments = Cry::ParseTree.new
    parse_tree.node_arguments.should == Cry::ParseTree.new
  end
  
  it "should be able to set with a Cry::ParseTree in an Array" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.node_arguments = [Cry::ParseTree.new]
    parse_tree.node_arguments.should == [Cry::ParseTree.new]
  end
  
  it "should be able to overwrite current arguments with a new Array, when more arguments are added" do
    parse_tree = Cry::ParseTree.new(:foobar, Object, 1, 2)
    parse_tree.node_arguments = [3, 4, 5]
    parse_tree.node_arguments.should == [3, 4, 5]
  end
  
  it "should be able to overwrite current arguments with a new Array, when less arguments are added" do
    parse_tree = Cry::ParseTree.new(:foobar, Object, 1, 2, 3)
    parse_tree.node_arguments = [4, 5]
    parse_tree.node_arguments.should == [4, 5]
  end
end