class ItunesLinkMaker
  class Result
    
    attr_reader :name, :type
    
    def initialize(name, type, display_url)
      @name = name
      @type = type
      @display_url = display_url
    end
    
    def url
      @display_url
    end
    
    def eql?(result)
      vars = [ '@name', '@type', '@display_url' ]
      vars.all? { |v| instance_variable_get(v) == result.instance_variable_get(v) }
    end
    
    alias_method :==, :eql?
    
    def hash
      "#{@name}#{@type}#{@display_url}".hash
    end

  end
end
