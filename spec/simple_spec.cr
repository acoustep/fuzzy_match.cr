require "./spec_helper"

describe FuzzySearch::Simple do
  it "should match on a string that contains all patterns characters" do
		FuzzySearch::Simple.new("mvc", "ModelViewController").matches?.should eq(true)
  end
	
  it "should not match on a string that contains none of the characters" do
		FuzzySearch::Simple.new("xyz", "ModelViewController").matches?.should eq(false)
  end

  it "should not match on a partial matches" do
		FuzzySearch::Simple.new("myz", "ModelViewController").matches?.should eq(false)
  end
end

