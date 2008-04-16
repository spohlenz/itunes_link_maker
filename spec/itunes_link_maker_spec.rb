require File.dirname(__FILE__) + '/../lib/itunes_link_maker.rb'

describe ItunesLinkMaker do
  setup do
    @open_result = mock('open result', :read => '')
    ItunesLinkMaker.stub!(:open).and_return(@open_result)
  end
  
  def search
    ItunesLinkMaker.search('search query')
  end
  
  it "should be searchable given a query" do
    search
  end
  
  it "should return an array of results" do
    search.should be_an_instance_of(Array)
  end
  
  it "should send a GET request to the iTunes search URL" do
    ItunesLinkMaker.should_receive(:open).with(
      "http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/itmsSearch?WOURLEncoding=ISO8859_1&lang=1&output=lm&country=US&term=search+query&media=music"
    ).and_return(@open_result)
    search
  end
end
