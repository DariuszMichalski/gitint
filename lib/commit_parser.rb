class CommitParser
  attr_accessor :complete_message
  attr_reader :commit_message, :stories, :workflow_changes
  attr_reader :commit_message, :stories

  BRACKET_REGEXP = /\A(\[.+?\])/      # regexp which is used to get the first bracked from commit message
  STORY_NUMBER_REGEXP = /#([0-9]+)+/  # regexp which is used to get story numbers from the first bracket

  def initialize(message='')
    @complete_message = @commit_message = message.strip
    @stories, @workflow_changes = [], {}
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
      get_story_numbers(in_bracket_string)
      # workflow handling
      check_workflow_changes(in_bracket_string)

      # :stories contains an array of story numbers that have been passed inside brackets
      # :workflow_changes contains a hash with story numbers and responsive workflow changes i.e.: "#123" => "In Progress"
      # :commit_message contains a commit message without bracket data
      # :complete message contains the whole commit message with bracket data
    end
    print_data # TODO: remote it (just for testing)
  end

  def data_hash
    { :complete_message => complete_message,
      :commit_message   => commit_message,
      :stories          => stories,
      :workflow_changes => workflow_changes }
  end

  private

  def get_story_numbers(in_bracket_string)
    @stories = in_bracket_string.scan(STORY_NUMBER_REGEXP).flatten if in_bracket_string.present? and STORY_NUMBER_REGEXP.match(in_bracket_string)
  end

  def check_workflow_changes(in_bracket_string)
    # check workflow only if there are story numbers detected
    if stories.size > 0
      workflow_hash, prev_elem = {}, nil
      in_bracket_string.split(STORY_NUMBER_REGEXP).each_with_index { |e, i|
        ((i+1)%2 == 0 && prev_elem) ? (workflow_hash[e.strip] = prev_elem) : (prev_elem = e.strip)
      }
      @workflow_changes = workflow_hash
    end
  end

  def print_data # TODO: remove it (just for testing)
    puts "\n- Attributes -"
    puts "complete message: " + complete_message.inspect
    puts "commit message: " + commit_message.inspect
    puts "stories affected: " + stories.inspect
    puts "workflow changes: " + workflow_changes.inspect
  end

end
