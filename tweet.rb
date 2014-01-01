#!/usr/bin/env ruby
require 'tweetstream'
require 'yaml'

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

tweet_prefix = "( っ'ω'c)"
tweet = tweet_prefix + ARGV[0];
if tweet.length > 140
    tweet = tweet[0..139]
end


Twitter.update(tweet);
