require "./spec_helper"

describe FuzzyMatch do
  it "can search multiple strings" do
    results = FuzzyMatch.search("view", ["ModelViewController", "SearchViewController", ".gitignore"])
    results.size.should eq(2)
    results[0].str.should eq("ModelViewController")
    results[1].str.should eq("SearchViewController")
  end

  it "should match with a score of 0 on an empty pattern" do
    results = FuzzyMatch.search("", ["Tar Unzip", "Find process", "Summary of subdirectory sizes", "Tar zip and exclude", "Create MySQL Database (While in MySQL)", "cpsh"])
    results[0].score.should eq(0)
    results[0].matches?.should eq(true)
  end
end
