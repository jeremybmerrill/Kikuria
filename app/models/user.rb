# encoding: UTF-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  has_many :lexemes
  has_many :syntagms
  has_many :comments

  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :preferredOrth, :displayname, :profilestuff
end
