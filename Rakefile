require 'spec/rake/spectask'
require 'rake/gempackagetask'

task :default => [:spec]

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

