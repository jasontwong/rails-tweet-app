class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet, :length => 140
      t.references :author, :class_name => 'User'
      t.references :editor, :class_name => 'User'
      t.datetime :moderation_date
      t.datetime :publish_date
      t.boolean :needs_moderation, :default => true
      t.boolean :for_editors, :default => false
      t.string :moderation_reasons
      t.integer :retweet_count, :default => 0
      t.string :twitter_id

      t.timestamps
    end
  end
end
