require 'net/http'
require 'nokogiri'
require './sql.rb'
require './elastic.rb'

def normalize_category(category)
  case category  
  when"Jリーグ", "日本代表", "なでしこ", "国内その他", "国内"
    "japan"
  when "海外日本人"
    "japanese"
  when "ワールド", "メガクラブ", "スペイン", "イタリア", "イングランド", "オランダ", "海外", "海外その他"
    "foreign"    
  when "移籍情報"
    "transfer"
  else 
    "other"
  end
end

$image_url_regex = /[a-z\-: ]*\(([a-zA-Z_ \/:.\-0-9]*)\)/


def scrape_soccerking(category, page_id)

  elastic = Elastic.new

  source = "サッカーキング"
  responce = Nokogiri::HTML(Net::HTTP.get(URI("https://www.soccer-king.jp/news/#{category}/page/#{page_id}")))
  newslist = responce.css(".listpage_wrap article")
  sql = Sql.new("football_news_development")

  newslist.each { |news| 
    title = news.css(".tit").text
    category = normalize_category news.css(".cate").text
    url = news.css("a")[0].attributes["href"].value

    puts "thread #{page_id}"
    puts title
    puts url


    responce = Nokogiri::HTML(Net::HTTP.get(URI(url)))
    date = ''
    begin
      date = Date.strptime(responce.css(".date").text, "%Y.%m.%d")
    rescue ArgumentError
      date = DateTime.now    
    end

    photourl_css = responce.css(".article_img").css(".img")[0].attributes["style"].value 
    photourl = photourl_css.match($image_url_regex).captures[0].strip
    main_content = responce.css(".article_txt > p").text  
    content =  responce.css(".article_txt  p")[0].text 
    sql.insert(title, source , content, main_content ,url, photourl, category, date.strftime("%Y-%m-%d"))
    if sql.last_inserted_id != 0 
      elastic.insert(title, content, sql.last_inserted_id)
    end
  }

end


def scrape_soccerdiget(page_id)

  elastic = Elastic.new

  source = "サッカーダイジェスト"
  responce = Nokogiri::HTML(Net::HTTP.get(URI("https://www.soccerdigestweb.com/?pageID=#{page_id}")))
  newslist = responce.css(".news_list")
  sql = Sql.new("football_news_development")

  newslist.css(".entry").each { |news|
    date = Date.strptime(news.css(".date").text, "%Y年%m月%d日" )
    title = news.css(".title")[0].text
    category = normalize_category news.css(".category")[0].children[0].attributes["alt"].value
    #photourl = news.css(".pic").css("img")[0].attributes["src"].value 
    content = news.css(".read").text.delete("\t\n\r ")
    url = news.css(".title")[0].children[0].attributes["href"].value


    puts title
    puts url

    responce = Nokogiri::HTML(Net::HTTP.get(URI(url)))
    photo = responce.css(".content_detail").css(".pic2").css("img")[0]

    if photo == nil
      photo = responce.css(".content_detail").css(".pic").css("img")[0]
    end

    photourl = nil
    if photo 
      photourl = photo.attributes["src"].value
    end

    main_content = responce.css(".content_detail").css(".text").text
    sql.insert(title,source  ,content, main_content ,url, photourl, category, date)
    if sql.last_inserted_id != 0 
      elastic.insert(title, content, sql.last_inserted_id)
    end
  }
end

def scrape_new()
  scrape_soccerdiget 0
end

if __FILE__ == $0
  threads = []
  10.times do |n| 
    threads <<  Thread.new { scrape_soccerdiget n }
  end

  ["japan", "world"].each { |category|
    10.times do |n| 
      threads << Thread.new {scrape_soccerking category, n }
    end
  }
  threads.each(&:join) 
   
end
#for n in 0..10
#puts n
#scrape_soccerdiget n
#end

