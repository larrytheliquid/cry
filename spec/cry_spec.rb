require File.join(File.dirname(__FILE__), "..", "cry")

describe Object, "#cry_mode" do
  it "should not be defined by default" do
    lambda {cry_mode}.should raise_error
  end
end

describe Cry, ".mode" do    
  it "should be nil by default" do
    Cry.mode.should be_nil
  end
end

describe Cry, ".mode=" do
  it "should raise Exception if mode is unrecognized" do
    lambda {Cry.mode = Array}.should raise_error
  end
  
  it "should change Object.cry_mode for RubyMode" do
    Cry.mode = Cry::RubyMode
    cry_mode.should == Cry::RubyMode
  end
  
  it "should change Object.cry_mode for LispMode" do
    Cry.mode = Cry::LispMode
    cry_mode.should == Cry::LispMode
  end
end