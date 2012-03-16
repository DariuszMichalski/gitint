require 'commit_parser'

describe CommitParser do
  subject { CommitParser.new commit }
  
  let(:message) { "nothing" }
  
  let(:commit) do
    JSON.parse('
    {
      "modified":[
        "spec/snd_commit_parser_spec.rb"
      ],
      "added":[

      ],
      "author":{
        "name":"Dariusz Michalski",
        "username":"DariuszMichalski",
        "email":"dariusz.michalski@useo.pl"
      },
      "timestamp":"2012-03-15T10:46:15-07:00",
      "removed":[

      ],
      "url":"https://github.com/DariuszMichalski/gitint/commit/7f09f6eef2de765459be546c612ece131df2f075",
      "id":"7f09f6eef2de765459be546c612ece131df2f075",
      "distinct":true,
      "message":"' + message + '",
      "committer":{
        "name":"Dariusz Michalski",
        "username":"DariuszMichalski",
        "email":"dariusz.michalski@useo.pl"
      }
    }')    
  end

  its(:stories) { should == [] }

  describe "without a state transition" do
    context "given a single story" do
      let(:message) { "[#1234] this comment will appear in Agile Bench Story 1234" }

      its(:stories) { should == ["1234"] }
      its(:commit_message) { should == "this comment will appear in Agile Bench Story 1234" }
    end

    context "given multiple stories" do
      let(:message) { "[#1234 #5678] this comment will appear in both stories 1234 and 5678" }

      its(:stories) { should == ["1234", "5678"] }
      its(:commit_message) { should == "this comment will appear in both stories 1234 and 5678" }
    end
  end

  describe "with a state transition" do
    context "given a single story" do
      let(:message) { "[In Progress #1234] will move story 1234 to the workflow state of in_progess" }

      its(:stories) { should == ["1234"] }
      its(:workflow_change) { should == "In Progress" }
      its(:commit_message) { should == "will move story 1234 to the workflow state of in_progess" }

      # test the message
      # test the transition
    end

    # [Done #1234] will move story 1234 to the workflow state of done
    # [Closes #1234]  will move story 1234 to the workflow state of done
    # [Fixes #1234]  will move story 1234 to the workflow state of done
    # test error states.
    # etc
  end
end
