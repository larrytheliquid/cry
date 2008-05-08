require File.join(File.dirname(__FILE__), "..", "cry")

describe Cry::LispMode do
  before(:each) do
    Cry.mode = Cry::LispMode
  end
  
  it "should put main into LispMode" do    
    cry_mode.should == Cry::LispMode
  end
  
  it "should define a 'q' quote method on Object" do
    q(:+, 1, 3).should be_kind_of(ParseTree)
    q(:+, 1, 3).should == [:+, 1, 3]
  end
  
  it "should define a 'e' evaluate method on Object" do
    e(:*, q(:+, 1, 3), 23).should == 92
  end
end