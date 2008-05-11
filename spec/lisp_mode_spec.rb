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

describe ParseTree, "#to_lisp" do  
  it "should use parantheses instead of brackets, and not use colons or commas" do
    p = ParseTree.new(:+, 1, 2)
    p.to_lisp.should == "(+ 1 2)"
  end
  
  it "should turn underscores in method names to dashes" do
    p = ParseTree.new(:to_s, 1)
    p.to_lisp.should == "(to-s 1)"
  end
  
  it "should work with ParseTree arguments" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2) )
    p.to_lisp.should == "(+ 1 (* (* 2 2) 2))"
  end
  
  it "should work with a ParseTree object" do
    p = ParseTree.new( :+, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2), 1 )
    p.to_lisp.should == "(+ (* (* 2 2) 2) 1)"
  end
end

describe ParseTree, ".from_lisp" do  
  it "should work with parantheses instead of brackets, and no colons or commas" do
    p = ParseTree.new(:+, 1, 2)
    ParseTree.from_lisp("(+ 1 2)").should == p
  end
  
  it "should work with more than one character names" do
    p = ParseTree.new(:new, Array, 2, 1)
    ParseTree.from_lisp("(new Array 2 1)").should == p
  end
  
  it "should work with ParseTree arguments" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2) )
    ParseTree.from_lisp("(+ 1 (* (* 2 2) 2))").should == p
  end
  
  it "should work with ParseTree arguments, and spacing" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2) )
    ParseTree.from_lisp("(   + 1 (* (* 2    2) 2)  )").should == p
  end
  
  it "should work with a ParseTree object" do
    p = ParseTree.new( :+, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2), 1 )
    ParseTree.from_lisp("(+ (* (* 2 2) 2) 1)").should == p
  end
  
  it "should work with a ParseTree object, and spacing" do
    p = ParseTree.new( :+, ParseTree.new(:*, ParseTree.new(:*, 2, 2), 2), 1 )
    ParseTree.from_lisp(" ( + (* (  * 2 2 ) 2) 1  )").should == p
  end
  
  it "should work with method names that have underscores" do
    p = ParseTree.new(:to_s, 1)
    ParseTree.from_lisp("(to_s 1)").should == p
  end
  
  it "should turn dahses in method names to underscores" do
    p = ParseTree.new(:to_s, 1)
    ParseTree.from_lisp("(to-s 1)").should == p
  end
  
  it "should work with newline and tab characters" do
    p = ParseTree.new( :+, 1, ParseTree.new(:*, 2, 2) )
    ParseTree.from_lisp("(+ 1 \n(* 2 2)\t)").should == p
  end
end