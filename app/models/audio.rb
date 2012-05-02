class Audio < ActiveRecord::Base
  belongs_to :user
  has_many :lexemes
  has_many :syntagms
end
