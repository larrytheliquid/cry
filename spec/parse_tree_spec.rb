require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry::ParseTree, ".new" do
  it "should be a kind of Array" do
    Cry::ParseTree.new.should be_kind_of(Array)
  end
end

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

describe Cry::ParseTree, "#evaluate, with terminal object and parameters" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = Cry::ParseTree.new(:to_s, 1)            
    parse_tree.evaluate.should == "1"
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = Cry::ParseTree.new(:new, Array, 2, 1)            
    parse_tree.evaluate.should == [1, 1]
  end
end

describe Cry::ParseTree, "#evaluate, with terminal object, and Cry::ParseTree parameters" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = Cry::ParseTree.new( :+, 1, Cry::ParseTree.new(:*, 2, 2) )            
    parse_tree.evaluate.should == 5
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = Cry::ParseTree.new( :+, 2, Cry::ParseTree.new( :+, 1, Cry::ParseTree.new(:*, 2, 2) ) )                
    parse_tree.evaluate.should == 7
  end
end

describe Cry::ParseTree, "#evaluate, with terminal parameters, and Cry::ParseTree object" do
  it "should be able to evaluate an expression for a simple parse tree" do
    parse_tree = Cry::ParseTree.new( :+, Cry::ParseTree.new(:*, 2, 2), 1 )            
    parse_tree.evaluate.should == 5
  end
  
  it "should be able to evaluate an expression for a complex parse tree" do
    parse_tree = Cry::ParseTree.new( :+, Cry::ParseTree.new( :+, 1, Cry::ParseTree.new(:*, 2, 2) ), 2 )                
    parse_tree.evaluate.should == 7
  end
end

describe Cry::ParseTree, "#evaluate, for complex mixed parameters" do
  it "should be able to evaluate" do
    parse_tree = Cry::ParseTree.new( 
      :+, Cry::ParseTree.new(:+, 1, 2), 
        Cry::ParseTree.new(:+, Cry::ParseTree.new(:+, 1, 2), 
          Cry::ParseTree.new(:*, Cry::ParseTree.new(:+, 1, 2), 
            Cry::ParseTree.new(:+, 1, 2) ) )
    )           
    parse_tree.evaluate.should == 15
  end
  
  it "should work with Arrays" do
    parse_tree = Cry::ParseTree.new( :+, [1, 2], Cry::ParseTree.new(:new, Array, 1, 3) )
    parse_tree.evaluate.should == [1, 2, 3]
  end
  
  it "should work with lambdas" do
    Cry::ParseTree.new(:call, lambda{|from, backwards_greeting| Cry::ParseTree.new(:+, Cry::ParseTree.new(:join, Cry::ParseTree.new(:reverse, backwards_greeting), " "), from).evaluate }, " from lisp", ["world", "hello"]).evaluate.should == "hello world from lisp"
  end
  
  it "should work with block parameters as lambdas" do
    pending " "
    Cry::ParseTree.new(:map, [1, 2, 3], lambda{|element| element.to_s }).evaluate.should == ["1", "2", "3"]
  end
  
  it "should work with the main 'self' runtime" do    
    Cry::ParseTree.new(:instance_variable_set, self, '@parse_tree', 'Cry::ParseTree.new(:*, Cry::ParseTree.new(:+, 1, 3), 23).evaluate' ).evaluate
    Cry::ParseTree.new(:eval, Kernel, @parse_tree).evaluate.should == 92
  end
end

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