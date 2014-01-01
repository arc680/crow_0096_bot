class BotTweet
    @@tweet = ""
    def create_simple_tweet(cnt = 5)
        tweet = ""
        keys = ["！", "？"]
        cnt.times do
            tweet = tweet + keys[rand(keys.length)]
        end

        return tweet
    end

    def create_nya_tweet(cnt = 5)
        tweet = ""
        cnt.times do
            tweet = tweet + "にゃ"
        end

        if rand(2) == 1
            tweet = tweet + "ー"
        end

        return tweet
    end

    def create_tweet()
        cnt = rand(10) + 1
        if rand(2) == 1
            @@tweet = create_simple_tweet(cnt)
        else
            @@tweet = create_nya_tweet(cnt)
        end
    end

    def get_tweet()
        return @@tweet
    end
end

