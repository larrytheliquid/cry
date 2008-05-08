require File.join(File.dirname(__FILE__), "..", "cry")

describe Object, ".cry_mode" do
  it "should be RubyMode by default" do
    Object.cry_mode.should == RubyMode
  end
end

describe Cry, ".mode" do    
  it "should be RubyMode by default" do
    Cry.mode.should == RubyMode
  end
end

describe Cry, ".mode=" do
  it "should raise Exception if mode is unrecognized" do
    lambda {Cry.mode = Array}.should raise_error
  end
  
  it "should change Object.cry_mode for RubyMode" do
    Cry.mode = RubyMode
    Object.cry_mode.should == RubyMode
  end
  
  it "should change Object.cry_mode for LispMode" do
    Cry.mode = LispMode
    Object.cry_mode.should == LispMode
  end
end