class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_secure_password
#  validates_presence_of :password, :on => :create
  validates_confirmation_of :password, :on => :create
  validates :password, :presence =>true,
                    :length => { :minimum => 5, :maximum => 40 },
                    :confirmation =>true, :on => :create
  validates :email, uniqueness: { case_sensitive: false }, email_format: { message: "doesn't look like an email address" }
  def self.tilgang(roller)
  	roller.each { |x| 
  		return false unless @user.groups.include(x)
  	 }
  end
end
