require File.join(File.dirname(__FILE__), "..", "..", "..", "cry")

describe Cry::ParseTree, ".new" do
  it "should be a kind of Array" do
    Cry::ParseTree.new.should be_kind_of(Array)
  end
end