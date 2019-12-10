require "benchmark"
require "file"
require "./fuzzy_match"
# run with release flag
file_list = File.read_lines("./spec/dummy_list.txt").select { |f| !(f.includes?(".git/") || f.includes?("./node_modules/")) }.map { |f| File.basename(f) }

p "Benchmarking across #{file_list.size} file names"

puts Benchmark.measure {
  results = FuzzyMatch.search("erq", file_list)
  results.first(10).each do |r|
    p "#{r.str} : #{r.score}"
  end
}
