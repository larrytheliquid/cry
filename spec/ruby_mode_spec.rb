require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry::RubyMode, ".cry_mode" do
  before(:each) do
    Cry.mode = Cry::RubyMode
  end
  
  it "should put main into RubyMode" do    
    cry_mode.should == Cry::RubyMode
  end
end