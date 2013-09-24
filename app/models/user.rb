class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_secure_password
  validates_presence_of :password, :on => :create
end
