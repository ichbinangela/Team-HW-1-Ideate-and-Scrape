require_relative '../int_module/crawl_runner'
require_relative '../int_module/feeds_filter'
require_relative '../int_class/feed'
require_relative '../int_class/filter_condition'
require 'oga'

class BNextRobot
    include Crawler
    include FeedFilter

    def analyze
        cat_tags = @web_data.scan( /<li>.*?<\/li>/ )
        atags = cat_tags.map { |x| x.match( /<a.*?<\/a>/ ).to_s }
        hrefs = atags.map { |x| x.match( /href=\".*?\"/ ).to_s[7..-2] }
        cat_names = atags.map { |x| x.match( />.+?</ ).to_s[1..-2] }
        cats_pair = cat_names.zip( hrefs ).select { |n, ref| ref.start_with? "categories" }

        @cats = Hash.new( false )
        cats_pair.map { |n, ref| @cats[ n ] = @domain + ref }
        nil
    end

    # def get_feeds( cat, max_num )
    # end
    
end
