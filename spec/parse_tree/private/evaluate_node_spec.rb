require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, "#evaluate_node" do
  before(:each) do
    @parse_tree = Cry::ParseTree.new
  end
  
  it "should be nil if the node is nil" do
    @parse_tree.send(:evaluate_node, nil).should be_nil
  end
  
  it "should be nil if the node is an uninitialized Cry::ParseTree" do
    @parse_tree.send(:evaluate_node, Cry::ParseTree.new).should be_nil
  end
  
  it "should be the evaluated node if the everything is a terminal" do
    @parse_tree.send(:evaluate_node, Cry::ParseTree.new(:+, 1, 2)).should == 3
  end
  
  it "should be the recursively evaluated node if something is a Cry::ParseTree" do
    @parse_tree.send(:evaluate_node, Cry::ParseTree.new(:+, Cry::ParseTree.new(:+, 1, 2), 2)).should == 5
  end
end