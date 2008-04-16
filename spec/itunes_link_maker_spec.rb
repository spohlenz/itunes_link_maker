require File.dirname(__FILE__) + '/../lib/itunes_link_maker.rb'

describe ItunesLinkMaker do
  it "should be searchable given a query" do
    ItunesLinkMaker.create('search query')
  end
  
  it "should return an array of results" do
    ItunesLinkMaker.create('search query').should be_an_instance_of(Array)
  end
end
