#!/usr/bin/env ruby
require 'tweetstream'
require 'yaml'
require './random_tweet'

begin
    path = File.expand_path(File.dirname(__FILE__))
    SETTINGS = YAML::load(open(path + "/conf/token.conf"))
rescue
    puts "Config file load failed."
    exit
end

TweetStream.configure do |config|
    config.consumer_key = SETTINGS["CONSUMER_KEY"]
    config.consumer_secret = SETTINGS["CONSUMER_SECRET"]
    config.oauth_token = SETTINGS["OAUTH_TOKEN"]
    config.oauth_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
    config.auth_method = :oauth
end

Twitter.configure do |config|
    config.consumer_key = SETTINGS["CONSUMER_KEY"]
    config.consumer_secret = SETTINGS["CONSUMER_SECRET"]
    config.oauth_token = SETTINGS["OAUTH_TOKEN"]
    config.oauth_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
end

client = TweetStream::Client.new
client.track('@crow_0096_bot ') do |status|
    puts status.id
    puts "#{status.user.screen_name}(#{status.user.name}): #{status.text}"

    tweet_prefix = "( っ'ω'c)"

    bot_tweet = BotTweet.new
    bot_tweet.create_tweet
    tweet = bot_tweet.get_tweet

    tweet = "@#{status.user.screen_name} #{tweet_prefix}#{tweet}"
    if tweet.length > 140
        tweet = tweet[0..139]
    end
    puts tweet
    Twitter.update(tweet, :in_reply_to_status_id => status.id)
end
