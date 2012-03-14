require 'commit_parser'

describe CommitParser do
  subject { CommitParser.new message }

  let(:message) { "nothing" }

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
