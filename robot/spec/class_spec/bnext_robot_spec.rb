require 'minitest/autorun'
require_relative '../../lib/ext_class/bnext_robot'

week_rank = [
    "給GOGORO 一個掌聲，勇於認錯是成功的第一步: http://www.bnext.com.tw/article/view/id/37530",
    "Gogoro再推新車，這次價格只要62000元起: http://www.bnext.com.tw/article/view/id/37528",
    "[專訪]Gogoro行銷副總彭明義：市場會不會給犯了錯的人一次機會？: http://www.bnext.com.tw/article/view/id/37546",
    "只有聰明還不夠！成為 Google 重點栽培的人才，一定要有這4個能力: http://www.bnext.com.tw/article/view/id/37550",
    "專業，就是用對方聽得懂的話，去告訴他不懂的事情: http://www.bnext.com.tw/article/view/id/37573",
    "[數位書選]只要利潤讓你吃得起泡麵，就請大膽創業！麥肯錫顧問看見創業者的6項修練！: http://www.bnext.com.tw/article/view/id/37553",
    "法國3D動畫師讓宮崎駿角色齊聚一堂，連《玩具總動員》導演都大喊：趕快雇用他！: http://www.bnext.com.tw/article/view/id/37552",
    "如何在1年內讀60本書？: http://www.bnext.com.tw/article/view/id/37551"
]
day_rank = [
    "專業，就是用對方聽得懂的話，去告訴他不懂的事情: http://www.bnext.com.tw/article/view/id/37573",
    "Surface名氣愈來愈旺！微軟趁勝追擊推出首款自家筆電Surface Book: http://www.bnext.com.tw/article/view/id/37578",
    "蘋果iPhone在美市佔續增，Android陣營當心: http://www.bnext.com.tw/article/view/id/37581",
    "打入Tesla 生態圈，網路第一代創業家賀元再現江湖 !: http://www.bnext.com.tw/article/view/id/37580",
    "棉花糖系統開放更新！Now on Tap秘密武器正式出關！: http://www.bnext.com.tw/article/view/id/37568",
    "Evernote的啟示：少了這個前提，商業計畫再完美也沒用！: http://www.bnext.com.tw/ext_rss/view/id/985113",
    "賈伯斯去世4年了！為了紀念他，庫克寫了封email給員工: http://www.bnext.com.tw/ext_rss/view/id/988425",
    "你真的知道Retina是什麼嗎？那些蘋果創造出來的技術名詞，你知道多少？: http://www.bnext.com.tw/ext_rss/view/id/985760",
    "全新個人化官方帳號，LINE變身行動銀行！: http://goo.gl/kI3je0"
]

describe "Get correct day rank articles" do

    before do
        @bnext_robot = BNextRobot.new
        @bnext_robot.web_data = File.open( "../testfiles/mainpage/bnext_mainpage.html" ).read
        @bnext_robot.analyze
        @bnext_robot.init_rank_feeds
    end

    it 'has the right number of daily articles' do
        @bnext_robot.day_rank_feeds.size.must_equal day_rank.size
    end

    it 'has the right content' do
        content = []
        @bnext_robot.day_rank_feeds.map { |feed| content << "#{feed.title}: #{feed.link}" }
        content.must_equal day_rank
    end
end

describe "Get correct week rank articles" do

    before do
        @bnext_robot = BNextRobot.new
        @bnext_robot.web_data = File.open( "../testfiles/mainpage/bnext_mainpage.html" ).read
        @bnext_robot.analyze
        @bnext_robot.init_rank_feeds
    end

    it 'has the right number of daily articles' do
        @bnext_robot.week_rank_feeds.size.must_equal week_rank.size
    end

    it 'has the right content' do
        content = []
        @bnext_robot.week_rank_feeds.map { |feed| content << "#{feed.title}: #{feed.link}" }
        content.must_equal week_rank
    end
end
