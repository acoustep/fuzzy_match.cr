require "./fuzzy_match/*"

module FuzzyMatch
  extend self

  def search(pattern, strings)
    return strings
      .map { |str| FuzzyMatch::Full.new(pattern, str) }
      .select { |q| q.matches? }
      .sort(&.score)
  end
end
