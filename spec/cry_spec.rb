require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry, ".mode" do    
  it "should be RubyMode by default" do
    Cry.mode.should == Cry::RubyMode
  end
end

describe Cry, ".mode=" do
  it "should raise Exception if mode is unrecognized" do
    lambda {Cry.mode = Array}.should raise_error
  end
end