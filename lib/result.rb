class ItunesLinkMaker
  class Result
    URL_ROOT = "http://ax.phobos.apple.com.edgesuite.net"
    
    attr_reader :name, :type
    
    def initialize(name, type, display_url)
      @name = name
      @type = type
      @display_url = "#{URL_ROOT}#{display_url}"
    end
    
    def url
      @url ||= get_url
    end
    
    def eql?(result)
      vars = [ '@name', '@type', '@display_url' ]
      vars.all? { |v| instance_variable_get(v) == result.instance_variable_get(v) }
    end
    
    alias_method :==, :eql?
    
    def hash
      "#{@name}#{@type}#{@display_url}".hash
    end
    
  private
    def get_url
      doc = Hpricot(open(@display_url))
      (doc/'textarea a').first['href']
    end
  end
end
