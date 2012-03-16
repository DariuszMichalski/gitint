class CommitParser
  # :stories contains an array of story numbers that have been passed inside brackets
  # :workflow_changes contains a hash with story numbers and responsive workflow changes i.e.: "#123" => "In Progress"
  # :commit_message contains a commit message without bracket data
  # :complete message contains the whole commit message with bracket data
  attr_accessor :complete_message
  attr_reader :committer, :commit_message, :stories, :workflow_change

  BRACKET_REGEXP = /\A(\[.+?\])/      # regexp which is used to get the first bracked from commit message
  STORY_NUMBER_REGEXP = /#([0-9]+)+/  # regexp which is used to get story numbers from the first bracket

  def initialize(commit)
    @complete_message = @commit_message = commit["message"].strip
    @committer = { :name => commit["committer"]["name"], :username => commit["committer"]["username"], :email => commit["committer"]["email"] }
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
      check_workflow_change(in_bracket_string)
    end
    #print_data # TODO: remote it (just for testing)
  end

  def to_s # TODO: remove it (just for testing)
    puts "\n- Attributes -"
    puts "complete message: " + complete_message.inspect
    puts "commit message: " + commit_message.inspect
    puts "stories affected: " + stories.inspect
    puts "workflow change: " + workflow_change.inspect
    puts "committer: " + committer.inspect
  end

  def to_json
    { :complete_message => complete_message,
      :commit_message   => commit_message,
      :stories          => stories,
      :workflow_change  => workflow_change,
      :committer        => committer }.to_json
  end

  private

  def get_story_numbers(in_bracket_string)
    @stories = in_bracket_string.scan(STORY_NUMBER_REGEXP).flatten if in_bracket_string and STORY_NUMBER_REGEXP.match(in_bracket_string)
  end

  def check_workflow_change(in_bracket_string)
    # check workflow only if there are story numbers detected
    @workflow_change = in_bracket_string.split('#').first.strip if stories.size > 0
  end

end
