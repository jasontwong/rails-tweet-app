class Tweet < ActiveRecord::Base
  
  attr_accessible :tweet, :author, :editor

  belongs_to :author, :class_name => 'User'
  belongs_to :editor, :class_name => 'User'

  serialize :moderation_reasons

  validates_length_of :tweet, :minimum => 1, :message => "Can't have a blank tweet!"

  # {{{ def capitals?
  def capitals?
    !self.tweet.scan(/\b[[:upper:]]+\b/).empty?
  end
  # }}}
  # {{{ def dirty?(words = [])
  def dirty?(words = [])
    # tweet = self.tweet.downcase.sub(/[-_]+/, ' ')
    tweet = self.tweet.downcase

    if words.empty?
      words = Setting.dirty_words ||= []
    end
    
    words.each do |w|
      unless tweet.scan(w.downcase).empty?
        return true
      end
    end

    return false
  end
  # }}}
  # {{{ def moderate?
  def moderate?
    self.moderation_reasons = []

    # TODO: how can we dynamically call these functions? register them?
    if self.dirty?
      self.moderation_reasons << 'dirty'
    end

    if self.capitals?
      self.moderation_reasons << 'capitals'
    end

    if self.moderation_reasons.length > 0
      self.moderation_date = Time.now
      self.for_editors = true
    else
      return false
    end
  end
  # }}}
  # {{{ def publish?
  def publish?
    begin
      client = Twitter::Client.new(
        :consumer_key => Setting['twitter.consumer_key'],
        :consumer_secret => Setting['twitter.consumer_secret'],
        :oauth_token => Setting['twitter.oauth_token'],
        :oauth_token_secret => Setting['twitter.oauth_token_secret'],
      )
      tweet = client.update(self.tweet)
      self.twitter_id = tweet.id
      self.for_editors = false
      self.publish_date = Time.now
      self.needs_moderation = false
    rescue Twitter::Error::Unauthorized
      return false
    end
  end
  # }}}
  # {{{ def retweet_count
  def retweet_count
    begin
      client = Tweet.get_client
      tweets = client.retweets(self.twitter_id, { :trim_user => true })
      self.retweet_count = tweets.length
    rescue Twitter::Error::Unauthorized
      return self.retweet_count
    end
  end
  # }}}

  private
  # {{{ def self.get_client(credentials = {})
  def self.get_client(credentials = {})
    credentials[:consumer_key] ||= Setting['twitter.consumer_key']
    credentials[:consumer_secret] ||= Setting['twitter.consumer_secret']
    credentials[:oauth_token] ||= Setting['twitter.oauth_token']
    credentials[:oauth_token_secret] ||= Setting['twitter.oauth_token_secret']
    Twitter::Client.new(
      :consumer_key => credentials[:consumer_key],
      :consumer_secret => credentials[:consumer_secret],
      :oauth_token => credentials[:oauth_token],
      :oauth_token_secret => credentials[:oauth_token_secret],
    )
  end
  # }}}

end
