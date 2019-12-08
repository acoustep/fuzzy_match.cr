require "./spec_helper"

describe FuzzyMatch::Simple do
  it "should match on a string that contains all patterns characters" do
    FuzzyMatch::Simple.new("mvc", "ModelViewController").matches?.should eq(true)
  end

  it "should not match on a string that contains none of the characters" do
    FuzzyMatch::Simple.new("xyz", "ModelViewController").matches?.should eq(false)
  end

  it "should not match on a partial matches" do
    FuzzyMatch::Simple.new("myz", "ModelViewController").matches?.should eq(false)
  end
end
