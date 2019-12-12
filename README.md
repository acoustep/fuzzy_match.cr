# Fuzzy Match

<img src="https://travis-ci.org/acoustep/fuzzy_match.cr.svg?branch=master" alt="build:">

Fuzzy Matching inspired by [this blog post](https://www.forrestthewoods.com/blog/reverse_engineering_sublime_texts_fuzzy_match/) for Crystal.

Fuzzy Match provides search functionality similar to code editors such as Sublime Text 2 file searching.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     fuzzy_match:
       github: acoustep/fuzzy_match
			 version: ~> 0.2.0
   ```

2. Run `shards install`

## Usage

The `Simple` struct provides a simple yes/no check on whether a pattern matches a string.

The `Full` struct provides a score which can then be sorted.

For most use cases, you'll want to pass a pattern and a list of file paths. For this you can use `FuzzyMatch.search`.

```crystal
require "fuzzy_match"

# Simple

FuzzyMatch::Simple.new("mvc", "ModelViewController").matches? # true
FuzzyMatch::Simple.new("xyz", "ModelViewController").matches? # false

# Full

FuzzyMatch::Full.new("view", "ModelViewController").matches? # true
FuzzyMatch::Full.new("view", "ModelViewController").score # 60

[
  FuzzyMatch::Full.new("view", "ModelViewController"),
  FuzzyMatch::Full.new("view", "SearchViewController"),
  FuzzyMatch::Full.new("view", ".gitignore"),
]
  .select { |q| q.matches? }
  .sort(&.score)

# Convenience method for searching multiple at a time

results = FuzzyMatch.search("view", ["ModelViewController", "SearchViewController", ".gitignore"])
results.size # 2
results[0].str # ModelViewController
results[0].score # 60
results[0].matches? # true
```


### Accessing the matched characters

Sometimes you want to be able to access matched letters. For example, you may wish to underline them with HTML.

```crystal
query = FuzzyMatch::Full.new("mvc", "ModelViewController")
str = String::Builder.build do |builder|
	query.str.chars.each_with_index do |char, index|
		builder << "<span class='underline'>" if query.matched_indexes.includes?(index)
		builder << query.str[index]
		builder << "</span>" if query.matched_indexes.includes?(index)
	end
end
p str # <span class='underline'>M</span>odel<span class='underline'>V</span>iew<span class='underline'>C</span>ontroller
```

## To do

* Web demo

## Development

### Running benchmarks

To test speed build `benchmark.cr` and run. This runs through a list of roughly 3000 files.

```crystal
crystal build --release --no-debug src/benchmark.cr
./benchmark
```

## Contributing

1. Fork it (<https://github.com/acoustep/fuzzy_match/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Mitch Stanley](https://github.com/acoustep) - creator and maintainer
