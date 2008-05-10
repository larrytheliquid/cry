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
  
  it "should work with Arrays" do
    p = ParseTree.new(:+, 1, [2, 3])
    p.to_lisp.should == "(+ 1 [2, 3])"
  end
  
  it "should work with Hashes" do
    p = ParseTree.new(:+, 1, {:one => 1})
    p.to_lisp.should == "(+ 1 {:one=>1})"
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