require 'elasticsearch'

class Elastic

  def initialize 
    @client = Elasticsearch::Client.new url:"localhost:9200"
  end

  def insert(title, content, id)
    @client.index index: 'my-index', body: { title: title, content: content, id: id }
  end

  def search(query)
    @client.search index: 'my-index', body: { query:
                                             {bool: 
                                              {should: [
                                                { 
                                                  match: {title: query} 
                                                },  
                                                { 
                                                  match: {content: query} 
                                                }] 
                                              }}}
  end

end

