#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'user_stream'
require 'twitter'
require 'pp'

  consumer_key = gets.chomp
  consumer_secret = gets.chomp
  oauth_token = gets.chomp
  oauth_token_secret = gets.chomp

UserStream.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
end

Twitter.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
end

client = UserStream.client

def check_tags tags,tag_text
  
  tags.each do |tag|
    return true if tag.text == tag_text
  end
  false
end

def reply tweet
  
  option = {"in_reply_to_status_id"=>tweet.id}
  msg = "@#{tweet.user.screen_name} クーラーください"
  
  Twitter.update msg,option
end

client.user do |status|
  if status.has_key? "text"
    if !status.entities.hashtags.empty?
      if check_tags(status.entities.hashtags , "ギークハウス沖縄")
        reply status
      end
    end
  end
end

