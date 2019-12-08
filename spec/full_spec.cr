require "./spec_helper"

describe FuzzySearch::Full do
  it "should match on a string that contains all patterns characters" do
		# 15 for first character
		# 90 for camel bonus
		# 105 in total
		query = FuzzySearch::Full.new("mvc", "ModelViewController")
		query.score.should eq(105)
		query.matches?.should eq(true)
  end
	
  it "should not match on a string that contains none of the characters" do
		query =FuzzySearch::Full.new("xyz", "ModelViewController")
		query.score.should be < 0
		query.matches?.should eq(false)
  end

  it "should not match on a partial matches" do
		# 15 for first character
		# 30 for camel bonus
		query = FuzzySearch::Full.new("myz", "ModelViewController")
		query.score.should eq(43)
		query.matches?.should eq(false)
  end

  it "should take sequence matches into account" do
		# -15 for missing first 5 chars
		# 30 camel bonus for v
		# 45 for 4 letter sequence (first letter doesn't count)
		query = FuzzySearch::Full.new("view", "ModelViewController")
		query.score.should eq(60)
		query.matches?.should eq(true)
  end

  it "should rank camel case matches higher than lower case" do
		camel_match = FuzzySearch::Full.new("view", "ModelViewController")
		lower_match = FuzzySearch::Full.new("view", "modelviewcontroller")
		camel_match.score.should be > lower_match.score
  end
end


