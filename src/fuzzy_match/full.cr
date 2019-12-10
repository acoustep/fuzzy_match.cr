require "math"

module FuzzyMatch
  struct Full
    SEQUENTIAL_BONUS           =  15 # bonus for adjacent matches
    SEPARATOR_BONUS            =  30 # bonus if match occurs after a separator
    CAMEL_BONUS                =  30 # bonus if match is uppercase and prev is lower
    FIRST_LETTER_BONUS         =  15 # bonus if the first letter is matched
    LEADING_LETTER_PENALTY     =  -5 # penalty applied for every letter in str before the first match
    MAX_LEADING_LETTER_PENALTY = -15 # maximum penalty for leading letters
    UNMATCHED_LETTER_PENALTY   =  -1

    SEPARATORS = ['_', ' ', '-']

    property score = 0
    property last_match_index : Int32 = 0 # we use this to prevent finding matches behind the previous match (Always match forward)
    property has_matched = false
    property matches_all_letters = true
    property str : String
    property matched_indexes = [] of Int32

    def initialize(@pattern : String, @str : String)
      return if @pattern.empty?
      search
    end

    private def search
      separator_chars = post_separator_chars
      @pattern.chars.each_with_index do |char, index|
        # If first searched letter matches the string's first letter give the leading letter bonus
        if index == 0 && (char == @str[0] || char.upcase == @str[0])
          @score += FIRST_LETTER_BONUS
        end

        # If theres no match then add the penalty
        # if there is check if theres a sequential bonus from a previous match
        if current_match_index = @str[@last_match_index..-1].downcase.chars.index(char.downcase)
          @matched_indexes << last_match_index + current_match_index
          if @has_matched
            if (@str.size > @last_match_index) && (@last_match_index + current_match_index) == (@last_match_index + 1)
              @score += SEQUENTIAL_BONUS
            end
          end
          # find separators and the characters after them
          if current_match_index > 0 && SEPARATORS.includes?(@str[current_match_index - 1])
            @score += SEPARATOR_BONUS
          end
          # find the index of the _next_ matching character
          @last_match_index = @last_match_index + current_match_index
          @has_matched = true
        else
          @score += UNMATCHED_LETTER_PENALTY
          @matches_all_letters = false
          next
        end

        # If character matches an uppercase character add the bonus
        if @str[@last_match_index..-1].includes?(char.upcase)
          @score += CAMEL_BONUS
        end
      end

      # position of first match
      position_after_first_match_penalty = 0
      if position = @str.downcase.index(@pattern[0].downcase)
        position_after_first_match_penalty = Math.max(position * LEADING_LETTER_PENALTY, MAX_LEADING_LETTER_PENALTY)
      end
      if position_after_first_match_penalty != 0
        @score += position_after_first_match_penalty
      end
    end

    # characters after a separator
    def post_separator_chars
      temp_chars = [] of Char
      @str.chars.each_with_index do |char, index|
        if SEPARATORS.includes?(char) && (@str.size < index)
          temp_chars << @str[index + 1]
        end
      end
      temp_chars
    end

    def matches?
      @matches_all_letters
    end
  end
end
