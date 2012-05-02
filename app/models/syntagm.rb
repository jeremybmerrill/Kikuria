# encoding: UTF-8

class Syntagm < ActiveRecord::Base
  belongs_to :user

  has_many :comments, :as => :commentable
  belongs_to :audio
  
  validates :token, :presence => true
  validates :gloss, :presence => true

  def toOrth(item) #for backwards compatibility
    return Lexeme.toOrth(item)
  end
  def toDisplayOrth(item, prefs)
    return Lexeme.toDisplayOrth(item, prefs)
  end
end
