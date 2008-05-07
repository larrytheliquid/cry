require File.join(File.dirname(__FILE__), "..", "parse_tree")

describe ParseTree, "#nodes" do  
  it "should raise an Exception if not initialized" do
    lambda {ParseTree.new}.should raise_error
  end
  
  it "should return an arary of nodes when initialized" do
    ParseTree.new([{:+ => 1}, 2]).nodes.should == [{:+ => 1}, 2]
  end
  
  it "should be able to add nodes" do
    parse_tree = ParseTree.new([{:+ => 1}])
    parse_tree.nodes << 2
    parse_tree.nodes.should == [{:+ => 1}, 2]
  end
end

describe ParseTree, "#evaluate, with terminal parameters and objects" do
  it "should be able to evaluate an expression for a parse tree with no parameters" do
    parse_tree = ParseTree.new( [{:to_s => 1}] )            
    parse_tree.evaluate.should == "1"
  end
  
  it "should be able to evaluate an expression for a parse tree with a parameter" do
    parse_tree = ParseTree.new( [{:+ => 1}, 2] )            
    parse_tree.evaluate.should == 3
  end
  
  it "should be able to evaluate an expression for a parse tree with multiple parameters" do
    parse_tree = ParseTree.new( [{:new => Array}, 2, 1] )            
    parse_tree.evaluate.should == [1, 1]
  end
end

describe ParseTree, "#evaluate, with function parameters" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = ParseTree.new( [ {:+ => 1}, [{:* => 2}, 2] ] )            
    parse_tree.evaluate.should == 5
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = ParseTree.new( [ {:+ => 2}, [{:+ => 1}, [{:* => 2}, 2]] ] )                
    parse_tree.evaluate.should == 7
  end
end

describe ParseTree, "#evaluate, with function objects" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = ParseTree.new( [ {:+ => 1}, [{:* => 2}, 2] ] )            
    parse_tree.evaluate.should == 5
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = ParseTree.new( [ {:+ => 2}, [{:+ => 1}, [{:* => 2}, 2]] ] )                
    parse_tree.evaluate.should == 7
  end
end

describe ParseTree, "#evaluate, for complex mixed parameters" do
  it "should be able to evaluate" do
    parse_tree = ParseTree.new( 
      [{:+ => [{:+ => 1}, 2]}, 
        [{:+ => [{:+ => 1}, 2]}, 
          [{:* => [{:+ => 1}, 2]}, 
            [{:+ => 1}, 2]]]] 
    )           
    parse_tree.evaluate.should == 15
  end
end