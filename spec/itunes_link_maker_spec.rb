require File.dirname(__FILE__) + '/spec_helper.rb'

describe ItunesLinkMaker do
  before(:each) do
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
      "http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/itmsSearch?WOURLEncoding=ISO8859_1&lang=1&output=json&country=US&term=search+query&media=music"
    ).and_return(@open_result)
    search
  end
end


describe "Itunes link search with no hits" do
  before(:each) do
    @open_result = mock('open result', :read => read_fixture('no_results.html'))
    ItunesLinkMaker.stub!(:open).and_return(@open_result)
  end
  
  def search
    ItunesLinkMaker.search('kafoozl')
  end
  
  it "should return an empty array" do
    search.should be_empty
  end
end


describe "Itunes quick search with no hits" do
  before(:each) do
    @open_result = mock('open result', :read => read_fixture('no_results.html'))
    ItunesLinkMaker.stub!(:open).and_return(@open_result)
  end
  
  def quick_search
    ItunesLinkMaker.quick_search('kafoozl')
  end
  
  it "should return nil" do
    quick_search.should be_nil
  end
end


describe "Itunes link search with multiple hits" do
  before(:each) do
    @open_result = mock('open result', :read => read_fixture('has_results.html'))
    ItunesLinkMaker.stub!(:open).and_return(@open_result)
  end
  
  def search
    ItunesLinkMaker.search('postal service such great heights')
  end
  
  it "should return a non-empty array" do
    search.should_not be_empty
  end
end


describe "Itunes quick search with multiple hits" do
  before(:each) do
    @open_result = mock('open result', :read => read_fixture('has_results.html'))
    ItunesLinkMaker.stub!(:open).and_return(@open_result)
  end
  
  def quick_search
    ItunesLinkMaker.quick_search('postal service such great heights')
  end
  
  it "should return the result object" do
    expected = ItunesLinkMaker::Result.new('Such Great Heights', :name, '/WebObjects/MZStoreServices.woa/wa/itmsSearchDisplayUrl?desc=The+Postal+Service+-+Give+Up+-+Such+Great+Heights&WOURLEncoding=ISO8859_1&lang=1&url=http%3A%2F%2Fphobos.apple.com%2FWebObjects%2FMZStore.woa%2Fwa%2FviewAlbum%3Fi%3D2522315%26id%3D2522333%26s%3D143441')
    quick_search.should == expected
  end
end
