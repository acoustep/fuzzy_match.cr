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

  it "should prioritize sequences over capitals" do
    files = %w(
      src/main.cr
      lib/fuzzy_match/.gitignore
      lib/fuzzy_match/LICENSE
      lib/version_from_shard/LICENSE
      lib/fuzzy_match/src/fuzzy_match/version.cr
      lib/fuzzy_match/.tool-versions
      lib/fuzzy_match/.editorconfig
    )
    results = FuzzyMatch.search("main", files)
    results[0].str.should eq("src/main.cr")
  end
end
