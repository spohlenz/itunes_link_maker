require File.dirname(__FILE__) + '/../lib/itunes_link_maker.rb'

def read_fixture(file)
  open(File.join(File.dirname(__FILE__), 'fixtures', file)).read
end
