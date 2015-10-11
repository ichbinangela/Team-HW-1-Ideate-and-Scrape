require_relative '../int_module/crawl_runner'
require_relative '../int_module/feeds_filter'
require_relative '../int_class/feed'
require_relative '../int_class/filter_condition'
require 'oga'

class BNextRobot
    include Crawler
    include FeedFilter

    attr_accessor :day_rank_feeds, :week_rank_feeds

    def initialize
        load_page( "http://www.bnext.com.tw/" )
        analyze
        init_rank_feeds
    end

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

    def show_day_rank
        @day_rank_feeds.map { |feed| puts "#{feed.title}: #{feed.link}" }
        nil
    end

    def show_week_rank
        @week_rank_feeds.map { |feed| puts "#{feed.title}: #{feed.link}" }
        nil
    end

    def init_rank_feeds
        token_gen = ["//div[@id = '", "_rank']//a[@class = 'content']"]
        document = Oga.parse_html( @web_data )

        day_rank_hrefs = document.xpath( token_gen.join( "day" ) + "/@href" ).map { |x| @domain + x.text[1..-1] }
        week_rank_hrefs = document.xpath( token_gen.join( "week" ) + "/@href" ).map { |x| @domain + x.text[1..-1] }

        day_rank_titles = document.xpath( token_gen.join( "day" ) ).map { |x| x.text }
        week_rank_titles = document.xpath( token_gen.join( "week" ) ).map { |x| x.text }

        @day_rank_feeds = day_rank_titles.zip( day_rank_hrefs ).map { |title, href| Feed.new( title, "", "", [], href ) }
        @week_rank_feeds = week_rank_titles.zip( week_rank_hrefs ).map { |title, href| Feed.new( title, "", "", [], href ) }
        nil
    end

    def get_feeds( cat, max_num )
        cur_page = 1
        feeds = []

        until feeds.length > max_num || cur_page > max_num
            feeds.concat( _get_feeds( cat, cur_page ) )
            cur_page += 1
        end

        feeds
    end

    def _get_feeds( cat, page_no )
        # TODO: parse all feeds @ page: page_no
        nil
    end

end
