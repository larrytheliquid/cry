require File.join(File.dirname(__FILE__), "..", "cry")

describe LispMode do
  before(:each) do
    Cry.mode = LispMode
  end
  
  it "should put Object into LispMode" do    
    Object::cry_mode.should == LispMode
  end
  
  it "should define a 'q' quote method on Object" do
    q(:+, 1, 3).should be_kind_of(ParseTree)
    q(:+, 1, 3).should == [:+, 1, 3]
  end
  
  it "should define a 'e' evaluate method on Object" do
    e(:*, q(:+, 1, 3), 23).should == 92
  end
end