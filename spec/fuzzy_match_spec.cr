require "./spec_helper"

describe FuzzyMatch do
	it "can search multiple strings" do
		results = FuzzyMatch.search("view", ["ModelViewController", "SearchViewController", ".gitignore"])
		results.size.should eq(2)
		results[0].str.should eq("ModelViewController")
		results[1].str.should eq("SearchViewController")
	end
end
