module FuzzyMatch
	struct Simple
		property pattern_idx = 0
		property str_idx = 0
		property pattern_length : Int32
		property str_length : Int32

		def initialize(@pattern : String, @str : String)
			@pattern_length = @pattern.size
			@str_length = @str.size
		end

		def matches?() : Bool
			while(@pattern_idx != @pattern_length && @str_idx != @str_length)
				pattern_char = @pattern.char_at(pattern_idx).downcase
				str_char = @str.char_at(str_idx).downcase
				if pattern_char == str_char
					@pattern_idx = @pattern_idx + 1
				end
				@str_idx = @str_idx + 1
			end
			@pattern_length != 0 && @str_length != 0 && @pattern_idx == @pattern_length ? true : false
		end

	end
end
