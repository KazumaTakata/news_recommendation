require "mysql2"

class Sql 

  def initialize(database_name) 
    begin
      @client = Mysql2::Client.new(:host => "localhost", :username => "root")
      @client.query("create database if not exists football")
      @client.query("use #{database_name}")
      #@client.query("CREATE TABLE IF NOT EXISTS posts(id INT PRIMARY KEY AUTO_INCREMENT, title TEXT, content TEXT, url TEXT )")
    rescue Mysql2::Error => e 
      puts e.errno
      puts e.error
    end
  end


  def insert(title,source , content, main_content, url, photourl, category, date)
    @client.query("INSERT ignore INTO posts(title, source , content, main_content, url, photourl, category ,created_at, updated_at, date) VALUES('#{title}', '#{source}' ,'#{content}',  '#{main_content}','#{url}', '#{photourl}', '#{category}' ,'#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}', '#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}', '#{date}' )")
  end

  def last_inserted_id
    @client.last_id
  end

  def read
    returned = []
    result = @client.query("select * from posts")
    result.each do |row|
      returned = returned << row 
    end
    returned
  end

  def deleteAll
    @client.query("delete from posts")
  end

end



