# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# {{{ users
admin = User.create(
  :email => 'admin@test.com',
  :password => 'admin',
  :password_confirmation => 'admin',
)

admin.toggle!(:admin)

author = User.create(
  :email => 'author@test.com',
  :password => 'author',
  :password_confirmation => 'author',
  :permissions => ['author'],
)

editor = User.create(
  :email => 'editor@test.com',
  :password => 'editor',
  :password_confirmation => 'editor',
  :permissions => ['editor'],
)
# }}}
# {{{ tweets
tweet1 = Tweet.create(
  :tweet => 'This is the first tweet',
  :author => author,
)

tweet2 = Tweet.create(
  :tweet => 'This is the second tweet',
  :author => author,
)

tweet3 = Tweet.create(
  :tweet => 'This is the third tweet',
  :author => author,
)

tweet4 = Tweet.create(
  :tweet => 'This is the fourth tweet',
  :author => author,
)

tweet5 = Tweet.create(
  :tweet => 'This is the fifth tweet',
  :author => author,
)
# }}}
# {{{ corrections
correct1 = Correction.create(
  :proper => 'Hello',
  :improper => [ 'hello', 'HeLlO', 'HellO', 'HeLLo' ],
)

correct2 = Correction.create(
  :proper => 'Tweet',
  :improper => [ 'tweet', 'TwEeT', 'TweeT', 'TwEEt' ],
)

correct3 = Correction.create(
  :proper => 'World',
  :improper => [ 'world', 'WoRlD', 'WorlD', 'WoRLd' ],
)
# }}}
# {{{ settings
Setting['twitter.consumer_key'] = "17l8xYWOQ6Hoakrz5v1Fxw"
Setting['twitter.consumer_secret'] = "hRWqM118d48NrC3Hh53zIlRMeammrV1Y0XdO5AOBk"
Setting['twitter.oauth_token'] = "1149713065-UIhuqw7elBhI4uaLb7eEQJ7FToUEXzojy2PZsIZ"
Setting['twitter.oauth_token_secret'] = "cccOgobXpcupxh1AGNUNWROLxV56vveG7LTbpmcNNes"
Setting['dirty_words'] = [ 'Big Box', 'house', 'bubble' ]
# }}}
