require "bundler/gem_tasks"

task :default => [:test]

task :prep_test_data do
  system "gzip -qd ./test/data/sample.log.gz"
end
task :run_tests do
  ruby 'test/test.rb'
end
task :test => [:prep_test_data, :run_tests]

task :build do
  ruby '-S gem build hewing.gemspec'
end
task :deploy do
  ruby '-S gem install hewing'

end
task :install => [:build, :deploy]

