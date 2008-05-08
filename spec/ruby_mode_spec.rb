require File.join(File.dirname(__FILE__), "..", "cry")

describe RubyMode, ".cry_mode" do
  before(:each) do
    Cry.mode = RubyMode
  end
  
  it "should put Object into RubyMode" do    
    Object::cry_mode.should == RubyMode
  end
end