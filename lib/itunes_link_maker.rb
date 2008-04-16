require 'open-uri'
require 'cgi'

require File.join(File.dirname(__FILE__), 'result')

class ItunesLinkMaker
  MEDIA = [ 'all', 'music', 'movie', 'shortFilm', 'tvShow',
            'musicVideo', 'audiobook', 'podcast', 'iTunesU' ]
  
  COUNTRIES = [ 'AU', 'AT', 'BE', 'CA', 'DK', 'FI', 'FR', 'DE',
                'GR', 'IE', 'IT', 'JP', 'LU', 'NL', 'NZ', 'NO',
                'PT', 'ES', 'SE', 'CH', 'GB', 'US' ]
  
  SEARCH_URL = "http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/itmsSearch?WOURLEncoding=ISO8859_1&lang=1&output=lm"
  
  def self.search(query, media='music', country='US')
    html = get_html(query, media, country)
    parse_html(html)
  end

private
  def self.parse_html(html)
    [Result.new]
  end
  
  def self.get_html(query, media, country)
    open("#{SEARCH_URL}&country=#{country}&term=#{CGI.escape(query)}&media=#{media}").read
  end
end
