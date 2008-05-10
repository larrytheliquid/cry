require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry, ".mode" do  
  before(:each) do
    Cry.mode = Cry::RubyMode
  end
  
  it "should be RubyMode" do    
    Cry.mode.should == Cry::RubyMode
  end
end