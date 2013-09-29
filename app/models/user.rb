class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates :password, :presence =>true,
                    :length => { :minimum => 5, :maximum => 40 },
                    :confirmation =>true
  validates :email, email_format: { message: "doesn't look like an email address" }                    
end
