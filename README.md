# Fuzzy Match

Fuzzy Matching inspired by [this blog post](https://www.forrestthewoods.com/blog/reverse_engineering_sublime_texts_fuzzy_match/).

Fuzzy Match provides search functionality similar to that of code editors such as Sublime Text 2 for searching files.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     fuzzy_match:
       github: acoustep/fuzzy_match
   ```

2. Run `shards install`

## Usage

```crystal
require "fuzzy_match"

# Simple

FuzzyMatch::Simple.new("mvc", "ModelViewController").matches? # true
FuzzyMatch::Simple.new("xyz", "ModelViewController").matches? # false

# Full
FuzzyMatch::Full.new("view", "ModelViewController").matches? # true
FuzzyMatch::Full.new("view", "ModelViewController").score # 60
```

The `Simple` struct provides a simple yes/no check on whether a pattern matches a string. The `Full` struct provides a score which can then be sorted.

```crystal
[
	FuzzyMatch::Full.new("view", "ModelViewController"),
	FuzzyMatch::Full.new("view", "SearchViewController"),
	FuzzyMatch::Full.new("view", ".gitignore"),
].select { |q| q.matches? }
.sort(&.score)
````

## To do

* Convenience wrapper for searching multiple files (with process spawning)
* Benchmarks
* Web demo

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/acoustep/fuzzy_match/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Mitch Stanley](https://github.com/acoustep) - creator and maintainer
