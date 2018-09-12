username = "xiaoheifish" # GitHub 用户名
new_token = "0b8a48702e7a557c855f37776ff2c6b8c51e2ede"  # GitHub Token
repo_name = "xiaoheifish.github.io" # 存放 issues
sitemap_url = "D:\\blog\\githubblog\\xiaoheiblog\\_site\\sitemap.xml" # sitemap
kind = "Gitalk" # "Gitalk" or "gitment"

require 'open-uri'
require 'faraday'
require 'active_support'
require 'active_support/core_ext'
require 'sitemap-parser'

sitemap = SitemapParser.new sitemap_url
urls = sitemap.to_a

conn = Faraday.new(:url => "https://api.github.com/repos/#{username}/#{repo_name}/issues") do |conn|
  conn.basic_auth(username, new_token)
  conn.adapter  Faraday.default_adapter
end

urls.each_with_index do |url, index|
  title = open(url).read.scan(/<title>(.*?)<\/title>/).first.first.force_encoding('UTF-8')
  response = conn.post do |req|
    req.body = { body: url, labels: [kind, title], title: title}.to_json
  puts req.body
  end
  puts response.body
  sleep 15 if index % 20 == 0
end