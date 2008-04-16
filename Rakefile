require 'spec/rake/spectask'
require 'rake/gempackagetask'

task :default => [:spec]

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*.rb']
end


# Gem specification
spec = Gem::Specification.new do |s| 
  s.name = "itunes_link_maker"
  s.version = "1.0"
  s.author = "Sam Pohlenz"
  s.email = "sam@sampohlenz.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Create iTunes links"
  s.files = FileList[ "{lib}/*" ].to_a
  s.require_path = "lib"
  s.test_files = FileList[ "{spec}/**/*" ].to_a
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end
