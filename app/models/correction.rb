class Correction < ActiveRecord::Base
  
  attr_accessible :proper, :improper
  serialize :improper

  def self.autocorrect_all(text)
    self.find_each do |c|
      c.improper.each { |key| text.gsub!(key, c.proper) }
    end

    return text
  end

end
