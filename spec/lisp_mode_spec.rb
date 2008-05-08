require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry::LispMode do
  before(:each) do
    Cry.mode = Cry::LispMode
  end
  
  it "should put main into LispMode" do    
    cry_mode.should == Cry::LispMode
  end
  
  it "should define a 'e' evaluate method on Object" do
    e(:*, e(:+, 1, 3), 23).should == 92
  end
end