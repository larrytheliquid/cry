require File.join(File.dirname(__FILE__), "..", "cry")

describe ParseTree, ".new" do
  it "should be a kind of Array" do
    ParseTree.new.should be_kind_of(Array)
  end
end

describe ParseTree, "#node_method" do
  it "should be nil if the list is empty" do
    ParseTree.new.node_method.should be_nil
  end
  
  it "should be the first element as a symbol if the list has one element" do
    ParseTree.new("self").node_method.should == :self
  end
  
  it "should be the first element as a symbol if the list has more than one element" do
    ParseTree.new(:+, 1, 2).node_method.should == :+
  end
end

describe ParseTree, "#node_object" do
  it "should be nil if the list is empty" do
    ParseTree.new.node_object.should be_nil
  end
  
  it "should be nil if the list has one element" do
    ParseTree.new(:self).node_object.should be_nil
  end
  
  it "should be the second element if the list has more than one element, and it is a terminal" do
    ParseTree.new(:+, 1, 2).node_object.should == 1
  end
  
  it "should be the second element if the list has more than one element, and it is a ParseTree" do
    ParseTree.new(:+, ParseTree.new(:+, 1, 2), 2).node_object.should == [:+, 1, 2]
  end
end

describe ParseTree, "#evaluate_node_object" do
  it "should be nil if the list is empty" do
    ParseTree.new.evaluate_node_object.should be_nil
  end
  
  it "should be nil if the list has one element" do
    ParseTree.new(:self).evaluate_node_object.should be_nil
  end
  
  it "should be the second element if the list has more than one element, and it is a terminal" do
    ParseTree.new(:+, 1, 2).evaluate_node_object.should == 1
  end
  
  it "should be the second element evaluated if the list has more than one element, and it is a ParseTree" do
    ParseTree.new(:+, ParseTree.new(:+, 1, 2), 2).evaluate_node_object.should == 3
  end
end

describe ParseTree, "#node_arguments" do
  it "should be empty if the list is empty" do
    ParseTree.new.node_arguments.should be_empty
  end
  
  it "should be emtpy if the list has one element" do
    ParseTree.new(:self).node_arguments.should be_empty
  end
  
  it "should be empty if the list has two elements" do
    ParseTree.new(:to_s, 1).node_arguments.should be_empty
  end
  
  it "should return the remainder of the elements if the list has more than two elements, and its elements only have terminals" do
    ParseTree.new(:new, Array, 2, 1).node_arguments.should == [2, 1]
  end
  
  it "should return the remainder of the elements if the list has more than two elements, and its elements have ParseTrees" do
    ParseTree.new(:new, Array, 2, ParseTree.new(:+, 1, 2)).node_arguments.should == [2, [:+, 1, 2]]
  end
end

describe ParseTree, "#evaluate_node_arguments" do
  it "should be empty if the list is empty" do
    ParseTree.new.evaluate_node_arguments.should be_empty
  end
  
  it "should be emtpy if the list has one element" do
    ParseTree.new(:self).evaluate_node_arguments.should be_empty
  end
  
  it "should be empty if the list has two elements" do
    ParseTree.new(:to_s, 1).evaluate_node_arguments.should be_empty
  end
  
  it "should return the remainder of the elements if the list has more than two elements, and its elements only have terminals" do
    ParseTree.new(:new, Array, 2, 1).evaluate_node_arguments.should == [2, 1]
  end
  
  it "should return the remainder of the elements evaluated if the list has more than two elements, and its elements have ParseTrees" do
    ParseTree.new(:new, Array, 2, ParseTree.new(:+, 1, 2)).evaluate_node_arguments.should == [2, 3]
  end
end

describe ParseTree, "#evaluate, with terminal object and parameters" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = ParseTree.new(:to_s, 1)            
    parse_tree.evaluate.should == "1"
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = ParseTree.new(:new, Array, 2, 1)            
    parse_tree.evaluate.should == [1, 1]
  end
end

describe ParseTree, "#evaluate, with terminal object, and ParseTree parameters" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = ParseTree.new( :+, 1, ParseTree.new(:*, 2, 2) )            
    parse_tree.evaluate.should == 5
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = ParseTree.new( :+, 2, ParseTree.new( :+, 1, ParseTree.new(:*, 2, 2) ) )                
    parse_tree.evaluate.should == 7
  end
end

describe ParseTree, "#evaluate, with terminal parameters, and ParseTree object" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = ParseTree.new( :+, ParseTree.new(:*, 2, 2), 1 )            
    parse_tree.evaluate.should == 5
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = ParseTree.new( :+, ParseTree.new( :+, 1, ParseTree.new(:*, 2, 2) ), 2 )                
    parse_tree.evaluate.should == 7
  end
end

describe ParseTree, "#evaluate, for complex mixed parameters" do
  it "should be able to evaluate" do
    parse_tree = ParseTree.new( 
      :+, ParseTree.new(:+, 1, 2), 
        ParseTree.new(:+, ParseTree.new(:+, 1, 2), 
          ParseTree.new(:*, ParseTree.new(:+, 1, 2), 
            ParseTree.new(:+, 1, 2) ) )
    )           
    parse_tree.evaluate.should == 15
  end
  
  it "should work with Arrays" do
    parse_tree = ParseTree.new( :+, [1, 2], ParseTree.new(:new, Array, 1, 3) )
    parse_tree.evaluate.should == [1, 2, 3]
  end
  
  it "should work with the main 'self' runtime" do    
    ParseTree.new(:instance_variable_set, self, '@parse_tree', ParseTree.new(:*, ParseTree.new(:+, 1, 3), 23) ).evaluate
  	ParseTree.new(:evaluate, @parse_tree)
  end
end