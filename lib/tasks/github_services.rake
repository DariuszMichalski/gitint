namespace :github_services do
  desc 'Sends sample request imitating Post-Receive github-service'
  task :test, [:host_with_port] do |t, args|
    args.with_defaults(:host_with_port => "localhost:9292") 
    curl = `curl -X POST -i http://#{args.host_with_port}/agilebench/push -d 'data={"token":"QAZXSWEDC","project_id":"1234"}&payload={"pusher":{"name":"none"},"repository":{"name":"gitint","size":160,"has_wiki":true,"created_at":"2012/03/14 02:46:50 -0700","private":false,"watchers":1,"fork":false,"url":"https://github.com/DariuszMichalski/gitint","language":"Ruby","pushed_at":"2012/03/15 15:59:48 -0700","has_downloads":true,"open_issues":0,"homepage":"","has_issues":true,"forks":1,"description":"Github Integration","owner":{"name":"DariuszMichalski","email":"dariusz.michalski@useo.pl"}},"forced":false,"head_commit":{"modified":[],"added":["services/agile_bench.rb"],"author":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"},"timestamp":"2012-03-15T15:59:38-07:00","removed":[],"url":"https://github.com/DariuszMichalski/gitint/commit/d477937fb1fef438b2298725423c1bd117010885","id":"d477937fb1fef438b2298725423c1bd117010885","distinct":true,"message":"AgileBench - github-services file","committer":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"}},"after":"d477937fb1fef438b2298725423c1bd117010885","deleted":false,"ref":"refs/heads/master","commits":[{"modified":["spec/snd_commit_parser_spec.rb"],"added":[],"author":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"},"timestamp":"2012-03-15T10:46:15-07:00","removed":[],"url":"https://github.com/DariuszMichalski/gitint/commit/7f09f6eef2de765459be546c612ece131df2f075","id":"7f09f6eef2de765459be546c612ece131df2f075","distinct":true,"message":"New spec file","committer":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"}},{"modified":["api.rb"],"added":[],"author":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"},"timestamp":"2012-03-15T15:02:43-07:00","removed":[],"url":"https://github.com/DariuszMichalski/gitint/commit/e7eeb7f6856548d918202b5a657be0cb54611678","id":"e7eeb7f6856548d918202b5a657be0cb54611678","distinct":true,"message":"Post route for testing github-services","committer":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"}},{"modified":[],"added":["services/agile_bench.rb"],"author":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"},"timestamp":"2012-03-15T15:59:38-07:00","removed":[],"url":"https://github.com/DariuszMichalski/gitint/commit/d477937fb1fef438b2298725423c1bd117010885","id":"d477937fb1fef438b2298725423c1bd117010885","distinct":true,"message":"[In Progress #123]AgileBench - github-services file","committer":{"name":"Dariusz Michalski","username":"DariuszMichalski","email":"dariusz.michalski@useo.pl"}}],"before":"25e6cc398ff2c26af06444e826887ad05c37b29a","compare":"https://github.com/DariuszMichalski/gitint/compare/25e6cc3...d477937","created":false}'`
    puts curl
  end
end