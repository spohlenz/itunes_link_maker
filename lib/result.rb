class ItunesLinkMaker
  class Result
    attr_reader :name, :type
    
    def initialize(name, type, display_url)
      @name = name
      @type = type
      @display_url = display_url
    end
    
    def ==(result)
      vars = [ '@name', '@type', '@display_url' ]
      vars.all? { |v| instance_variable_get(v) == result.instance_variable_get(v) }
    end
  end
end
