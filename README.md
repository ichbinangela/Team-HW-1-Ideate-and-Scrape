# Business Next Scraper
##Overview
This is a scraper that collects articles and article-related information from the website 
[Business Next](http://www.bnext.com.tw/).

In this week, we generate two methods for scraper to show the articles with top rankings.

* `show_day_rank` : show the top ranked articles within one day.
* `show_week_rank` : show the top ranked articles within one week.


##Repository structure
```
├── README.md
├── init_lib_struct.py
└── robot
    ├── Gemfile
    ├── Gemfile.lock
    ├── lib
    │   ├── ext_class
    │   │   ├── bnext_robot.rb
    │   │   ├── inside_robot.rb
    │   │   ├── mngrtoday_robot.rb
    │   │   └── newslens_robot.rb
    │   ├── int_class
    │   │   ├── feed.rb
    │   │   └── filter_condition.rb
    │   ├── int_module
    │   │   ├── crawl_runner.rb
    │   │   └── feeds_filter.rb
    │   ├── robot_main.rb
    │   └── tool
    │       └── search_feeds.rb
    └── spec
        ├── class_spec
        │   ├── bnext_robot_spec.rb
        │   ├── inside_robot_spec.rb
        │   ├── mngrtoday_robot_spec.rb
        │   └── newslens_robot_spec.rb
        ├── robot_spec.rb
        ├── testfiles
        │   ├── gather_data.rb
        │   └── mainpage
        │       ├── bnext_mainpage.html
        │       ├── inside_mainpage.html
        │       ├── managertoday_mainpage.html
        │       └── thenewslens_mainpage.html
        └── tool_spec
            └── search_feeds_spec.rb

```
##Usage of scraper
###1. Initialize a scrapy robot

```ruby
bot = BNextRobot.new
```

###2. Call the class methods

```ruby 
bot.show_day_rank
# It will return *titles* and the *links* of daily hot news.


bot.show_week_rank
# It will return *titles* and the *links* of weekly hot news.
```

### ※Sample results of show_day_rank

```
專業，就是用對方聽得懂的話，去告訴他不懂的事情: http://www.bnext.com.tw/article/view/id/37573
Surface名氣愈來愈旺！微軟趁勝追擊推出首款自家筆電Surface Book: http://www.bnext.com.tw/article/view/id/37578
蘋果iPhone在美市佔續增，Android陣營當心: http://www.bnext.com.tw/article/view/id/37581
打入Tesla 生態圈，網路第一代創業家賀元再現江湖 !: http://www.bnext.com.tw/article/view/id/37580
棉花糖系統開放更新！Now on Tap秘密武器正式出關！: http://www.bnext.com.tw/article/view/id/37568
Evernote的啟示：少了這個前提，商業計畫再完美也沒用！: http://www.bnext.com.tw/ext_rss/view/id/985113
賈伯斯去世4年了！為了紀念他，庫克寫了封email給員工: http://www.bnext.com.tw/ext_rss/view/id/988425
你真的知道Retina是什麼嗎？那些蘋果創造出來的技術名詞，你知道多少？: http://www.bnext.com.tw/ext_rss/view/id/985760

```



## Test the scraper

```
$ ruby bnext_robot_spec.rb

```


