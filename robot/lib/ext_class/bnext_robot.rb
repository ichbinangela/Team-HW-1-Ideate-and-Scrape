require_relative '../int_module/crawl_runner'
require_relative '../int_module/feeds_filter'
require_relative '../int_class/feed'
require_relative '../int_class/filter_condition'
require 'oga'
require 'open-uri'

#BNextRobot Extract titles and links of daily/ weekly hot feeds.
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

    day_rank_hrefs = document.xpath( token_gen.join( "day" ) + "/@href" ).map { |x| x.text }
    week_rank_hrefs = document.xpath( token_gen.join( "week" ) + "/@href" ).map { |x| x.text }

    day_rank_titles = document.xpath( token_gen.join( "day" ) ).map { |x| x.text }
    week_rank_titles = document.xpath( token_gen.join( "week" ) ).map { |x| x.text }

    day_rank = day_rank_titles.zip( day_rank_hrefs ).select { |title, href| href.start_with? "/" }
    day_rank = day_rank.map { |title, href| [ title, @domain + href[1..-1] ] }
    week_rank = week_rank_titles.zip( week_rank_hrefs ).select { |title, href| href.start_with? "/" }
    week_rank = week_rank.map { |title, href| [ title, @domain + href[1..-1] ] }

    @day_rank_feeds = day_rank.map { |title, href| Feed.new( title, "", "", [], href ) }
    @week_rank_feeds = week_rank.map { |title, href| Feed.new( title, "", "", [], href ) }
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

# ListFeed Extract each feed's unique path in a certain category
class ListFeed
  URL = 'http://www.bnext.com.tw/categories'
  FEED_XPATH = "//a[contains(@class, 'item_title block_link')]/@href"

  def initialize(cat, page_no)
    parse_html(cat, page_no)
  end

  def path
    @path ||= get_feed_path
  end

  private

  def parse_html(cat, page_no)
    url = "#{URL}/#{cat}/?p=#{page_no}"
    @document = Oga.parse_html(open(url))
  end

  def get_feed_path
    path = @document.xpath(FEED_XPATH).map { &:text }
  end
end

# GetFeedDetails extracts title, author, date, content, and tags from the feed.
class GetFeedDetails
  URL = 'http://www.bnext.com.tw'
  TITLE_XPATH = "//div[contains(@class, 'main_title')]"
  TAG_XPATH = "//a[contains(@class, 'tag_link')]"
  INFO_XPATH = "//span[contains(@class, 'info')]"
  CONTENT_XPATH = "//div[contains(@class, 'content htmlview')]"

  def initialize(feed_id)
    parse_html(feed_id)
  end

  def feed
    @feed ||= extract_feed
  end

  private

  def parse_html(feed_id)
    link = "#{URL}#{feed_id}"
    @document = Oga.parse_html(open(link))
  end

  def extract_feed
    # We should clean up the texts at some point (e.g. remove "撰文者" & "發文日期").
    title = @document.xpath(TITLE_XPATH).text.force_encoding('utf-8')
    author = @document.xpath(INFO_XPATH)[0].text.force_encoding('utf-8')
    date = @document.xpath(INFO_XPATH)[1].text.force_encoding('utf-8')
    content = @document.xpath(CONTENT_XPATH).text.force_encoding('utf-8')
    tags = @document.xpath(TAG_XPATH).map { |i| i.text.force_encoding('utf-8') }
        
    feed_details = Hash["title" => title, "author" => author, "date" => date, "content" => content, "tags" => tags]
  end
end

## Executable file (run_crawler) sample ##

## codes below
# cat = ARGV[0]
# page_no = ARGV[1]

# feed_found = ListFeed.new(cat, page_no).path

# feed_found.each { |id_path|
#   feeds_detail = GetFeedDetails.new(id_path).feed
#   puts "#{feeds_detail}"
# }

## Executable command line sample ##
# $ run_crawler internet 3
