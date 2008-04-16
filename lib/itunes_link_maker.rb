require 'rubygems'
require 'open-uri'
require 'cgi'
require 'hpricot'

require File.join(File.dirname(__FILE__), 'result')

class ItunesLinkMaker
  MEDIA = [ 'all', 'music', 'movie', 'shortFilm', 'tvShow',
            'musicVideo', 'audiobook', 'podcast', 'iTunesU' ]
  
  COUNTRIES = [ 'AU', 'AT', 'BE', 'CA', 'DK', 'FI', 'FR', 'DE',
                'GR', 'IE', 'IT', 'JP', 'LU', 'NL', 'NZ', 'NO',
                'PT', 'ES', 'SE', 'CH', 'GB', 'US' ]
  
  SEARCH_URL = "http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/itmsSearch?WOURLEncoding=ISO8859_1&lang=1&output=lm"
  
  TYPE_INDICES = { 0 => :name, 1 => :album, 2 => :artist }
  
  def self.search(query, media='music', country='US')
    html = get_html(query, media, country)
    parse_html(html)
  end

private
  def self.parse_html(html)
    doc = Hpricot(html)
    
    result = []
    (doc/'a.searchResults').each_with_index do |element, i|
      name = element.inner_text.strip
      type = TYPE_INDICES[i]
      url = element['href']
      
      result << Result.new(name, type, url)
    end
    result
  end
  
  def self.get_html(query, media, country)
    open("#{SEARCH_URL}&country=#{country}&term=#{CGI.escape(query)}&media=#{media}").read
  end
end
