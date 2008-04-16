require File.dirname(__FILE__) + '/spec_helper.rb'

describe ItunesLinkMaker::Result do
  setup do
    @open_result = mock('open result', :read => read_fixture('result.html'))
  end
  
  def create_result(options={})
    options = {
      :name => 'Such Great Heights',
      :type => :name,
      :display_url => '/WebObjects/MZStoreServices.woa/wa/itmsSearchDisplayUrl?desc=The+Postal+Service+-+Give+Up+-+Such+Great+Heights&WOURLEncoding=ISO8859_1&lang=1&url=http%3A%2F%2Fphobos.apple.com%2FWebObjects%2FMZStore.woa%2Fwa%2FviewAlbum%3Fi%3D2522315%26id%3D2522333%26s%3D143441'
    }.merge(options)
    
    ItunesLinkMaker::Result.new(options[:name], options[:type], options[:display_url])
  end
  
  it "should be instantiable with name, type and display url" do
    create_result
  end
  
  it "should set the name and type instance variables" do
    r = create_result
    r.name.should == 'Such Great Heights'
    r.type.should == :name
  end
  
  it "should be equal to a result with identical name, type and url" do
    r1, r2 = create_result, create_result
    r1.should == r2
  end
  
  it "should not be equal to a result with a different name" do
    r1 = create_result
    r2 = create_result(:name => 'Different')
    r1.should_not == r2
  end
  
  it "should not be equal to a result with a different type" do
    r1 = create_result
    r2 = create_result(:type => 'Different')
    r1.should_not == r2
  end
  
  it "should not be equal to a result with a different display url" do
    r1 = create_result
    r2 = create_result(:display_url => 'Different')
    r1.should_not == r2
  end
  
  it "should GET the display page when accessing the url" do
    r = create_result
    r.should_receive(:open).with("http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/itmsSearchDisplayUrl?desc=The+Postal+Service+-+Give+Up+-+Such+Great+Heights&WOURLEncoding=ISO8859_1&lang=1&url=http%3A%2F%2Fphobos.apple.com%2FWebObjects%2FMZStore.woa%2Fwa%2FviewAlbum%3Fi%3D2522315%26id%3D2522333%26s%3D143441").and_return(@open_result)
    r.url
  end
  
  it "should return the correct url" do
    r = create_result
    r.stub!(:open).and_return(@open_result)
    r.url.should == 'http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=2522315&id=2522333&s=143441'
  end
end