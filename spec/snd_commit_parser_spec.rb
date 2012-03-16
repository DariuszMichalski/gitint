require 'commit_parser'

describe "Handle POST request with given correct payload" do
  
  let(:project_id) { "123" } 
  
  let(:data) do # this is the payload sent via github-services
    '{
      "payload":{
        "pusher":{
          "name":"none"
        },
        "repository":{
          "name":"gitint",
          "size":160,
          "has_wiki":true,
          "created_at":"2012/03/14 02:46:50 -0700",
          "private":false,
          "watchers":1,
          "fork":false,
          "url":"https://github.com/DariuszMichalski/gitint",
          "language":"Ruby",
          "pushed_at":"2012/03/15 15:59:48 -0700",
          "has_downloads":true,
          "open_issues":0,
          "homepage":"",
          "has_issues":true,
          "forks":1,
          "description":"Github Integration",
          "owner":{
            "name":"DariuszMichalski",
            "email":"dariusz.michalski@useo.pl"
          }
        },
        "forced":false,
        "head_commit":{
          "modified":[

          ],
          "added":[
            "services/agile_bench.rb"
          ],
          "author":{
            "name":"Dariusz Michalski",
            "username":"DariuszMichalski",
            "email":"dariusz.michalski@useo.pl"
          },
          "timestamp":"2012-03-15T15:59:38-07:00",
          "removed":[

          ],
          "url":"https://github.com/DariuszMichalski/gitint/commit/d477937fb1fef438b2298725423c1bd117010885",
          "id":"d477937fb1fef438b2298725423c1bd117010885",
          "distinct":true,
          "message":"AgileBench - github-services file",
          "committer":{
            "name":"Dariusz Michalski",
            "username":"DariuszMichalski",
            "email":"dariusz.michalski@useo.pl"
          }
        },
        "after":"d477937fb1fef438b2298725423c1bd117010885",
        "deleted":false,
        "ref":"refs/heads/master",
        "commits":[
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
            "message":"New spec file",
            "committer":{
              "name":"Dariusz Michalski",
              "username":"DariuszMichalski",
              "email":"dariusz.michalski@useo.pl"
            }
          },
          {
            "modified":[
              "api.rb"
            ],
            "added":[

            ],
            "author":{
              "name":"Dariusz Michalski",
              "username":"DariuszMichalski",
              "email":"dariusz.michalski@useo.pl"
            },
            "timestamp":"2012-03-15T15:02:43-07:00",
            "removed":[

            ],
            "url":"https://github.com/DariuszMichalski/gitint/commit/e7eeb7f6856548d918202b5a657be0cb54611678",
            "id":"e7eeb7f6856548d918202b5a657be0cb54611678",
            "distinct":true,
            "message":"Post route for testing github-services",
            "committer":{
              "name":"Dariusz Michalski",
              "username":"DariuszMichalski",
              "email":"dariusz.michalski@useo.pl"
            }
          },
          {
            "modified":[

            ],
            "added":[
              "services/agile_bench.rb"
            ],
            "author":{
              "name":"Dariusz Michalski",
              "username":"DariuszMichalski",
              "email":"dariusz.michalski@useo.pl"
            },
            "timestamp":"2012-03-15T15:59:38-07:00",
            "removed":[

            ],
            "url":"https://github.com/DariuszMichalski/gitint/commit/d477937fb1fef438b2298725423c1bd117010885",
            "id":"d477937fb1fef438b2298725423c1bd117010885",
            "distinct":true,
            "message":"[#1234] this comment will appear in Agile Bench Story 1234",
            "committer":{
              "name":"Dariusz Michalski",
              "username":"DariuszMichalski",
              "email":"dariusz.michalski@useo.pl"
            }
          }
        ],
        "before":"25e6cc398ff2c26af06444e826887ad05c37b29a",
        "compare":"https://github.com/DariuszMichalski/gitint/compare/25e6cc3...d477937",
        "created":false
      },
      "token":"test_token"
    }'
  end

  let(:wrong_data) do # this is a bad payload
    { }.to_json
  end

  context "Commit Parser" do
    #before(:each) do
      #@commit_parser = double "CommitParser"
    #end

    it "should be initialized correctly after receiving correct payload" do
      post "/push", params = { :payload => data } do
        last_response.status.should == 200
      end
    end

    it "should get POST payload from gihub and return parsed data" do
      post "/project/#{project_id}", params = { :data => data } do
        parsed_data = {:complete_message => "[#1234] this comment will appear in Agile Bench Story 1234",
                       :commit_message   => "this comment will appear in Agile Bench Story 1234",
                       :stories          => ["1234"],
                       :workflow_change  => "" }
        last_response.body.should == parsed_data.to_json
        last_response.status.should == 200
      end
    end
    
  end

  context "Response statuses" do
    it "should work fine with correct payload" do
      post "/project/#{project_id}", params = { :data => data } do
        last_response.status.should == 200
      end
    end
    it "should reject incorrect payload" do
      post "/project/#{project_id}", params = { :data => wrong_data } do
        last_response.status.should == 400
      end
    end
  end

end




