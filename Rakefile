require 'spec/rake/spectask'
require 'rake/gempackagetask'

task :default => [:spec]

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end


# Gem specification
spec = Gem::Specification.new do |s| 
  s.name = "itunes_link_maker"
  s.version = "1.0.1"
  s.author = "Sam Pohlenz"
  s.email = "sam@sampohlenz.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Create iTunes links"
  s.rubyforge_project = 'itms-link-maker'
  s.homepage = 'http://itms-link-maker.rubyforge.org/'
  s.files = FileList[ "{lib}/*" ].to_a
  s.require_path = "lib"
  s.test_files = FileList[ "{spec}/**/*" ].to_a
  s.add_dependency('json', '>= 1.0.0')
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end
