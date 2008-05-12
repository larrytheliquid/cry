require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry, ".mode" do  
  before(:each) do
    Cry.mode = Cry::LispMode
  end
  
  it "should be RubyMode" do    
    Cry.mode.should == Cry::LispMode
  end
end

describe Object, "#e" do
  before(:each) do
    Cry.mode = Cry::LispMode
  end

  it "should define a 'e' evaluate method on Object" do
    e(:*, e(:+, 1, 3), 23).should == 92
  end
end

describe ParseTree, "#to_rlisp" do  
  it "should use parantheses instead of brackets, and not use colons or commas" do
    p = ParseTree.new(:+, 1, 2)
    p.to_rlisp.should == "(+ 1 2)"
  end
  
  it "should turn underscores in method names to dashes" do
    p = ParseTree.new(:to_s, 1)
    p.to_rlisp.should == "(to-s 1)"
  end
  
  it "should work with ParseTree arguments" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2) )
    p.to_rlisp.should == "(+ 1 (* (* 2 2) 2))"
  end
  
  it "should work with a ParseTree object" do
    p = ParseTree.new( :+, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2), 1 )
    p.to_rlisp.should == "(+ (* (* 2 2) 2) 1)"
  end
end

describe ParseTree, ".from_rlisp" do  
  it "should work with parantheses instead of brackets, and no colons or commas" do
    p = ParseTree.new(:+, 1, 2)
    ParseTree.from_rlisp("(+ 1 2)").should == p
  end
  
  it "should work with more than one character names" do
    p = ParseTree.new(:new, Array, 2, 1)
    ParseTree.from_rlisp("(new Array 2 1)").should == p
  end
  
  it "should work with ParseTree arguments" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2) )
    ParseTree.from_rlisp("(+ 1 (* (* 2 2) 2))").should == p
  end
  
  it "should work with ParseTree arguments, and spacing" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2) )
    ParseTree.from_rlisp("(   + 1 (* (* 2    2) 2)  )").should == p
  end
  
  it "should work with a ParseTree object" do
    p = ParseTree.new( :+, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2), 1 )
    ParseTree.from_rlisp("(+ (* (* 2 2) 2) 1)").should == p
  end
  
  it "should work with a ParseTree object, and spacing" do
    p = ParseTree.new( :+, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2), 1 )
    ParseTree.from_rlisp(" ( + (* (  * 2 2 ) 2) 1  )").should == p
  end
  
  it "should work with method names that have underscores" do
    p = ParseTree.new(:to_s, 1)
    ParseTree.from_rlisp("(to_s 1)").should == p
  end
  
  it "should turn dashes in method names to underscores" do
    p = ParseTree.new(:to_s, 1)
    ParseTree.from_rlisp("(to-s 1)").should == p
  end
  
  it "should not turn subtract into underscore" do
    p = ParseTree.new(:-, 4, 2)
    ParseTree.from_rlisp("(- 4 2)").should == p
  end
  
  it "should work with newline and tab characters" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, 2, 2) )
    ParseTree.from_rlisp("(+ 1 \n(* 2 2)\t)").should == p
  end
end

describe Cry, ".require_rlisp" do
  it "should use ParseTree.from_rlisp" do
    ParseTree.should_receive(:from_rlisp).and_return(stub_everything("parse tree"))
    Cry.require_rlisp(File.join(File.dirname(__FILE__), "fixtures", "example.rlisp"))
  end
  
  it "should evaluae the code as Ruby with Lisp-like syntax" do
    Cry.require_rlisp(File.join(File.dirname(__FILE__), "fixtures", "example.rlisp")).should == [4, 4, 4, 4, 4]
  end
end