class User < ActiveRecord::Base

  after_initialize :set_default_permissions

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :permissions, :admin

  serialize :permissions

  has_many :authored_tweets, :class_name => 'Tweet', :foreign_key => 'author_id'
  has_many :edited_tweets, :class_name => 'Tweet', :foreign_key => 'editor_id'

  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email = '', password = '')
    find_by_email(email).try(:authenticate, password)
  end

  def has_perms?(perms)
    if self.admin?
      return true
    else
      perms_check = Set.new(perms)
      perms_have = Set.new(self.permissions)
      perms_check.subset? perms_have
    end
  end

  def has_perm?(perm)
    self.has_perms?([perm])
  end

  private

  def set_default_permissions
    self.permissions ||= []
  end

end
