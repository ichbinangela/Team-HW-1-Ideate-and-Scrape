# Business Next Scraper
This is a scraper that collects articles and article-related information from the website [Business Next](http://www.bnext.com.tw/).

## Usage
robot/lib/ext_class/**bnext_robot.rb**
```
bot = BNextRobot.new; bot.show_day_rank

bot.show_day_rank
# It will return *titles* and the *links* of daily hot news.

bot.show_week_rank
# It will return *titles* and the *links* of weekly hot news.
```

## Test file
robot/spec/class_spec/**bnext_robot_spec.rb**

## Drafts
[hackpad](https://soa_group4.hackpad.com/Team-Assignment-1-lAgKeRX5LlB)
