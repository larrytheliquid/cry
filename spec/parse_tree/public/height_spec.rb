require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, "#height" do
  it "should be 0 for an uninitialized Cry::ParseTree" do
    Cry::ParseTree.new.height.should == 0
  end
  
  it "should be 1 for a Cry::ParseTree with only a method" do
    Cry::ParseTree.new(:to_s).height.should == 1
  end
  
  it "should be 2 for a Cry::ParseTree with a method and an object" do
    Cry::ParseTree.new(:to_s, 1).height.should == 2
  end
  
  it "should work with nil" do
    Cry::ParseTree.new(:to_s, nil).height.should == 2
  end    
  
  it "should compute height for a simple Cry::ParseTree with one parameter" do
    parse_tree = Cry::ParseTree.new(:+, 1, 2)
    parse_tree.height.should == 2
  end
  
  it "should compute height for a simple Cry::ParseTree with multiple parameters" do
    parse_tree = Cry::ParseTree.new(:new, Array, 2, 1)
    parse_tree.height.should == 2
  end
  
  it "should compute height for a simple nested Cry::ParseTree with a heavier left side" do
    parse_tree = Cry::ParseTree.new( :+, Cry::ParseTree.new(:*, 2, 2), 1 )            
    parse_tree.height.should == 3
  end
  
  it "should compute height for a simple nested Cry::ParseTree with a heavier right side" do
    parse_tree = Cry::ParseTree.new( :+, 1, Cry::ParseTree.new(:*, 2, 2) )            
    parse_tree.height.should == 3
  end
  
  it "should compute height for a complex nested Cry::ParseTree with a heavier left side" do
    parse_tree = Cry::ParseTree.new( :+, Cry::ParseTree.new(:*, 2, Cry::ParseTree.new(:*, 2, 2)), Cry::ParseTree.new(:*, 2, 2) )            
    parse_tree.height.should == 4
  end
  
  it "should compute height for a complex nested Cry::ParseTree with a heavier right side" do
    parse_tree = Cry::ParseTree.new( :+, Cry::ParseTree.new(:*, 2, 2), Cry::ParseTree.new(:*, Cry::ParseTree.new(:*, 2, 2), 2) )            
    parse_tree.height.should == 4
  end
  
  it "should compute height for a very complex nested Cry::ParseTree" do
    parse_tree = Cry::ParseTree.new( 
      :+, Cry::ParseTree.new(:+, 1, Cry::ParseTree.new(:+, 1, 2) ), 
        Cry::ParseTree.new(:+, Cry::ParseTree.new(:+, 1, 2), 
          Cry::ParseTree.new(:*, Cry::ParseTree.new(:+, 1, 2), 
            Cry::ParseTree.new(:+, 
              Cry::ParseTree.new(:+, 1, 
                Cry::ParseTree.new(:+, 1, 2)), 2) ) )
    )
    parse_tree.height.should == 7
  end
  
  it "should compute height for a non-binary tree" do
    parse_tree = Cry::ParseTree.new(
      :foobar, Object, 1, 2, Cry::ParseTree.new(:+, 
        Cry::ParseTree.new(:+, 1, 2), Cry::ParseTree.new(:+, 1, 
          Cry::ParseTree.new(:+, 1, 2))), 4)
          
    parse_tree.height.should == 5
  end
end