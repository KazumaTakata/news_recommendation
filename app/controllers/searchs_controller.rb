require 'elasticsearch'


class SearchsController < ApplicationController
  def index
  end

  def show
    params["search_word"]
    elastic = Elastic.new
    result = elastic.search(params["search_word"])


    @posts = []
    result["hits"]["hits"].each do |hits|
      @posts.push(Post.find(hits["_source"]["id"]))
    end

  end

end


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

