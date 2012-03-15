require 'commit_parser'

describe "Handle POST request with given correct payload" do

  let(:payload) do # this is the payload sent via github-services
    {
      :token => "ZXCSAJ12DD1212ACCEFBT",
      :project_id => 1234,
      :commit => {
        :message => "[#1234] this comment will appear in Agile Bench Story 1234"
      },
      :github_user => {
          :username => "SomeUserName",
          :email => "email@example.com"
      }
    }
  end

  let(:wrong_payload) do # this is a bad payload
    { }
  end

  context "Commit Parser" do
    #before(:each) do
      #@commit_parser = double "CommitParser"
    #end

    it "should be initialized correctly after receiving correct payload" do
      post "/push", params = {:payload => payload.to_json } do
        #@commit_parser.should_receive(:new).with(payload[:commit][:message]).and_return(true) # SOMETHING WRONG WHERE
      end
    end

    it "should get POST payload from gihub and return parsed data" do
      post "/push", params = { :payload => payload.to_json }
      parsed_data = {:complete_message => "[#1234] this comment will appear in Agile Bench Story 1234",
                     :commit_message   => "this comment will appear in Agile Bench Story 1234",
                     :stories          => ["1234"],
                     :workflow_change  => "" }
      last_response.status.should == 200
      last_response.body.should == parsed_data.to_json
    end
  end

  context "Response statuses" do
    it "should work fine with correct payload" do
      post "/push", params = {:payload => payload.to_json } do
        last_response.status.should == 200
      end
    end
    it "should reject incorrect payload" do
      post "/push", params = {:payload => wrong_payload.to_json } do
        last_response.status.should == 400
      end
    end
  end

end




