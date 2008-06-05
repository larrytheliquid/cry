require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

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
    Cry::ParseTree.new(:inject, [1, 2, 3], 0, lambda{|sum, i| sum + i }).evaluate.should == 6
  end
  
  it "should raise the original error if the block parameters as lambda attempt failes" do
    lambda { Cry::ParseTree.new(:inject, [1, 2, 3], 0, "not a Proc").evaluate }.should raise_error(ArgumentError)
  end
  
  it "should be able to create new classes" do
    Cry::ParseTree.new(:instance_variable_set, self, '@klass', Class.new ).evaluate
    @klass.should be_kind_of(Class)
  end
  
  it "should work with the main 'self' runtime" do    
    Cry::ParseTree.new(:instance_variable_set, self, '@parse_tree', 'Cry::ParseTree.new(:*, Cry::ParseTree.new(:+, 1, 3), 23).evaluate' ).evaluate
    Cry::ParseTree.new(:eval, Kernel, @parse_tree).evaluate.should == 92
  end
end
