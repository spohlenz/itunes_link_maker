require 'rubygems'
require 'open-uri'
require 'cgi'
require 'json'

require File.join(File.dirname(__FILE__), 'result')

class ItunesLinkMaker
  MEDIA = [ 'all', 'music', 'movie', 'shortFilm', 'tvShow',
            'musicVideo', 'audiobook', 'podcast', 'iTunesU' ]
  
  COUNTRIES = [ 'AU', 'AT', 'BE', 'CA', 'DK', 'FI', 'FR', 'DE',
                'GR', 'IE', 'IT', 'JP', 'LU', 'NL', 'NZ', 'NO',
                'PT', 'ES', 'SE', 'CH', 'GB', 'US' ]
  
  SEARCH_URL = "http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/itmsSearch"
  
  TYPE_INDICES = { 0 => :name, 1 => :album, 2 => :artist }
  
  OPTION_ORDER = [ 'WOURLEncoding', 'lang', 'output', 'partnerId', 'LS_PARAM', 'country', 'term', 'media' ]
  
  @default_options = {
    'media'         => 'music',
    'country'       => 'US',
    'WOURLEncoding' => 'ISO8859_1',
    'lang'          => '1',
    'output'        => 'json'
  }
  
  def self.default_options
    @default_options
  end
  
  def self.search(query, options={})
    html = get_html(query, default_options.merge(options))
    parse_html(html).uniq
  end
  
  def self.quick_search(query, options={})
    search(query, options).first
  end
  
private
  def self.parse_html(json)
    parser = JSON.parse(json)
    parser.collect { |e| Result.new(e["itemName"], e["mediaType"], e["itemLinkUrl"]) }
  end
  
  def self.get_html(query, options={})
    open(url_for(options.merge('term' => query))).read
  end
  
  def self.url_for(options)
    "#{SEARCH_URL}?#{serialize(options)}"
  end
  
  def self.serialize(options={})
    options.sort_by { |k, v| OPTION_ORDER.index(k) }.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')
  end
end
