class HomeController < ApplicationController
  def index
    require 'rss'
    require 'htmlentities'
    require 'nokogiri'
    rss = RSS::Parser.parse(open('http://carroklaar.blogspot.com/feeds/posts/default?start-index=1&max-results=999').read, false)
    coder = HTMLEntities.new
    images = coder.decode(rss)
    doc = Nokogiri::HTML( images)
    img_s = doc.css('img').map{ |i| i['src'] }
    img_sr = img_s.shuffle
    @img_srcs = coder.decode(img_sr)
  end
end
