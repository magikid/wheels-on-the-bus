require 'rake/testtask'
require 'rubocop/rake_task'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs.push "lib"
	t.test_files = FileList['test/*_test.rb']
	t.verbose = true
	t.warning = true
end

task :rubocop do
    Rubocop::RakeTask.new
end

