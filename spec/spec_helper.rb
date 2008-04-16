require File.dirname(__FILE__) + '/../lib/itunes_link_maker.rb'

FIXTURES_DIR = File.join(File.dirname(__FILE__), 'fixtures')

def read_fixture(file)
  open(File.join(FIXTURES_DIR, file)).read
end
