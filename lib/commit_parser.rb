class CommitParser
  attr_accessor :complete_message
  attr_reader :commit_message, :stories

  BRACKET_REGEXP = /\A(\[.+?\])/      # regexp which is used to get the first bracked from commit message
  STORY_NUMBER_REGEXP = /#([0-9]+)+/  # regexp which is used to get story numbers from the first bracket

  def initialize(message='')
    @complete_message = @commit_message = message.strip
    @stories = []
    parse
  end

  def parse
    # match regexp to get data from the first brackets
    if matched_brackets = BRACKET_REGEXP.match(complete_message)
      # get commit message (with no brackets)
      @commit_message = complete_message.gsub(matched_brackets[1], '').strip
      in_bracket_string = matched_brackets[1].gsub(/[\],\[]/,'').strip # remove brackets from captured string
      # get story numbers from inside the bracket
      get_story_numbers(in_bracket_string) if in_bracket_string
    end
  end

  private

  def get_story_numbers(in_bracket_string)
    @stories = in_bracket_string.scan(STORY_NUMBER_REGEXP).flatten if STORY_NUMBER_REGEXP.match(in_bracket_string)
  end

  def print_data
    puts "\n- Attributes -"
    puts "complete message: " + complete_message.inspect
    puts "commit message: " + commit_message.inspect
    puts "stories affected: " + stories.inspect
  end

end
